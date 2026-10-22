import 'package:injectable/injectable.dart';
import 'package:applock/domain/repository/app_tracking_repository.dart';
import 'package:applock/network/data_source/app_tracking_data_source.dart';
import 'package:applock/utility/helper/result.dart';

@LazySingleton(as: AppTrackingRepository)
class AppTrackingRepositoryImpl implements AppTrackingRepository {
  const AppTrackingRepositoryImpl({required this.remoteDataSource});

  final AppTrackingDataSource remoteDataSource;

  @override
  Future<Result<void>> sendInstallEvent({String? fcmToken}) async {
    try {
      await remoteDataSource.trackInstall({'fcm_token': fcmToken});
      return const Result.success(null);
    } catch (error) {
      return Result.error(error);
    }
  }
}
