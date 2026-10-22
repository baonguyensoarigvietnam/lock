import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:applock/application/view_model/global_view_model.dart';
import 'package:applock/application/view_model/global_view_model_state.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({
    super.key,
    this.adSize = .banner,
    this.padding,
    this.useAdaptiveSize = false,
  });

  /// Default:
  /// AdSize.banner (320 x 50)
  ///
  /// Other common values:
  /// - AdSize.mediumRectangle (300 x 250)
  /// - AdSize.largeBanner (320 x 100)
  final AdSize adSize;

  final EdgeInsets? padding;

  /// When true, the ad size is calculated adaptively based on
  /// the available width of the screen / container.
  final bool useAdaptiveSize;

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;

  bool _isLoaded = false;
  bool _isLoading = false;

  AdSize? _adSize;
  double? _lastAvailableWidth;

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
        if (constraints.hasBoundedWidth && constraints.maxWidth > 0) {
          _lastAvailableWidth = constraints.maxWidth;
        }

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

        // No ad loaded yet -> do not occupy any space.
        if (ad == null || !_isLoaded || adSize == null) {
          return const SizedBox.shrink();
        }

        final double adHeight = (adSize.height > 0)
            ? adSize.height.toDouble()
            : 50.0;
        final double adWidth = (adSize.width > 0)
            ? adSize.width.toDouble()
            : MediaQuery.sizeOf(context).width;

        final adWidget = Center(
          child: SizedBox(
            width: adWidth,
            height: adHeight,
            child: AdWidget(ad: ad),
          ),
        );

        // Apply padding only when the ad is actually available.
        if (widget.padding != null) {
          return Padding(padding: widget.padding!, child: adWidget);
        }

        return adWidget;
      },
    );
  }

  Future<void> _loadAd({double? availableWidth}) async {
    if (!mounted) return;

    if (_isLoading) {
      return;
    }

    if (_bannerAd != null) {
      return;
    }

    if (_globalViewModel.state.isPro) {
      return;
    }

    if (!_globalViewModel.state.isAdmobReady) {
      return;
    }

    _isLoading = true;

    final adSize = await _resolveAdSize(availableWidth ?? _lastAvailableWidth);

    if (!mounted) {
      _isLoading = false;
      return;
    }

    if (_globalViewModel.state.isPro) {
      _isLoading = false;
      return;
    }

    if (adSize == null) {
      _isLoading = false;
      return;
    }

    _adSize = adSize;
    _isLoaded = false;

    late final BannerAd bannerAd;
    bannerAd = _globalViewModel.createBannerAd(
      adSize: adSize,
      onLoaded: () async {
        _isLoading = false;

        if (!mounted) return;

        // Query platform for actual rendered height if available
        try {
          final platformSize = await bannerAd.getPlatformAdSize();
          if (platformSize != null && mounted) {
            _adSize = platformSize;
          }
        } catch (e) {
          debugPrint('[BannerAdWidget] getPlatformAdSize error: $e');
        }

        if (!mounted) return;

        setState(() {
          _isLoaded = true;
        });
      },
      onFailed: (error) {
        debugPrint('[BannerAdWidget] Ad failed to load: $error');
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

  Future<AdSize?> _resolveAdSize([double? availableWidth]) async {
    if (!widget.useAdaptiveSize) {
      return widget.adSize;
    }

    final width = (availableWidth ?? _getAvailableWidth()).toInt();

    if (width <= 0) {
      return widget.adSize;
    }

    // Anchored adaptive banner size is standard for adaptive banners
    try {
      final anchoredSize = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(
        width,
      );
      if (anchoredSize != null) {
        return anchoredSize;
      }
    } catch (e) {
      debugPrint('[BannerAdWidget] Error resolving anchored adaptive size: $e');
    }

    // Fallback to standard banner
    return AdSize.banner;
  }

  double _getAvailableWidth() {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final availableWidth = screenWidth - 40;

    return availableWidth > 0 ? availableWidth : 320;
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
