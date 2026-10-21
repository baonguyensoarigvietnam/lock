import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:applock/application/view_model/global_view_model.dart';
import 'package:applock/application/view_model/global_view_model_state.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';

class NativeAdWidget extends StatefulWidget {
  const NativeAdWidget({
    super.key,
    this.templateType = TemplateType.medium,
    this.width,
    this.height,
    this.padding,
    this.isTablet,
    this.isLandscape,
  });

  final TemplateType templateType;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final bool? isTablet;
  final bool? isLandscape;

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;

  bool _isLoaded = false;
  bool _isLoading = false;

  late final GlobalViewModel _globalViewModel;

  @override
  void initState() {
    super.initState();

    _globalViewModel = context.read<GlobalViewModel>();

    if (_globalViewModel.state.isAdmobReady && !_globalViewModel.state.isPro) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _loadAd();
        }
      });
    }
  }

  @override
  void dispose() {
    final ad = _nativeAd;
    _nativeAd = null;

    if (ad != null) {
      _globalViewModel.disposeNativeAd(ad);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GlobalViewModel, GlobalViewModelState>(
      listenWhen: (previous, current) {
        final admobBecameReady = !previous.isAdmobReady && current.isAdmobReady;
        final proStatusChanged = previous.isPro != current.isPro;
        return admobBecameReady || proStatusChanged;
      },
      listener: (_, state) {
        if (!mounted) return;

        if (state.isPro) {
          _disposeAd();
          return;
        }

        if (state.isAdmobReady) {
          _loadAd();
        }
      },
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_globalViewModel.state.isPro) {
      return const SizedBox.shrink();
    }

    final ad = _nativeAd;

    if (ad == null || !_isLoaded) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: _buildAdContainer(ad),
    );
  }

  Widget _buildAdContainer(NativeAd ad) {
    if (widget.templateType == TemplateType.small) {
      return _buildSmallAd(ad);
    }
    return _buildMediumAd(ad);
  }

  Widget _buildSmallAd(NativeAd ad) {
    final height = widget.height ?? 120.0;
    final maxWidth = _getMaxWidth(
      defaultWidth: 400.0,
      tabletLandscapeWidth: 700.0,
    );
    final width = _resolveWidth(maxWidth: maxWidth, minWidth: 320.0);

    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: AdWidget(ad: ad),
      ),
    );
  }

  Widget _buildMediumAd(NativeAd ad) {
    final height = widget.height ?? 320.0;
    final maxWidth = _getMaxWidth(
      defaultWidth: 610.0,
      tabletLandscapeWidth: 700.0,
    );
    final width = _resolveWidth(maxWidth: maxWidth, minWidth: 320.0);

    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: AdWidget(ad: ad),
      ),
    );
  }

  double _getMaxWidth({
    required double defaultWidth,
    required double tabletLandscapeWidth,
  }) {
    final isTabletLandscape =
        widget.isTablet == true && widget.isLandscape == true;
    return isTabletLandscape ? tabletLandscapeWidth : defaultWidth;
  }

  double _resolveWidth({required double maxWidth, required double minWidth}) {
    final requestedWidth = widget.width;
    if (requestedWidth != null) {
      return requestedWidth.clamp(minWidth, maxWidth);
    }
    return maxWidth;
  }

  Future<void> _loadAd() async {
    if (!mounted) return;
    if (_globalViewModel.state.isPro) return;
    if (!_globalViewModel.state.isAdmobReady) return;
    if (_nativeAd != null || _isLoading) return;

    _isLoading = true;

    _nativeAd = _globalViewModel.createNativeAd(
      nativeTemplateStyle: _buildTemplateStyle(),
      onLoaded: () {
        _isLoading = false;
        if (!mounted) return;
        setState(() {
          _isLoaded = true;
        });
      },
      onFailed: (_) {
        _isLoading = false;

        final ad = _nativeAd;
        _nativeAd = null;
        _isLoaded = false;

        if (ad != null) {
          _globalViewModel.disposeNativeAd(ad);
        }

        if (!mounted) return;
      },
    );
  }

  NativeTemplateStyle _buildTemplateStyle() {
    return NativeTemplateStyle(
      templateType: widget.templateType,
      mainBackgroundColor: AppColorsPalette.white,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: AppColorsPalette.white,
        backgroundColor: AppColorsPalette.black,
        style: NativeTemplateFontStyle.bold,
        size: 14.0,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: AppColorsPalette.slate900,
        style: NativeTemplateFontStyle.bold,
        size: 14.0,
      ),
      secondaryTextStyle: NativeTemplateTextStyle(
        textColor: AppColorsPalette.gray500,
        style: NativeTemplateFontStyle.normal,
        size: 12.0,
      ),
      tertiaryTextStyle: NativeTemplateTextStyle(
        textColor: AppColorsPalette.gray500,
        style: NativeTemplateFontStyle.normal,
        size: 12.0,
      ),
    );
  }

  void _disposeAd() {
    final ad = _nativeAd;

    _nativeAd = null;
    _isLoaded = false;
    _isLoading = false;

    if (ad != null) {
      _globalViewModel.disposeNativeAd(ad);
    }

    if (mounted) {
      setState(() {});
    }
  }
}
