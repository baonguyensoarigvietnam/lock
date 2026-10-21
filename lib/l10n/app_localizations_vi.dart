// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'AppLock';

  @override
  String get appLockTitle => 'Khóa Ứng Dụng';

  @override
  String get continueButton => 'Tiếp tục';

  @override
  String get getStartedButton => 'Bắt đầu';

  @override
  String get skipButton => 'Bỏ qua';

  @override
  String get cancelButton => 'Hủy';

  @override
  String get saveButton => 'Lưu';

  @override
  String get doneButton => 'Hoàn tất';

  @override
  String get resetButton => 'Đặt lại';

  @override
  String get deleteAction => 'Xóa';

  @override
  String get infoAction => 'Thông tin';

  @override
  String get seeAllAction => 'Xem tất cả';

  @override
  String get navHome => 'Trang chủ';

  @override
  String get navApps => 'Ứng dụng';

  @override
  String get navVault => 'Kho lưu trữ';

  @override
  String get navAlerts => 'Cảnh báo';

  @override
  String get navSettings => 'Cài đặt';

  @override
  String get splashSubtitle => 'Bảo vệ nội dung riêng tư của bạn';

  @override
  String get onboardingStep1Title => 'Bảo vệ quyền riêng tư';

  @override
  String get onboardingStep1Desc =>
      'Giữ ảnh, video riêng tư và quyền truy cập nhạy cảm được bảo vệ trên thiết bị này.';

  @override
  String get onboardingStep2Title => 'Bảo vệ cục bộ trên thiết bị';

  @override
  String get onboardingStep2Subtitle =>
      'Dữ liệu của bạn không bao giờ rời khỏi thiết bị.';

  @override
  String get onboardingNoAccountTitle => 'Không cần tài khoản';

  @override
  String get onboardingNoAccountDesc =>
      'Chúng tôi không yêu cầu email hoặc số điện thoại để sử dụng ứng dụng.';

  @override
  String get onboardingNoCloudTitle => 'Không đồng bộ đám mây';

  @override
  String get onboardingNoCloudDesc =>
      'Dữ liệu của bạn không bao giờ được tải lên máy chủ hay đám mây bên ngoài.';

  @override
  String get onboardingNoRecoveryTitle => 'Không khôi phục qua máy chủ';

  @override
  String get onboardingNoRecoveryDesc =>
      'Nếu bạn quên mã PIN, chúng tôi không thể khôi phục dữ liệu giúp bạn.';

  @override
  String get onboardingVaultStaysTitle => 'Tệp lưu trữ luôn ở đây';

  @override
  String get onboardingVaultStaysDesc =>
      'Mọi thứ được bảo mật trong kho lưu trữ đều nằm hoàn toàn trên thiết bị này.';

  @override
  String get unlockMethodTitle => 'Thiết lập phương thức mở khóa';

  @override
  String get unlockMethodSubtitle =>
      'Chọn cách bạn sẽ mở khóa nội dung riêng tư của mình.';

  @override
  String get createPinTitle => 'Tạo mã PIN';

  @override
  String get createPinSubtitle => 'Mã số từ 4-8 chữ số';

  @override
  String get drawPatternTitle => 'Vẽ hình mở khóa';

  @override
  String get drawPatternSubtitle => 'Nối ít nhất 4 điểm';

  @override
  String get unlockMethodWarning =>
      'Hãy giữ kỹ mã này. Dữ liệu kho lưu trữ không thể khôi phục nếu bạn quên và chưa bật sinh trắc học dự phòng.';

  @override
  String get createYourPinTitle => 'Tạo mã PIN của bạn';

  @override
  String get confirmYourPinTitle => 'Xác nhận mã PIN';

  @override
  String get changePasscodeTitle => 'Đổi mật mã';

  @override
  String get confirmYourPasscodeTitle => 'Xác nhận mật mã';

  @override
  String get usePinToAccessSubtitle =>
      'Sử dụng mã PIN này để truy cập nội dung được bảo vệ.';

  @override
  String get reEnterPinSubtitle => 'Nhập lại mã PIN để xác nhận.';

  @override
  String get reEnterPinShort => 'Nhập lại mã PIN của bạn.';

  @override
  String get pinDoesNotMatchError => 'Mã PIN không khớp.';

  @override
  String get usePatternInstead => 'Sử dụng hình vẽ thay thế';

  @override
  String get usePinInstead => 'Sử dụng mã PIN thay thế';

  @override
  String get drawUnlockPatternTitle => 'Vẽ hình mở khóa';

  @override
  String get confirmYourPatternTitle => 'Xác nhận hình vẽ';

  @override
  String get connectAtLeast4Dots => 'Nối ít nhất 4 điểm.';

  @override
  String get drawPatternAgainConfirm => 'Vẽ lại hình mở khóa để xác nhận.';

  @override
  String get patternDoesNotMatchError => 'Hình vẽ không khớp';

  @override
  String get enableBiometricTitle => 'Bật sinh trắc học dự phòng';

  @override
  String get enableBiometricSubtitle =>
      'Sử dụng vân tay hoặc khuôn mặt trên thiết bị để lấy lại quyền truy cập khi cần.';

  @override
  String get fasterUnlockTitle => 'Mở khóa nhanh hơn';

  @override
  String get fasterUnlockSubtitle =>
      'Truy cập nhanh kho lưu trữ mà không cần nhập mã.';

  @override
  String get usesDeviceSecurityTitle => 'Sử dụng bảo mật thiết bị';

  @override
  String get usesDeviceSecuritySubtitle =>
      'Tận dụng phần cứng sinh trắc học tích hợp sẵn.';

  @override
  String get helpsForgetPinTitle => 'Hỗ trợ khi bạn quên mã PIN';

  @override
  String get helpsForgetPinSubtitle =>
      'Phương thức thay thế an toàn để đăng nhập lại.';

  @override
  String get biometricInfoNote =>
      'Sinh trắc học dự phòng chỉ hoạt động nếu được bật trước khi bạn quên mã PIN.';

  @override
  String get enableBiometricButton => 'Bật sinh trắc học';

  @override
  String get setUpPermissionsTitle => 'Thiết lập quyền truy cập';

  @override
  String get permissionGuideSubtitle =>
      'Bật các quyền cần thiết cho Khóa Ứng Dụng, Kho Lưu Trữ và cảnh báo bảo mật. Bạn có thể bỏ qua các tính năng tùy chọn và bật sau.';

  @override
  String get usageAccessTitle => 'Quyền truy cập sử dụng';

  @override
  String get usageAccessDesc =>
      'Phát hiện khi ứng dụng được bảo vệ mở ra để hiển thị màn hình mở khóa.';

  @override
  String get displayOverOtherAppsTitle => 'Hiển thị trên ứng dụng khác';

  @override
  String get displayOverOtherAppsDesc =>
      'Hiển thị màn hình mở khóa đè lên ứng dụng được bảo vệ để hoạt động ổn định hơn.';

  @override
  String get notificationsTitle => 'Thông báo';

  @override
  String get notificationsDesc =>
      'Hiển thị trạng thái bảo vệ, cảnh báo bảo mật và cảnh báo quyền truy cập.';

  @override
  String get cameraTitle => 'Máy ảnh';

  @override
  String get cameraDesc =>
      'Chụp ảnh bằng camera trước sau 3 lần mở khóa thất bại.';

  @override
  String get badgeRequired => 'BẮT BUỘC';

  @override
  String get badgeRecommended => 'KHUYẾN NGHỊ';

  @override
  String get badgeIntruder => 'XÂM NHẬP';

  @override
  String get upgradeToPremium => 'Nâng cấp lên Premium';

  @override
  String get paywallSubtitle =>
      'Mở khóa thêm nhiều giao diện và gỡ bỏ quảng cáo.';

  @override
  String get paywallFeatureThemes => 'Giao diện cao cấp mới';

  @override
  String get paywallFeatureVault => 'Kho lưu trữ không giới hạn';

  @override
  String get paywallFeatureAlerts => 'Toàn bộ lịch sử cảnh báo xâm nhập';

  @override
  String get paywallFeatureNoAds => 'Không quảng cáo';

  @override
  String get monthlyPlanTitle => 'Hàng tháng';

  @override
  String get monthlyPlanSubtitle => 'Thanh toán mỗi tháng';

  @override
  String get yearlyPlanTitle => 'Hàng năm';

  @override
  String get yearlyPlanSubtitle => 'Thanh toán hàng năm';

  @override
  String get save40Badge => 'TIẾT KIỆM 40%';

  @override
  String wasPrice(String price) {
    return 'giá gốc $price';
  }

  @override
  String get startPremiumButton => 'Bắt đầu Premium';

  @override
  String get restorePurchases => 'Khôi phục giao dịch';

  @override
  String get termsLink => 'Điều khoản';

  @override
  String get privacyPolicyLink => 'Chính sách bảo mật';

  @override
  String unlockAppTitle(String appName) {
    return 'Mở khóa $appName';
  }

  @override
  String get enterPinToContinue => 'Nhập mã PIN của bạn để tiếp tục.';

  @override
  String get incorrectPinTryAgain => 'Mã PIN không đúng. Vui lòng thử lại.';

  @override
  String get incorrectPatternTryAgain =>
      'Hình vẽ không đúng. Vui lòng thử lại.';

  @override
  String get forgotPinLink => 'Quên mã PIN?';

  @override
  String get forgotPatternLink => 'Quên hình vẽ?';

  @override
  String get useBiometricUnlockTitle => 'Mở khóa bằng sinh trắc học';

  @override
  String get unlockWithDeviceAuthSubtitle =>
      'Mở khóa bằng xác thực của thiết bị.';

  @override
  String get biometricNotRecognized => 'KHÔNG NHẬN DIỆN ĐƯỢC SINH TRẮC HỌC';

  @override
  String get recoverAccessTitle => 'Khôi phục quyền truy cập';

  @override
  String get useBiometricFallbackCardTitle => 'Dùng sinh trắc học dự phòng';

  @override
  String get useBiometricFallbackCardDesc =>
      'Xác thực bằng sinh trắc học của thiết bị, sau đó tạo mã PIN hoặc hình vẽ mới.';

  @override
  String get authenticateButton => 'Xác thực';

  @override
  String get vaultCannotBeRecoveredTitle => 'Không thể khôi phục kho lưu trữ';

  @override
  String get vaultCannotBeRecoveredDesc =>
      'Nếu không có mã PIN, hình vẽ hoặc sinh trắc học dự phòng, dữ liệu mã hóa trong kho sẽ không thể khôi phục.';

  @override
  String get resetAppSecurityButton => 'Đặt lại bảo mật ứng dụng';

  @override
  String get backToUnlockLink => 'Quay lại mở khóa';

  @override
  String get resetSecurityQuestionTitle => 'Đặt lại bảo mật?';

  @override
  String get resetSecurityWarningDesc =>
      'Thao tác này sẽ xóa khóa bảo mật.\nDữ liệu mã hóa trong kho lưu trữ sẽ không thể\ntruy cập được nữa.';

  @override
  String get resetSecurityConfirmCheckbox =>
      'Tôi hiểu thao tác này không thể\nhoàn tác';

  @override
  String get statusActive => 'ĐANG BẬT';

  @override
  String get statusIdle => 'ĐANG TẮT';

  @override
  String get appsProtectedLabel => 'Ứng dụng được bảo vệ';

  @override
  String get vaultItemsLabel => 'Mục trong kho';

  @override
  String get intruderAlertsLabel => 'Cảnh báo xâm nhập';

  @override
  String get biometricFallbackLabel => 'Sinh trắc học dự phòng';

  @override
  String get quickActionsTitle => 'Thao tác nhanh';

  @override
  String get lockAppsAction => 'Khóa ứng dụng';

  @override
  String get themesAction => 'Giao diện';

  @override
  String get promoBannerTitle => 'MỞ KHÓA TẤT CẢ TÍNH NĂNG';

  @override
  String get promoBannerSubtitle =>
      'Không giới hạn giao diện, không quảng cáo và hơn thế nữa.';

  @override
  String get themeMinimal => 'Tối giản';

  @override
  String get themeClassicPin => 'PIN cổ điển';

  @override
  String get themePattern => 'Hình vẽ';

  @override
  String get themeVault => 'Kho lưu trữ';

  @override
  String get themeFocus => 'Tập trung';

  @override
  String get themePremiumColors => 'Màu sắc cao cấp';

  @override
  String get premiumBadge => 'CAO CẤP';

  @override
  String get applyThemeButton => 'Áp dụng giao diện';

  @override
  String get themeAppliedTitle => 'Đã áp dụng giao diện';

  @override
  String get themeAppliedSubtitle =>
      'Màn hình khóa của bạn hiện đã sử dụng\ngiao diện vừa chọn.';

  @override
  String get premiumColorPreviewTitle => 'Xem trước màu cao cấp';

  @override
  String get premiumThemesSubscriptionNote =>
      'Giao diện cao cấp khả dụng khi đăng ký gói.';

  @override
  String get backToThemesButton => 'Quay lại giao diện';

  @override
  String get lockedAppsHeader => 'Ứng dụng đã khóa';

  @override
  String protectedAppsCount(int count) {
    return '$count ứng dụng được bảo vệ';
  }

  @override
  String get searchAppsHint => 'Tìm kiếm ứng dụng...';

  @override
  String get filterAll => 'Tất cả';

  @override
  String get filterCategories => 'Danh mục';

  @override
  String get filterLocked => 'Đã khóa';

  @override
  String categoryChipLabel(String category) {
    return 'Danh mục: $category';
  }

  @override
  String get noLockedAppsFound => 'Không tìm thấy ứng dụng đã khóa';

  @override
  String get noAppsFound => 'Không tìm thấy ứng dụng';

  @override
  String get categorySocial => 'Mạng xã hội';

  @override
  String get categoryMessaging => 'Nhắn tin';

  @override
  String get categoryPhotosVideo => 'Ảnh & Video';

  @override
  String get categoryFinance => 'Tài chính';

  @override
  String get categoryShopping => 'Mua sắm';

  @override
  String get categorySystem => 'Hệ thống';

  @override
  String categoryAppsBullet(int count) {
    return '$count ứng dụng • ';
  }

  @override
  String categoryProtectedCount(int count) {
    return '$count đã bảo vệ';
  }

  @override
  String get usageAccessRequiredTitle => 'Cần quyền truy cập sử dụng';

  @override
  String get usageAccessRequiredDesc =>
      'Bật quyền truy cập sử dụng để bảo vệ các\nứng dụng đã chọn.';

  @override
  String get enableUsageAccessButton => 'Bật quyền truy cập sử dụng';

  @override
  String get protectionMayBeLimitedTitle => 'Bảo vệ có thể bị hạn chế';

  @override
  String get protectionMayBeLimitedDesc =>
      'Để đảm bảo Khóa Ứng Dụng hoạt động ổn định trong nền, vui lòng kiểm tra các cài đặt hệ thống Android sau.';

  @override
  String get displayOverOtherAppsWarningDesc =>
      'Cần thiết để hiển thị màn hình khóa trên các ứng dụng được bảo vệ. Nếu tắt, ứng dụng sẽ không được khóa.';

  @override
  String get statusDisabled => 'Đã tắt';

  @override
  String get batteryOptimizationTitle => 'Tối ưu hóa pin';

  @override
  String get batteryOptimizationDesc =>
      'Android có thể đóng Khóa Ứng Dụng chạy nền. Hãy tắt tối ưu hóa pin để duy trì trạng thái bảo vệ.';

  @override
  String get statusRestricted => 'Bị giới hạn';

  @override
  String get fixPermissionsButton => 'Khắc phục quyền';

  @override
  String get continueWithLimitedProtectionButton =>
      'Tiếp tục với bảo vệ hạn chế';

  @override
  String itemsProtectedCount(int count) {
    return 'Đã bảo vệ $count/100 mục';
  }

  @override
  String get encryptedOnThisDevice => 'Được mã hóa trên thiết bị này';

  @override
  String get quickActionsSmallTitle => 'Thao tác nhanh';

  @override
  String get addPhotosAction => 'Thêm\nẢnh';

  @override
  String get importVideosAction => 'Nhập\nVideo';

  @override
  String get albumsHeader => 'Album';

  @override
  String get vaultEmptyTitle => 'Kho lưu trữ đang trống';

  @override
  String get vaultEmptySubtitle =>
      'Nhập ảnh và video để giữ chúng\nđược mã hóa trên thiết bị này.';

  @override
  String get albumVideos => 'Video';

  @override
  String get albumPhotos => 'Ảnh';

  @override
  String vaultAlbumItemsCount(int count) {
    return '$count mục';
  }

  @override
  String vaultItemsProtectedSubtitle(int count) {
    return '$count mục • Đã bảo vệ';
  }

  @override
  String get encryptingItemsTitle => 'Đang mã hóa các mục đã chọn...';

  @override
  String filesProcessedProgress(int processed, int total) {
    return 'Đã xử lý $processed/$total tệp';
  }

  @override
  String get keepAppOpenWarning =>
      'Hãy mở Khóa Ứng Dụng cho đến khi quá trình nhập hoàn tất.';

  @override
  String get importCompleteTitle => 'Nhập hoàn tất';

  @override
  String get importCompleteSubtitle =>
      'Dữ liệu của bạn hiện đã được bảo mật và mã hóa.';

  @override
  String itemsEncryptedTitle(int count) {
    return 'Đã mã hóa $count mục';
  }

  @override
  String get aes256Subtitle => 'Chuẩn quân đội AES-256';

  @override
  String get originalsCouldNotBeDeletedTitle =>
      'Không thể tự động xóa\ncác tệp gốc';

  @override
  String get nextStepRequiredTitle => 'Bước tiếp theo cần thực hiện';

  @override
  String get deleteOriginalsManuallyDesc =>
      'Mở Ảnh hoặc Bộ sưu tập để xóa\ncác tệp gốc theo cách thủ công.';

  @override
  String get viewVaultButton => 'Xem Kho lưu trữ';

  @override
  String get backToVaultHomeLink => 'Về trang chủ Kho lưu trữ';

  @override
  String get fileInfoTitle => 'Thông tin tệp';

  @override
  String get protectedBadge => 'Đã bảo vệ';

  @override
  String get propertiesHeader => 'Thuộc tính';

  @override
  String get propertyName => 'Tên';

  @override
  String get propertyType => 'Loại';

  @override
  String get propertySize => 'Kích thước';

  @override
  String get propertyImportedDate => 'Ngày nhập';

  @override
  String get propertyEncryptionStatus => 'Trạng thái mã hóa';

  @override
  String get intruderSelfieOffTitle => 'Chụp ảnh kẻ xâm nhập đang tắt';

  @override
  String get intruderSelfieOffSubtitle =>
      'Bật tính năng này để chụp ảnh sau 3 lần\nmở khóa thất bại.';

  @override
  String get secureLogsTitle => 'Nhật ký bảo mật';

  @override
  String get secureLogsSubtitle =>
      'Xem ngày, giờ và hình ảnh của các\nlần truy cập trái phép.';

  @override
  String get stealthCaptureTitle => 'Chụp ẩn danh';

  @override
  String get stealthCaptureSubtitle =>
      'Camera trước sẽ chụp ảnh một cách\nâm thầm.';

  @override
  String get enableIntruderSelfieButton => 'Bật chụp ảnh kẻ xâm nhập';

  @override
  String get cameraPermissionDeniedTitle => 'Quyền máy ảnh bị từ chối';

  @override
  String get cameraPermissionDeniedSubtitle =>
      'Các sự kiện xâm nhập vẫn có thể được ghi lại\nmà không cần ảnh chụp.';

  @override
  String get intruderLoggingTitle => 'Ghi nhật ký xâm nhập';

  @override
  String get intruderLoggingSubtitle =>
      'Thời gian, ngày tháng và các lần thử mã PIN vẫn sẽ\nđược lưu trong kho bảo mật.';

  @override
  String get privacyFirstTitle => 'Ưu tiên quyền riêng tư';

  @override
  String get privacyFirstSubtitle =>
      'Không có bức ảnh nào được chụp hoặc lưu trữ nếu\nbạn không cấp quyền máy ảnh.';

  @override
  String get openSettingsButton => 'Mở cài đặt';

  @override
  String get statusSummaryTitle => 'Tóm tắt trạng thái';

  @override
  String failedMethodLabel(String method) {
    return 'Phương thức thất bại: $method';
  }

  @override
  String get viewDetailsAction => 'Xem chi tiết';

  @override
  String get keepFullAlertHistoryTitle => 'Lưu toàn bộ lịch sử cảnh báo';

  @override
  String get keepFullAlertHistoryDesc =>
      'Người dùng miễn phí chỉ xem được 10 cảnh báo\ngần nhất. Nâng cấp để lưu trữ không giới hạn.';

  @override
  String get alertDetailTitle => 'Chi tiết cảnh báo';

  @override
  String get noPhotoCapturedTitle => 'Không có ảnh chụp';

  @override
  String get noPhotoCapturedDesc =>
      'Hệ thống bảo mật không thể\nkhởi tạo máy ảnh trong sự kiện\nnày.';

  @override
  String get eventSummaryHeader => 'TÓM TẮT SỰ KIỆN';

  @override
  String get highAlertBadge => 'Cảnh báo cao';

  @override
  String get captureAnalysisTitle => 'Phân tích ghi nhận';

  @override
  String get attemptedContextLabel => 'Ngữ cảnh truy cập';

  @override
  String get failedMethodRowLabel => 'Phương thức thất bại';

  @override
  String get failedCountLabel => 'Số lần thất bại';

  @override
  String get dateTimeLabel => 'Ngày/giờ';

  @override
  String get saveEvidenceButton => 'Lưu bằng chứng';

  @override
  String get enableCameraPermissionButton => 'Bật quyền máy ảnh';

  @override
  String get deleteAlertButton => 'Xóa cảnh báo';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get settingsSubtitle => 'Quản lý tùy chọn ứng dụng của bạn.';

  @override
  String get freePlanTitle => 'Gói Miễn Phí';

  @override
  String get freeBadge => 'MIỄN PHÍ';

  @override
  String get freePlanDesc =>
      'Nâng cấp lên Premium để mở khóa các tính năng\nbảo mật nâng cao.';

  @override
  String get securitySectionHeader => 'Bảo mật';

  @override
  String get biometricUnlockTitle => 'Mở khóa sinh trắc học';

  @override
  String get biometricUnlockSubtitle => 'Sử dụng Face ID / Vân tay';

  @override
  String get autoLockDelayTitle => 'Độ trễ tự động khóa';

  @override
  String get helpAndSupportHeader => 'Trợ giúp & Hỗ trợ';

  @override
  String get languagesTitle => 'Ngôn ngữ';

  @override
  String get contactUsTitle => 'Liên hệ chúng tôi';

  @override
  String get termsOfServiceTitle => 'Điều khoản dịch vụ';

  @override
  String get requireAuthenticationTitle => 'Yêu cầu xác thực';

  @override
  String get requireAuthenticationSubtitle =>
      'Chọn thời gian ứng dụng tự động khóa sau khi bạn\nrời đi. Thời gian ngắn hơn giúp bảo vệ quyền riêng tư\ntốt hơn.';

  @override
  String get delayImmediately => 'Ngay lập tức';

  @override
  String get delay15Seconds => 'Sau 15 giây';

  @override
  String get delay30Seconds => 'Sau 30 giây';

  @override
  String get delay1Minute => 'Sau 1 phút';

  @override
  String get delayScreenOff => 'Khi màn hình tắt';

  @override
  String get settingLanguagesTitle => 'Cài đặt ngôn ngữ';

  @override
  String get settingLanguagesSubtitle =>
      'Chọn ngôn ngữ ưu tiên của bạn cho giao diện\nvà nhận dạng tài liệu.';

  @override
  String get langEnglish => 'Tiếng Anh (English)';

  @override
  String get langVietnamese => 'Tiếng Việt';

  @override
  String get langSpanish => 'Tiếng Tây Ban Nha (Spanish)';

  @override
  String get langFrench => 'Tiếng Pháp (French)';

  @override
  String get langGerman => 'Tiếng Đức (German)';

  @override
  String get langJapanese => 'Tiếng Nhật (Japanese)';

  @override
  String get langChinese => 'Tiếng Trung (Chinese)';

  @override
  String get contactUsIntro =>
      'Chúng tôi luôn sẵn sàng hỗ trợ. Hãy điền biểu mẫu bên dưới\nvà đội ngũ hỗ trợ sẽ phản hồi bạn sớm nhất\ncó thể.';

  @override
  String get emailAddressLabel => 'Địa chỉ Email';

  @override
  String get emailHint => 'ban@vidu.com';

  @override
  String get subjectLabel => 'Tiêu đề';

  @override
  String get subjectHint => 'Tóm tắt ngắn gọn vấn đề của bạn';

  @override
  String get messageLabel => 'Nội dung';

  @override
  String get messageHint => 'Mô tả chi tiết vấn đề của bạn...';

  @override
  String get contactPrivacyDisclaimer =>
      'Bằng việc gửi biểu mẫu này, bạn đồng ý với Chính sách bảo mật của chúng tôi.\nChúng tôi chỉ dùng email của bạn để phản hồi yêu cầu này.';

  @override
  String get sendMessageButton => 'Gửi tin nhắn';

  @override
  String get biometricNotSupportedError =>
      'Thiết bị không hỗ trợ hoặc chưa cài sinh trắc học';

  @override
  String get deleteFromVaultDialogTitle => 'Xóa khỏi Kho lưu trữ?';

  @override
  String get deleteFromVaultDialogDesc =>
      'Thao tác này sẽ xóa bản sao mã hóa trong kho khỏi thiết bị này.';

  @override
  String get deletePermanentlyButton => 'Xóa vĩnh viễn';

  @override
  String get deleteAlertDialogTitle => 'Xóa cảnh báo?';

  @override
  String get deleteAlertDialogDesc =>
      'Thao tác này sẽ xóa ảnh chụp kẻ xâm nhập và nhật ký sự kiện khỏi thiết bị này.';

  @override
  String get purchaseFallbackMonthlyPrice => '\$2.99';

  @override
  String get purchaseFallbackYearlyPrice => '\$25.99';

  @override
  String get purchaseFallbackYearlyOriginalPrice => '\$35.99';

  @override
  String purchaseSaveBadge(int percent) {
    return 'TIẾT KIỆM $percent%';
  }

  @override
  String get purchaseBillingUnavailable =>
      'Google Play Billing không khả dụng trên thiết bị này. Hãy kiểm tra tài khoản Play Store và thử lại.';

  @override
  String get purchaseProductsNotFound =>
      'Các gói Premium hiện không khả dụng. Vui lòng thử lại sau.';

  @override
  String get purchaseProductsLoading =>
      'Đang tải các gói, vui lòng thử lại sau giây lát.';

  @override
  String get purchaseFailed => 'Thanh toán thất bại. Vui lòng thử lại.';

  @override
  String get purchasePending =>
      'Giao dịch của bạn đang chờ xử lý. Premium sẽ được mở khóa khi thanh toán hoàn tất.';

  @override
  String get purchaseRestoreSuccess =>
      'Đã khôi phục giao dịch. Premium đã được kích hoạt.';

  @override
  String get purchaseRestoreNothing => 'Không tìm thấy giao dịch trước đó.';

  @override
  String get purchaseRestoreFailed =>
      'Không thể khôi phục giao dịch. Vui lòng thử lại.';

  @override
  String get purchaseAlreadyPremium => 'Bạn đã là thành viên Premium';

  @override
  String get purchaseOpenLinkFailed => 'Không thể mở liên kết.';

  @override
  String intruderFailedAttemptsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lần mở khóa sai hôm nay',
      zero: 'Không có lần mở khóa sai nào hôm nay',
    );
    return '$_temp0';
  }

  @override
  String intruderAlertsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã lưu $count cảnh báo',
      zero: 'Chưa lưu cảnh báo nào',
    );
    return '$_temp0';
  }

  @override
  String intruderAlertsShownOfTotal(int shown, int total) {
    return 'Đang hiển thị $shown trên $total cảnh báo đã lưu';
  }

  @override
  String get intruderMethodPin => 'Mã PIN';

  @override
  String get intruderMethodPattern => 'Hình vẽ';

  @override
  String get intruderMethodBiometric => 'Sinh trắc học';

  @override
  String get intruderMainUnlock => 'Mở khóa chính';

  @override
  String get intruderYesterday => 'Hôm qua';

  @override
  String intruderEvidenceSavedTo(String path) {
    return 'Đã lưu bằng chứng vào $path';
  }

  @override
  String get intruderEvidenceSaveFailed => 'Không thể lưu bằng chứng';

  @override
  String get intruderAlertDeleted => 'Đã xóa cảnh báo';

  @override
  String get intruderDeleteFailed => 'Không thể xóa cảnh báo';

  @override
  String get intruderNoAlertsTitle => 'Chưa có cảnh báo xâm nhập';

  @override
  String get intruderNoAlertsSubtitle =>
      'Sau 3 lần mở khóa sai, App Lock sẽ âm thầm chụp ảnh kẻ xâm nhập và lưu tại đây.';

  @override
  String get lockBiometricReason => 'Xác thực danh tính để mở khoá';

  @override
  String get lockEnableBiometricReason =>
      'Xác thực để bật mở khoá bằng sinh trắc học';

  @override
  String get lockDeviceAuthReason => 'Xác minh bằng khoá màn hình của thiết bị';

  @override
  String get lockDeviceNotSecureError =>
      'Hãy thiết lập khoá màn hình cho thiết bị để khôi phục quyền truy cập.';

  @override
  String get lockAuthFailedError => 'Xác thực thất bại. Vui lòng thử lại.';

  @override
  String get lockUsageAccessNeeded =>
      'Hãy cấp quyền Truy cập dữ liệu sử dụng để bắt đầu bảo vệ.';

  @override
  String get lockPasscodeUpdated => 'Đã cập nhật mã PIN';

  @override
  String get lockPatternUpdated => 'Đã cập nhật hình vẽ';

  @override
  String get lockSaveFailed => 'Không thể lưu. Vui lòng thử lại.';

  @override
  String get lockPremiumPlanTitle => 'Gói Premium';

  @override
  String get lockPremiumPlanDesc => 'Tất cả tính năng Premium đã được mở khoá.';

  @override
  String get lockContactFormIncomplete =>
      'Vui lòng nhập email và nội dung tin nhắn.';

  @override
  String get lockContactInvalidEmail => 'Vui lòng nhập địa chỉ email hợp lệ.';

  @override
  String lockContactNoEmailApp(String email) {
    return 'Không tìm thấy ứng dụng email. Vui lòng gửi tới $email';
  }

  @override
  String get lockOpenLinkFailed => 'Không thể mở liên kết.';

  @override
  String get lockBatteryOptimizationTitle => 'Tối ưu hoá pin';

  @override
  String get lockBatteryOptimizationDesc =>
      'Đặt App Lock là \"Không tối ưu hoá\" để bảo vệ luôn hoạt động.';

  @override
  String vaultItemsProtectedUnlimited(int count) {
    return 'Đã bảo vệ $count mục';
  }

  @override
  String get vaultLimitReachedTitle => 'Đã đạt giới hạn kho lưu trữ';

  @override
  String vaultLimitReachedDesc(int limit) {
    return 'Gói miễn phí bảo vệ tối đa $limit mục. Nâng cấp lên Premium để lưu trữ không giới hạn.';
  }

  @override
  String get vaultUpgradeButton => 'Nâng cấp';

  @override
  String get vaultOperationFailed => 'Đã xảy ra lỗi. Vui lòng thử lại.';

  @override
  String vaultSizeBytes(String size) {
    return '$size B';
  }

  @override
  String vaultSizeKb(String size) {
    return '$size KB';
  }

  @override
  String vaultSizeMb(String size) {
    return '$size MB';
  }

  @override
  String vaultSizeGb(String size) {
    return '$size GB';
  }

  @override
  String vaultItemSubtitle(String date, String size) {
    return '$date • $size';
  }

  @override
  String get vaultEncryptionAes256 => 'AES-256';

  @override
  String get vaultTypePhoto => 'Ảnh';

  @override
  String get vaultTypeVideo => 'Video';

  @override
  String get vaultPhotosEmptyTitle => 'Chưa có ảnh';

  @override
  String get vaultVideosEmptyTitle => 'Chưa có video';

  @override
  String get vaultDetailEmptySubtitle =>
      'Nhấn + để chọn mục bằng trình chọn ảnh của hệ thống. Chúng được mã hoá trên thiết bị này.';

  @override
  String get vaultPreviewUnavailable => 'Không thể xem trước';

  @override
  String get appsCategoryOther => 'Khác';
}
