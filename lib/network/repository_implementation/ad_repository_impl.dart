import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/advertisement.dart';
import 'package:applock/domain/repository/ad_repository.dart';
import 'package:applock/network/data_source/ad_remote_data_source.dart';
import 'package:applock/utility/helper/result.dart';

@LazySingleton(as: AdRepository)
class AdRepositoryImpl implements AdRepository {
  const AdRepositoryImpl({required this.remoteDataSource});

  final AdRemoteDataSource remoteDataSource;

  @override
  Future<Result<int>> getFullscreenAdFrequency() async {
    try {
      final response = await remoteDataSource.getFullscreenAdFrequency();
      return Result.success(response.toDomain());
    } catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> sendAdEvent({
    required String targetAppId,
    required AdEvent event,
  }) async {
    try {
      await remoteDataSource.sendAdsEvent({
        'promoted_app_id': targetAppId,
        'event': event.name,
      });
      return const Result.success(null);
    } catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<Advertisement>> getCrossPromotionAd() async {
    try {
      final response = await remoteDataSource.getCrossPromotionAd();
      return Result.success(response.toDomain());
    } catch (error) {
      return Result.error(error);
    }
  }
}
