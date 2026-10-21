import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:applock/application/view_model/global_view_model.dart';
import 'package:applock/application/view_model/global_view_model_state.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({
    super.key,
    this.adSize = AdSize.mediumRectangle,
    this.padding,
    this.useAdaptiveSize = false,
  });

  final AdSize adSize;
  final EdgeInsets? padding;
  final bool useAdaptiveSize;

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;

  bool _isLoaded = false;
  bool _isLoading = false;

  AdSize? _adSize;

  late final GlobalViewModel _globalViewModel;

  @override
  void initState() {
    super.initState();

    _globalViewModel = context.read<GlobalViewModel>();

    if (_globalViewModel.state.isAdmobReady && !_globalViewModel.state.isPro) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _loadAd();
      });
    }
  }

  @override
  void dispose() {
    _disposeAd(updateState: false);
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
      child: BlocBuilder<GlobalViewModel, GlobalViewModelState>(
        buildWhen: (previous, current) => previous.isPro != current.isPro,
        builder: (_, state) {
          if (state.isPro) {
            return const SizedBox.shrink();
          }

          return _buildAd();
        },
      ),
    );
  }

  Widget _buildAd() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (widget.useAdaptiveSize &&
            _bannerAd == null &&
            !_isLoading &&
            constraints.hasBoundedWidth &&
            constraints.maxWidth > 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            _loadAd(availableWidth: constraints.maxWidth);
          });
        }

        final ad = _bannerAd;
        final adSize = _adSize;

        if (ad == null || !_isLoaded || adSize == null) {
          return const SizedBox.shrink();
        }

        final adWidget = Center(
          child: SizedBox(
            width: adSize.width.toDouble(),
            height: adSize.height.toDouble(),
            child: AdWidget(ad: ad),
          ),
        );

        if (widget.padding != null) {
          return Padding(padding: widget.padding!, child: adWidget);
        }

        return adWidget;
      },
    );
  }

  Future<void> _loadAd({double? availableWidth}) async {
    if (!mounted) return;
    if (_isLoading) return;
    if (_bannerAd != null) return;
    if (_globalViewModel.state.isPro) return;
    if (!_globalViewModel.state.isAdmobReady) return;

    _isLoading = true;

    final adSize = await _resolveAdSize();

    if (!mounted) {
      _isLoading = false;
      return;
    }

    if (_globalViewModel.state.isPro || adSize == null) {
      _isLoading = false;
      return;
    }

    _adSize = adSize;
    _isLoaded = false;

    final bannerAd = _globalViewModel.createBannerAd(
      adSize: adSize,
      onLoaded: () {
        _isLoading = false;
        if (!mounted) return;
        setState(() {
          _isLoaded = true;
        });
      },
      onFailed: (_) {
        _isLoading = false;
        if (!mounted) return;
        _disposeAd();
      },
    );

    _bannerAd = bannerAd;

    if (!mounted) {
      _globalViewModel.disposeBannerAd(bannerAd);
      return;
    }

    setState(() {});
  }

  Future<AdSize?> _resolveAdSize() async {
    if (!widget.useAdaptiveSize) {
      return _getFixedAdSize();
    }

    final width = _getAvailableWidth();
    if (width <= 0) {
      return null;
    }

    return AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
      width.toInt(),
    );
  }

  AdSize _getFixedAdSize() {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final availableWidth = screenWidth - context.w(40);

    if (widget.adSize == AdSize.mediumRectangle && availableWidth < 300) {
      return AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
        availableWidth.toInt(),
      );
    }

    return widget.adSize;
  }

  double _getAvailableWidth() {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return screenWidth - context.w(40);
  }

  void _disposeAd({bool updateState = true}) {
    final ad = _bannerAd;

    _bannerAd = null;
    _isLoaded = false;
    _isLoading = false;
    _adSize = null;

    if (ad != null) {
      _globalViewModel.disposeBannerAd(ad);
    }

    if (updateState && mounted) {
      setState(() {});
    }
  }
}
