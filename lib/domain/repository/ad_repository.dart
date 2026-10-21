import 'package:applock/domain/model/advertisement.dart';
import 'package:applock/utility/helper/result.dart';

abstract class AdRepository {
  /// Get fullscreen ad frequency.
  Future<Result<int>> getFullscreenAdFrequency();

  /// Get cross-promotion advertisement.
  Future<Result<Advertisement>> getCrossPromotionAd();

  /// Send an advertisement interaction event (click, skip).
  Future<Result<void>> sendAdEvent({
    required String targetAppId,
    required AdEvent event,
  });
}
