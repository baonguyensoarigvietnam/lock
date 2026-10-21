export 'package:applock/utility/enumeration/ad_event.dart';

/// Plain domain model for a cross-promotion advertisement.
class Advertisement {
  const Advertisement({
    required this.appId,
    required this.headline,
    required this.imageUrl,
    required this.storeUrl,
  });

  final String appId;
  final String headline;
  final String imageUrl;
  final String storeUrl;

  @override
  String toString() =>
      'Advertisement{appId: $appId, headline: $headline, imageUrl: $imageUrl, storeUrl: $storeUrl}';
}
