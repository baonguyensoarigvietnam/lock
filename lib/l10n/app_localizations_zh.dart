// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'AppLock';

  @override
  String get appLockTitle => '应用锁';

  @override
  String get continueButton => '继续';

  @override
  String get getStartedButton => '开始使用';

  @override
  String get skipButton => '跳过';

  @override
  String get cancelButton => '取消';

  @override
  String get saveButton => '保存';

  @override
  String get doneButton => '完成';

  @override
  String get resetButton => '重置';

  @override
  String get deleteAction => '删除';

  @override
  String get infoAction => '信息';

  @override
  String get seeAllAction => '查看全部';

  @override
  String get navHome => '首页';

  @override
  String get navApps => '应用';

  @override
  String get navVault => '保险箱';

  @override
  String get navAlerts => '警报';

  @override
  String get navSettings => '设置';

  @override
  String get splashSubtitle => '保护您的私人内容';

  @override
  String get onboardingStep1Title => '保护您的隐私';

  @override
  String get onboardingStep1Desc => '在此设备上保护私人照片、视频和敏感访问权限。';

  @override
  String get onboardingStep2Title => '仅限本地保护';

  @override
  String get onboardingStep2Subtitle => '您的数据绝不会离开您的设备。';

  @override
  String get onboardingNoAccountTitle => '无需账号';

  @override
  String get onboardingNoAccountDesc => '使用本应用无需提供电子邮件或电话号码。';

  @override
  String get onboardingNoCloudTitle => '无云端同步';

  @override
  String get onboardingNoCloudDesc => '您的数据绝不会上传到任何外部服务器或云端。';

  @override
  String get onboardingNoRecoveryTitle => '无服务器端恢复';

  @override
  String get onboardingNoRecoveryDesc => '如果您忘记PIN码，我们无法为您恢复数据。';

  @override
  String get onboardingVaultStaysTitle => '保险箱文件留在本地';

  @override
  String get onboardingVaultStaysDesc => '保险箱中保护的所有内容均严格保存在此设备上。';

  @override
  String get unlockMethodTitle => '设置解锁方式';

  @override
  String get unlockMethodSubtitle => '选择解锁私人内容的方式。';

  @override
  String get createPinTitle => '创建PIN码';

  @override
  String get createPinSubtitle => '4-8位数字密码';

  @override
  String get drawPatternTitle => '绘制图案';

  @override
  String get drawPatternSubtitle => '至少连接4个点';

  @override
  String get unlockMethodWarning => '请妥善保管。如果忘记且未启用生物识别后备方案，保险箱数据将无法恢复。';

  @override
  String get createYourPinTitle => '创建您的PIN码';

  @override
  String get confirmYourPinTitle => '确认您的PIN码';

  @override
  String get changePasscodeTitle => '更改密码';

  @override
  String get confirmYourPasscodeTitle => '确认您的密码';

  @override
  String get usePinToAccessSubtitle => '使用此PIN码访问受保护的内容。';

  @override
  String get reEnterPinSubtitle => '请再次输入PIN码以确认。';

  @override
  String get reEnterPinShort => '请重新输入您的PIN码。';

  @override
  String get pinDoesNotMatchError => 'PIN码不匹配。';

  @override
  String get usePatternInstead => '改用图案解锁';

  @override
  String get usePinInstead => '改用PIN码解锁';

  @override
  String get drawUnlockPatternTitle => '绘制解锁图案';

  @override
  String get confirmYourPatternTitle => '确认您的图案';

  @override
  String get connectAtLeast4Dots => '请至少连接4个点。';

  @override
  String get drawPatternAgainConfirm => '请再次绘制图案以确认。';

  @override
  String get patternDoesNotMatchError => '图案不匹配';

  @override
  String get enableBiometricTitle => '启用生物识别后备';

  @override
  String get enableBiometricSubtitle => '需要时可使用设备的指纹或面部扫描重新获得访问权限。';

  @override
  String get fasterUnlockTitle => '更快的解锁速度';

  @override
  String get fasterUnlockSubtitle => '无需输入即可快速访问您的保险箱。';

  @override
  String get usesDeviceSecurityTitle => '使用设备安全机制';

  @override
  String get usesDeviceSecuritySubtitle => '利用内置的生物识别硬件。';

  @override
  String get helpsForgetPinTitle => '忘记PIN码时的救星';

  @override
  String get helpsForgetPinSubtitle => '一种安全的替代恢复访问方式。';

  @override
  String get biometricInfoNote => '生物识别后备仅在您忘记PIN码之前启用才有效。';

  @override
  String get enableBiometricButton => '启用生物识别';

  @override
  String get setUpPermissionsTitle => '设置权限';

  @override
  String get permissionGuideSubtitle => '启用应用锁、保险箱和安全警报所需的权限。您可以跳过可选功能并在稍后开启。';

  @override
  String get usageAccessTitle => '使用情况访问权限';

  @override
  String get usageAccessDesc => '检测所选应用何时打开，以便应用锁显示解锁屏幕。';

  @override
  String get displayOverOtherAppsTitle => '在其他应用上层显示';

  @override
  String get displayOverOtherAppsDesc => '在受保护的应用上方显示解锁屏幕，提高稳定性。';

  @override
  String get notificationsTitle => '通知';

  @override
  String get notificationsDesc => '显示保护状态、安全警报和权限警告。';

  @override
  String get cameraTitle => '相机';

  @override
  String get cameraDesc => '在3次解锁失败后使用前置摄像头拍照。';

  @override
  String get badgeRequired => '必需';

  @override
  String get badgeRecommended => '推荐';

  @override
  String get badgeIntruder => '入侵者';

  @override
  String get upgradeToPremium => '升级到高级版';

  @override
  String get paywallSubtitle => '解锁更多主题并移除广告。';

  @override
  String get paywallFeatureThemes => '更多高级主题';

  @override
  String get paywallFeatureVault => '无限容量保险箱';

  @override
  String get paywallFeatureAlerts => '完整入侵警报历史';

  @override
  String get paywallFeatureNoAds => '无广告';

  @override
  String get monthlyPlanTitle => '月度订阅';

  @override
  String get monthlyPlanSubtitle => '按月计费';

  @override
  String get yearlyPlanTitle => '年度订阅';

  @override
  String get yearlyPlanSubtitle => '按年计费';

  @override
  String get save40Badge => '立省40%';

  @override
  String wasPrice(String price) {
    return '原价 $price';
  }

  @override
  String get startPremiumButton => '开启高级版';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get termsLink => '条款';

  @override
  String get privacyPolicyLink => '隐私政策';

  @override
  String unlockAppTitle(String appName) {
    return '解锁 $appName';
  }

  @override
  String get enterPinToContinue => '输入您的PIN码以继续。';

  @override
  String get incorrectPinTryAgain => 'PIN码不正确，请重试。';

  @override
  String get incorrectPatternTryAgain => '图案不正确，请重试。';

  @override
  String get forgotPinLink => '忘记PIN码？';

  @override
  String get forgotPatternLink => '忘记图案？';

  @override
  String get useBiometricUnlockTitle => '使用生物识别解锁';

  @override
  String get unlockWithDeviceAuthSubtitle => '使用设备身份验证解锁。';

  @override
  String get biometricNotRecognized => '未识别到生物特征';

  @override
  String get recoverAccessTitle => '恢复访问权限';

  @override
  String get useBiometricFallbackCardTitle => '使用生物识别后备';

  @override
  String get useBiometricFallbackCardDesc => '使用设备生物识别进行验证，然后创建新的PIN码或图案。';

  @override
  String get authenticateButton => '验证身份';

  @override
  String get vaultCannotBeRecoveredTitle => '保险箱无法恢复';

  @override
  String get vaultCannotBeRecoveredDesc => '如果没有PIN码、图案或生物识别后备，加密的保险箱数据将无法恢复。';

  @override
  String get resetAppSecurityButton => '重置应用安全设置';

  @override
  String get backToUnlockLink => '返回解锁';

  @override
  String get resetSecurityQuestionTitle => '重置安全设置？';

  @override
  String get resetSecurityWarningDesc => '这将删除密钥信封。\n加密的保险箱数据将不再\n可访问。';

  @override
  String get resetSecurityConfirmCheckbox => '我明白此操作无法\n撤销';

  @override
  String get statusActive => '已激活';

  @override
  String get statusIdle => '空闲';

  @override
  String get appsProtectedLabel => '受保护的应用';

  @override
  String get vaultItemsLabel => '保险箱项目';

  @override
  String get intruderAlertsLabel => '入侵者警报';

  @override
  String get biometricFallbackLabel => '生物识别后备';

  @override
  String get quickActionsTitle => '快捷操作';

  @override
  String get lockAppsAction => '锁定应用';

  @override
  String get themesAction => '主题';

  @override
  String get promoBannerTitle => '解锁全部功能';

  @override
  String get promoBannerSubtitle => '无限主题、免广告及更多特权。';

  @override
  String get themeMinimal => '极简';

  @override
  String get themeClassicPin => '经典PIN码';

  @override
  String get themePattern => '图案';

  @override
  String get themeVault => '保险箱';

  @override
  String get themeFocus => '专注';

  @override
  String get themePremiumColors => '高级色彩';

  @override
  String get premiumBadge => '高级版';

  @override
  String get applyThemeButton => '应用主题';

  @override
  String get themeAppliedTitle => '主题已应用';

  @override
  String get themeAppliedSubtitle => '您的锁屏现在已使用\n所选主题。';

  @override
  String get premiumColorPreviewTitle => '高级色彩预览';

  @override
  String get premiumThemesSubscriptionNote => '订阅即可使用高级主题。';

  @override
  String get backToThemesButton => '返回主题';

  @override
  String get lockedAppsHeader => '已锁定应用';

  @override
  String protectedAppsCount(int count) {
    return '$count 个受保护应用';
  }

  @override
  String get searchAppsHint => '搜索应用...';

  @override
  String get filterAll => '全部';

  @override
  String get filterCategories => '分类';

  @override
  String get filterLocked => '已锁定';

  @override
  String categoryChipLabel(String category) {
    return '分类：$category';
  }

  @override
  String get noLockedAppsFound => '未找到已锁定的应用';

  @override
  String get noAppsFound => '未找到应用';

  @override
  String get categorySocial => '社交';

  @override
  String get categoryMessaging => '通讯';

  @override
  String get categoryPhotosVideo => '照片与视频';

  @override
  String get categoryFinance => '金融';

  @override
  String get categoryShopping => '购物';

  @override
  String get categorySystem => '系统';

  @override
  String categoryAppsBullet(int count) {
    return '$count 个应用 • ';
  }

  @override
  String categoryProtectedCount(int count) {
    return '$count 个受保护';
  }

  @override
  String get usageAccessRequiredTitle => '需要使用情况访问权限';

  @override
  String get usageAccessRequiredDesc => '启用使用情况访问权限以保护所选\n应用。';

  @override
  String get enableUsageAccessButton => '启用使用情况访问权限';

  @override
  String get protectionMayBeLimitedTitle => '保护可能受限';

  @override
  String get protectionMayBeLimitedDesc => '为确保应用锁在后台稳定运行，请检查以下Android系统设置。';

  @override
  String get displayOverOtherAppsWarningDesc => '需要在受保护的应用上方显示锁屏。否则应用将无法被锁定。';

  @override
  String get statusDisabled => '已禁用';

  @override
  String get batteryOptimizationTitle => '电池优化';

  @override
  String get batteryOptimizationDesc =>
      'Android可能会在后台强制关闭应用锁。请禁用电池优化以保持保护处于激活状态。';

  @override
  String get statusRestricted => '受限';

  @override
  String get fixPermissionsButton => '修复权限';

  @override
  String get continueWithLimitedProtectionButton => '在受限保护下继续';

  @override
  String itemsProtectedCount(int count) {
    return '已保护 $count/100 项';
  }

  @override
  String get encryptedOnThisDevice => '已在此设备上加密';

  @override
  String get quickActionsSmallTitle => '快捷操作';

  @override
  String get addPhotosAction => '添加\n照片';

  @override
  String get importVideosAction => '导入\n视频';

  @override
  String get albumsHeader => '相册';

  @override
  String get vaultEmptyTitle => '您的保险箱为空';

  @override
  String get vaultEmptySubtitle => '导入照片和视频以在此设备上\n加密保存。';

  @override
  String get albumVideos => '视频';

  @override
  String get albumPhotos => '照片';

  @override
  String vaultAlbumItemsCount(int count) {
    return '$count 项';
  }

  @override
  String vaultItemsProtectedSubtitle(int count) {
    return '$count 项 • 已受保护';
  }

  @override
  String get encryptingItemsTitle => '正在加密所选项目...';

  @override
  String filesProcessedProgress(int processed, int total) {
    return '已处理 $processed/$total 个文件';
  }

  @override
  String get keepAppOpenWarning => '在导入完成前请保持应用锁处于打开状态。';

  @override
  String get importCompleteTitle => '导入完成';

  @override
  String get importCompleteSubtitle => '您的数据现已安全加密。';

  @override
  String itemsEncryptedTitle(int count) {
    return '已加密 $count 个项目';
  }

  @override
  String get aes256Subtitle => 'AES-256 军用级加密';

  @override
  String get originalsCouldNotBeDeletedTitle => '无法自动删除\n原始文件';

  @override
  String get nextStepRequiredTitle => '需要执行下一步';

  @override
  String get deleteOriginalsManuallyDesc => '打开照片或图库以手动删除\n原始文件。';

  @override
  String get viewVaultButton => '查看保险箱';

  @override
  String get backToVaultHomeLink => '返回保险箱首页';

  @override
  String get fileInfoTitle => '文件信息';

  @override
  String get protectedBadge => '已受保护';

  @override
  String get propertiesHeader => '属性';

  @override
  String get propertyName => '名称';

  @override
  String get propertyType => '类型';

  @override
  String get propertySize => '大小';

  @override
  String get propertyImportedDate => '导入日期';

  @override
  String get propertyEncryptionStatus => '加密状态';

  @override
  String get intruderSelfieOffTitle => '入侵者抓拍已关闭';

  @override
  String get intruderSelfieOffSubtitle => '启用后将在3次解锁失败后\n自动抓拍照片。';

  @override
  String get secureLogsTitle => '安全日志';

  @override
  String get secureLogsSubtitle => '查看未经授权尝试的日期、时间和\n抓拍照片。';

  @override
  String get stealthCaptureTitle => '静默抓拍';

  @override
  String get stealthCaptureSubtitle => '前置摄像头将静默完成\n照片抓拍。';

  @override
  String get enableIntruderSelfieButton => '启用入侵者抓拍';

  @override
  String get cameraPermissionDeniedTitle => '相机权限被拒绝';

  @override
  String get cameraPermissionDeniedSubtitle => '即使没有照片，仍然可以记录\n入侵事件。';

  @override
  String get intruderLoggingTitle => '入侵日志记录';

  @override
  String get intruderLoggingSubtitle => '时间、日期和尝试的PIN码仍将\n保存在您的安全保险箱中。';

  @override
  String get privacyFirstTitle => '隐私至上';

  @override
  String get privacyFirstSubtitle => '未经您的明确相机许可，绝不会拍摄\n或存储任何照片。';

  @override
  String get openSettingsButton => '打开设置';

  @override
  String get statusSummaryTitle => '状态摘要';

  @override
  String failedMethodLabel(String method) {
    return '失败方式：$method';
  }

  @override
  String get viewDetailsAction => '查看详情';

  @override
  String get keepFullAlertHistoryTitle => '保留完整警报历史';

  @override
  String get keepFullAlertHistoryDesc => '免费用户仅能查看最近10条\n警报。升级即可无限期保存。';

  @override
  String get alertDetailTitle => '警报详情';

  @override
  String get noPhotoCapturedTitle => '未抓拍到照片';

  @override
  String get noPhotoCapturedDesc => '安全系统在此事件期间未能\n初始化相机。';

  @override
  String get eventSummaryHeader => '事件摘要';

  @override
  String get highAlertBadge => '高级警报';

  @override
  String get captureAnalysisTitle => '抓拍分析';

  @override
  String get attemptedContextLabel => '尝试访问内容';

  @override
  String get failedMethodRowLabel => '失败方式';

  @override
  String get failedCountLabel => '失败次数';

  @override
  String get dateTimeLabel => '日期/时间';

  @override
  String get saveEvidenceButton => '保存证据';

  @override
  String get enableCameraPermissionButton => '启用相机权限';

  @override
  String get deleteAlertButton => '删除警报';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsSubtitle => '管理您的应用偏好设置。';

  @override
  String get freePlanTitle => '免费版';

  @override
  String get freeBadge => '免费';

  @override
  String get freePlanDesc => '升级到高级版以获取高级安全\n功能。';

  @override
  String get securitySectionHeader => '安全';

  @override
  String get biometricUnlockTitle => '生物识别解锁';

  @override
  String get biometricUnlockSubtitle => '使用面容 ID / 触控 ID';

  @override
  String get autoLockDelayTitle => '自动锁定延迟';

  @override
  String get helpAndSupportHeader => '帮助与支持';

  @override
  String get languagesTitle => '语言';

  @override
  String get contactUsTitle => '联系我们';

  @override
  String get termsOfServiceTitle => '服务条款';

  @override
  String get requireAuthenticationTitle => '需要身份验证';

  @override
  String get requireAuthenticationSubtitle =>
      '选择离开应用后自动锁定的时间。\n较短的延迟可提供更强的隐私\n保护。';

  @override
  String get delayImmediately => '立即';

  @override
  String get delay15Seconds => '15秒后';

  @override
  String get delay30Seconds => '30秒后';

  @override
  String get delay1Minute => '1分钟后';

  @override
  String get delayScreenOff => '屏幕关闭时';

  @override
  String get settingLanguagesTitle => '语言设置';

  @override
  String get settingLanguagesSubtitle => '选择您偏好的界面和文档识别\n语言。';

  @override
  String get langEnglish => '英语 (English)';

  @override
  String get langVietnamese => '越南语 (Vietnamese)';

  @override
  String get langSpanish => '西班牙语 (Spanish)';

  @override
  String get langFrench => '法语 (French)';

  @override
  String get langGerman => '德语 (German)';

  @override
  String get langJapanese => '日语 (Japanese)';

  @override
  String get langChinese => '中文';

  @override
  String get contactUsIntro => '我们随时为您提供帮助。请填写以下表单，\n我们的支持团队将尽快回复\n您。';

  @override
  String get emailAddressLabel => '电子邮箱';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get subjectLabel => '主题';

  @override
  String get subjectHint => '简要概述您的问题';

  @override
  String get messageLabel => '留言内容';

  @override
  String get messageHint => '详细描述您遇到的问题...';

  @override
  String get contactPrivacyDisclaimer =>
      '提交此表单即表示您同意我们的隐私政策。我们\n仅会使用您的电子邮箱来回复此请求。';

  @override
  String get sendMessageButton => '发送消息';

  @override
  String get biometricNotSupportedError => '设备不支持或尚未设置生物识别';

  @override
  String get deleteFromVaultDialogTitle => '从保险箱中删除？';

  @override
  String get deleteFromVaultDialogDesc => '这将从此设备中移除加密的保险箱副本。';

  @override
  String get deletePermanentlyButton => '永久删除';

  @override
  String get deleteAlertDialogTitle => '删除警报？';

  @override
  String get deleteAlertDialogDesc => '这将从此设备中移除抓拍的入侵者照片和事件日志。';

  @override
  String get purchaseFallbackMonthlyPrice => '\$2.99';

  @override
  String get purchaseFallbackYearlyPrice => '\$25.99';

  @override
  String get purchaseFallbackYearlyOriginalPrice => '\$35.99';

  @override
  String purchaseSaveBadge(int percent) {
    return '节省 $percent%';
  }

  @override
  String get purchaseBillingUnavailable =>
      '此设备无法使用 Google Play 结算服务。请检查您的 Play 商店账号后重试。';

  @override
  String get purchaseProductsNotFound => '高级版套餐暂时不可用，请稍后再试。';

  @override
  String get purchaseProductsLoading => '正在加载套餐，请稍后再试。';

  @override
  String get purchaseFailed => '购买失败，请重试。';

  @override
  String get purchasePending => '您的购买正在处理中。付款完成后将解锁高级版。';

  @override
  String get purchaseRestoreSuccess => '购买已恢复，高级版已激活。';

  @override
  String get purchaseRestoreNothing => '未找到以前的购买记录。';

  @override
  String get purchaseRestoreFailed => '无法恢复购买，请重试。';

  @override
  String get purchaseAlreadyPremium => '您已是高级版用户';

  @override
  String get purchaseOpenLinkFailed => '无法打开链接。';

  @override
  String intruderFailedAttemptsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '今天解锁失败 $count 次',
      zero: '今天没有解锁失败记录',
    );
    return '$_temp0';
  }

  @override
  String intruderAlertsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已保存 $count 条警报',
      zero: '尚未保存警报',
    );
    return '$_temp0';
  }

  @override
  String intruderAlertsShownOfTotal(int shown, int total) {
    return '显示 $total 条已保存警报中的 $shown 条';
  }

  @override
  String get intruderMethodPin => 'PIN 码';

  @override
  String get intruderMethodPattern => '图案';

  @override
  String get intruderMethodBiometric => '生物识别';

  @override
  String get intruderMainUnlock => '主解锁';

  @override
  String get intruderYesterday => '昨天';

  @override
  String intruderEvidenceSavedTo(String path) {
    return '证据已保存到 $path';
  }

  @override
  String get intruderEvidenceSaveFailed => '无法保存证据';

  @override
  String get intruderAlertDeleted => '警报已删除';

  @override
  String get intruderDeleteFailed => '无法删除警报';

  @override
  String get intruderNoAlertsTitle => '暂无入侵者警报';

  @override
  String get intruderNoAlertsSubtitle =>
      '解锁失败 3 次后，App Lock 会悄悄拍下入侵者的照片并保存在这里。';

  @override
  String get lockBiometricReason => '请验证身份以解锁';

  @override
  String get lockEnableBiometricReason => '验证身份以启用生物识别解锁';

  @override
  String get lockDeviceAuthReason => '请使用设备锁屏验证身份';

  @override
  String get lockDeviceNotSecureError => '请先为设备设置锁屏以恢复访问。';

  @override
  String get lockAuthFailedError => '验证失败，请重试。';

  @override
  String get lockUsageAccessNeeded => '请授予使用情况访问权限以启动保护。';

  @override
  String get lockPasscodeUpdated => '密码已更新';

  @override
  String get lockPatternUpdated => '图案已更新';

  @override
  String get lockSaveFailed => '保存失败，请重试。';

  @override
  String get lockPremiumPlanTitle => '高级版';

  @override
  String get lockPremiumPlanDesc => '已解锁全部高级功能。';

  @override
  String get lockContactFormIncomplete => '请输入邮箱和留言内容。';

  @override
  String get lockContactInvalidEmail => '请输入有效的邮箱地址。';

  @override
  String lockContactNoEmailApp(String email) {
    return '未找到邮件应用，请发送至 $email';
  }

  @override
  String get lockOpenLinkFailed => '无法打开链接。';

  @override
  String get lockBatteryOptimizationTitle => '电池优化';

  @override
  String get lockBatteryOptimizationDesc => '将 App Lock 设为“不优化”以保持保护运行。';

  @override
  String vaultItemsProtectedUnlimited(int count) {
    return '已保护 $count 项';
  }

  @override
  String get vaultLimitReachedTitle => '已达到保险箱上限';

  @override
  String vaultLimitReachedDesc(int limit) {
    return '免费版最多可保护 $limit 项。升级到高级版即可无限存储。';
  }

  @override
  String get vaultUpgradeButton => '升级';

  @override
  String get vaultOperationFailed => '出现问题，请重试。';

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
  String get vaultTypePhoto => '照片';

  @override
  String get vaultTypeVideo => '视频';

  @override
  String get vaultPhotosEmptyTitle => '暂无照片';

  @override
  String get vaultVideosEmptyTitle => '暂无视频';

  @override
  String get vaultDetailEmptySubtitle => '点按 + 通过系统照片选择器选择项目。它们会在此设备上加密。';

  @override
  String get vaultPreviewUnavailable => '无法预览';

  @override
  String get appsCategoryOther => '其他';
}
