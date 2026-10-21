// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'AppLock';

  @override
  String get appLockTitle => 'App Lock';

  @override
  String get continueButton => 'Continue';

  @override
  String get getStartedButton => 'Get started';

  @override
  String get skipButton => 'Skip';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get saveButton => 'Save';

  @override
  String get doneButton => 'Done';

  @override
  String get resetButton => 'Reset';

  @override
  String get deleteAction => 'Delete';

  @override
  String get infoAction => 'Info';

  @override
  String get seeAllAction => 'See all';

  @override
  String get navHome => 'Home';

  @override
  String get navApps => 'Apps';

  @override
  String get navVault => 'Vault';

  @override
  String get navAlerts => 'Alerts';

  @override
  String get navSettings => 'Settings';

  @override
  String get splashSubtitle => 'Protect your private content';

  @override
  String get onboardingStep1Title => 'Protect your privacy';

  @override
  String get onboardingStep1Desc =>
      'Keep private photos, videos, and sensitive access protected on this device.';

  @override
  String get onboardingStep2Title => 'Local-only protection';

  @override
  String get onboardingStep2Subtitle => 'Your data never leaves your device.';

  @override
  String get onboardingNoAccountTitle => 'No account';

  @override
  String get onboardingNoAccountDesc =>
      'We don\'t ask for your email or phone number to use the app.';

  @override
  String get onboardingNoCloudTitle => 'No cloud sync';

  @override
  String get onboardingNoCloudDesc =>
      'Your data is never uploaded to any external servers or clouds.';

  @override
  String get onboardingNoRecoveryTitle => 'No server-side recovery';

  @override
  String get onboardingNoRecoveryDesc =>
      'If you lose your PIN, we cannot recover your data for you.';

  @override
  String get onboardingVaultStaysTitle => 'Vault files stay here';

  @override
  String get onboardingVaultStaysDesc =>
      'Everything secured in the vault remains strictly on this device.';

  @override
  String get unlockMethodTitle => 'Set up your unlock method';

  @override
  String get unlockMethodSubtitle =>
      'Choose how you\'ll unlock your private content.';

  @override
  String get createPinTitle => 'Create PIN';

  @override
  String get createPinSubtitle => '4-8 digit numerical code';

  @override
  String get drawPatternTitle => 'Draw pattern';

  @override
  String get drawPatternSubtitle => 'Connect at least 4 dots';

  @override
  String get unlockMethodWarning =>
      'Keep this safe. Vault data cannot be recovered if you forget it and biometric fallback is unavailable.';

  @override
  String get createYourPinTitle => 'Create your PIN';

  @override
  String get confirmYourPinTitle => 'Confirm your PIN';

  @override
  String get changePasscodeTitle => 'Change Passcode';

  @override
  String get confirmYourPasscodeTitle => 'Confirm your Passcode';

  @override
  String get usePinToAccessSubtitle =>
      'Use this PIN to access your protected content.';

  @override
  String get reEnterPinSubtitle => 'Re-enter your PIN to confirm.';

  @override
  String get reEnterPinShort => 'Re-enter your PIN.';

  @override
  String get pinDoesNotMatchError => 'PIN does not match.';

  @override
  String get usePatternInstead => 'Use pattern instead';

  @override
  String get usePinInstead => 'Use PIN instead';

  @override
  String get drawUnlockPatternTitle => 'Draw an unlock pattern';

  @override
  String get confirmYourPatternTitle => 'Confirm your pattern';

  @override
  String get connectAtLeast4Dots => 'Connect at least 4 dots.';

  @override
  String get drawPatternAgainConfirm => 'Draw your pattern again to confirm.';

  @override
  String get patternDoesNotMatchError => 'Pattern does not match';

  @override
  String get enableBiometricTitle => 'Enable biometric fallback';

  @override
  String get enableBiometricSubtitle =>
      'Use your device\'s fingerprint or face scan to regain access if needed.';

  @override
  String get fasterUnlockTitle => 'Faster unlock';

  @override
  String get fasterUnlockSubtitle =>
      'Quickly access your vault without typing.';

  @override
  String get usesDeviceSecurityTitle => 'Uses device security';

  @override
  String get usesDeviceSecuritySubtitle =>
      'Leverages built-in biometric hardware.';

  @override
  String get helpsForgetPinTitle => 'Helps if you forget your PIN';

  @override
  String get helpsForgetPinSubtitle =>
      'A secure alternative way to get back in.';

  @override
  String get biometricInfoNote =>
      'Biometric fallback only works if enabled before you forget your PIN.';

  @override
  String get enableBiometricButton => 'Enable biometric';

  @override
  String get setUpPermissionsTitle => 'Set up permissions';

  @override
  String get permissionGuideSubtitle =>
      'Enable the permissions needed for App Lock, Vault, and security alerts. You can skip optional features and turn them on later.';

  @override
  String get usageAccessTitle => 'Usage Access';

  @override
  String get usageAccessDesc =>
      'Detect when selected apps are opened so App Lock can show the unlock screen.';

  @override
  String get displayOverOtherAppsTitle => 'Display over other apps';

  @override
  String get displayOverOtherAppsDesc =>
      'Show the unlock screen over protected apps for better reliability.';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsDesc =>
      'Show protection status, security alerts, and permission warnings.';

  @override
  String get cameraTitle => 'Camera';

  @override
  String get cameraDesc =>
      'Capture a front-camera photo after 3 failed unlock attempts.';

  @override
  String get badgeRequired => 'REQUIRED';

  @override
  String get badgeRecommended => 'RECOMMENDED';

  @override
  String get badgeIntruder => 'INTRUDER';

  @override
  String get upgradeToPremium => 'Upgrade to Premium';

  @override
  String get paywallSubtitle => 'Unlock more themes and remove ads.';

  @override
  String get paywallFeatureThemes => 'Premium themes in future';

  @override
  String get paywallFeatureVault => 'Unlimited vault';

  @override
  String get paywallFeatureAlerts => 'Full intruder alert history';

  @override
  String get paywallFeatureNoAds => 'No ads';

  @override
  String get monthlyPlanTitle => 'Monthly';

  @override
  String get monthlyPlanSubtitle => 'Billed every month';

  @override
  String get yearlyPlanTitle => 'Yearly';

  @override
  String get yearlyPlanSubtitle => 'Billed annually';

  @override
  String get save40Badge => 'SAVE 40%';

  @override
  String wasPrice(String price) {
    return 'was $price';
  }

  @override
  String get startPremiumButton => 'Start Premium';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get termsLink => 'Terms';

  @override
  String get privacyPolicyLink => 'Privacy Policy';

  @override
  String unlockAppTitle(String appName) {
    return 'Unlock $appName';
  }

  @override
  String get enterPinToContinue => 'Enter your PIN to continue.';

  @override
  String get incorrectPinTryAgain => 'Incorrect PIN. Try again.';

  @override
  String get incorrectPatternTryAgain => 'Incorrect pattern. Try again.';

  @override
  String get forgotPinLink => 'Forgot PIN?';

  @override
  String get forgotPatternLink => 'Forgot Pattern?';

  @override
  String get useBiometricUnlockTitle => 'Use biometric unlock';

  @override
  String get unlockWithDeviceAuthSubtitle =>
      'Unlock with device authentication.';

  @override
  String get biometricNotRecognized => 'BIOMETRIC NOT RECOGNIZED';

  @override
  String get recoverAccessTitle => 'Recover access';

  @override
  String get useBiometricFallbackCardTitle => 'Use biometric fallback';

  @override
  String get useBiometricFallbackCardDesc =>
      'Authenticate with device biometrics, then create a new PIN or pattern.';

  @override
  String get authenticateButton => 'Authenticate';

  @override
  String get vaultCannotBeRecoveredTitle => 'Vault cannot be recovered';

  @override
  String get vaultCannotBeRecoveredDesc =>
      'Without PIN, pattern, or biometric fallback, encrypted vault data cannot be recovered.';

  @override
  String get resetAppSecurityButton => 'Reset app security';

  @override
  String get backToUnlockLink => 'Back to unlock';

  @override
  String get resetSecurityQuestionTitle => 'Reset security?';

  @override
  String get resetSecurityWarningDesc =>
      'This will delete the key envelope.\nEncrypted vault data will no longer be\naccessible.';

  @override
  String get resetSecurityConfirmCheckbox =>
      'I understand this cannot be\nundone';

  @override
  String get statusActive => 'ACTIVE';

  @override
  String get statusIdle => 'IDLE';

  @override
  String get appsProtectedLabel => 'Apps protected';

  @override
  String get vaultItemsLabel => 'Vault items';

  @override
  String get intruderAlertsLabel => 'Intruder alerts';

  @override
  String get biometricFallbackLabel => 'Biometric fallback';

  @override
  String get quickActionsTitle => 'Quick Actions';

  @override
  String get lockAppsAction => 'Lock Apps';

  @override
  String get themesAction => 'Themes';

  @override
  String get promoBannerTitle => 'UNLOCK ALL FEATURES';

  @override
  String get promoBannerSubtitle => 'Unlimited themes, free ads and more.';

  @override
  String get themeMinimal => 'Minimal';

  @override
  String get themeClassicPin => 'Classic PIN';

  @override
  String get themePattern => 'Pattern';

  @override
  String get themeVault => 'Vault';

  @override
  String get themeFocus => 'Focus';

  @override
  String get themePremiumColors => 'Premium Colors';

  @override
  String get premiumBadge => 'PREMIUM';

  @override
  String get applyThemeButton => 'Apply theme';

  @override
  String get themeAppliedTitle => 'Theme applied';

  @override
  String get themeAppliedSubtitle =>
      'Your lock screens now use the\nselected theme.';

  @override
  String get premiumColorPreviewTitle => 'Premium Color Preview';

  @override
  String get premiumThemesSubscriptionNote =>
      'Premium themes are available with subscription.';

  @override
  String get backToThemesButton => 'Back to themes';

  @override
  String get lockedAppsHeader => 'Locked Apps';

  @override
  String protectedAppsCount(int count) {
    return '$count protected apps';
  }

  @override
  String get searchAppsHint => 'Search apps...';

  @override
  String get filterAll => 'All';

  @override
  String get filterCategories => 'Categories';

  @override
  String get filterLocked => 'Locked';

  @override
  String categoryChipLabel(String category) {
    return 'Category: $category';
  }

  @override
  String get noLockedAppsFound => 'No locked apps found';

  @override
  String get noAppsFound => 'No apps found';

  @override
  String get categorySocial => 'Social';

  @override
  String get categoryMessaging => 'Messaging';

  @override
  String get categoryPhotosVideo => 'Photos & Video';

  @override
  String get categoryFinance => 'Finance';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categorySystem => 'System';

  @override
  String categoryAppsBullet(int count) {
    return '$count Apps • ';
  }

  @override
  String categoryProtectedCount(int count) {
    return '$count Protected';
  }

  @override
  String get usageAccessRequiredTitle => 'Usage Access required';

  @override
  String get usageAccessRequiredDesc =>
      'Enable Usage Access to protect selected\napps.';

  @override
  String get enableUsageAccessButton => 'Enable Usage Access';

  @override
  String get protectionMayBeLimitedTitle => 'Protection may be limited';

  @override
  String get protectionMayBeLimitedDesc =>
      'To ensure App Lock works reliably in the background, please review the following Android system settings.';

  @override
  String get displayOverOtherAppsWarningDesc =>
      'Required to show the lock screen over protected apps. Without this, apps will not be locked.';

  @override
  String get statusDisabled => 'Disabled';

  @override
  String get batteryOptimizationTitle => 'Battery optimization';

  @override
  String get batteryOptimizationDesc =>
      'Android may aggressively kill App Lock in the background. Disable optimization to keep protection active.';

  @override
  String get statusRestricted => 'Restricted';

  @override
  String get fixPermissionsButton => 'Fix permissions';

  @override
  String get continueWithLimitedProtectionButton =>
      'Continue with limited protection';

  @override
  String itemsProtectedCount(int count) {
    return '$count/100 items protected';
  }

  @override
  String get encryptedOnThisDevice => 'Encrypted on this device';

  @override
  String get quickActionsSmallTitle => 'Quick actions';

  @override
  String get addPhotosAction => 'Add\nPhotos';

  @override
  String get importVideosAction => 'Import\nVideos';

  @override
  String get albumsHeader => 'Albums';

  @override
  String get vaultEmptyTitle => 'Your vault is empty';

  @override
  String get vaultEmptySubtitle =>
      'Import photos and videos to keep them\nencrypted on this device.';

  @override
  String get albumVideos => 'Videos';

  @override
  String get albumPhotos => 'Photos';

  @override
  String vaultAlbumItemsCount(int count) {
    return '$count items';
  }

  @override
  String vaultItemsProtectedSubtitle(int count) {
    return '$count items • Protected';
  }

  @override
  String get encryptingItemsTitle => 'Encrypting selected items...';

  @override
  String filesProcessedProgress(int processed, int total) {
    return '$processed of $total files processed';
  }

  @override
  String get keepAppOpenWarning => 'Keep App Lock open until import finishes.';

  @override
  String get importCompleteTitle => 'Import complete';

  @override
  String get importCompleteSubtitle =>
      'Your data is now secured and encrypted.';

  @override
  String itemsEncryptedTitle(int count) {
    return '$count items encrypted';
  }

  @override
  String get aes256Subtitle => 'AES-256 Military Grade';

  @override
  String get originalsCouldNotBeDeletedTitle =>
      'Originals could not be deleted\nautomatically';

  @override
  String get nextStepRequiredTitle => 'Next Step Required';

  @override
  String get deleteOriginalsManuallyDesc =>
      'Open Photos or Gallery to delete\noriginals manually.';

  @override
  String get viewVaultButton => 'View Vault';

  @override
  String get backToVaultHomeLink => 'Back to Vault Home';

  @override
  String get fileInfoTitle => 'File info';

  @override
  String get protectedBadge => 'Protected';

  @override
  String get propertiesHeader => 'Properties';

  @override
  String get propertyName => 'Name';

  @override
  String get propertyType => 'Type';

  @override
  String get propertySize => 'Size';

  @override
  String get propertyImportedDate => 'Imported date';

  @override
  String get propertyEncryptionStatus => 'Encryption status';

  @override
  String get intruderSelfieOffTitle => 'Intruder Selfie is off';

  @override
  String get intruderSelfieOffSubtitle =>
      'Enable it to capture a photo after 3\nfailed unlock attempts.';

  @override
  String get secureLogsTitle => 'Secure Logs';

  @override
  String get secureLogsSubtitle =>
      'View date, time, and photo of\nunauthorized attempts.';

  @override
  String get stealthCaptureTitle => 'Stealth Capture';

  @override
  String get stealthCaptureSubtitle =>
      'The front camera captures the photo\nsilently.';

  @override
  String get enableIntruderSelfieButton => 'Enable Intruder Selfie';

  @override
  String get cameraPermissionDeniedTitle => 'Camera permission denied';

  @override
  String get cameraPermissionDeniedSubtitle =>
      'Intruder events can still be recorded\nwithout a photo.';

  @override
  String get intruderLoggingTitle => 'Intruder Logging';

  @override
  String get intruderLoggingSubtitle =>
      'Time, date, and attempted PINs will still\nbe stored in your security vault.';

  @override
  String get privacyFirstTitle => 'Privacy First';

  @override
  String get privacyFirstSubtitle =>
      'No photos are taken or stored without\nyour explicit camera permission.';

  @override
  String get openSettingsButton => 'Open settings';

  @override
  String get statusSummaryTitle => 'Status Summary';

  @override
  String failedMethodLabel(String method) {
    return 'Failed method: $method';
  }

  @override
  String get viewDetailsAction => 'View details';

  @override
  String get keepFullAlertHistoryTitle => 'Keep full alert history';

  @override
  String get keepFullAlertHistoryDesc =>
      'Free users only see the last 10\nalerts. Upgrade to store indefinitely.';

  @override
  String get alertDetailTitle => 'Alert detail';

  @override
  String get noPhotoCapturedTitle => 'No photo captured';

  @override
  String get noPhotoCapturedDesc =>
      'The security system failed to\ninitialize the camera during this\nevent.';

  @override
  String get eventSummaryHeader => 'EVENT SUMMARY';

  @override
  String get highAlertBadge => 'High Alert';

  @override
  String get captureAnalysisTitle => 'Capture Analysis';

  @override
  String get attemptedContextLabel => 'Attempted context';

  @override
  String get failedMethodRowLabel => 'Failed method';

  @override
  String get failedCountLabel => 'Failed count';

  @override
  String get dateTimeLabel => 'Date/time';

  @override
  String get saveEvidenceButton => 'Save evidence';

  @override
  String get enableCameraPermissionButton => 'Enable camera permission';

  @override
  String get deleteAlertButton => 'Delete alert';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSubtitle => 'Manage your app preferences.';

  @override
  String get freePlanTitle => 'Free Plan';

  @override
  String get freeBadge => 'FREE';

  @override
  String get freePlanDesc =>
      'Upgrade to Premium for advanced security\nfeatures.';

  @override
  String get securitySectionHeader => 'Security';

  @override
  String get biometricUnlockTitle => 'Biometric Unlock';

  @override
  String get biometricUnlockSubtitle => 'Use Face ID / Touch ID';

  @override
  String get autoLockDelayTitle => 'Auto-lock delay';

  @override
  String get helpAndSupportHeader => 'Help & Support';

  @override
  String get languagesTitle => 'Languages';

  @override
  String get contactUsTitle => 'Contact Us';

  @override
  String get termsOfServiceTitle => 'Terms of Service';

  @override
  String get requireAuthenticationTitle => 'Require Authentication';

  @override
  String get requireAuthenticationSubtitle =>
      'Choose how quickly the app locks after you\nleave it. Shorter delays provide stronger privacy\nprotection.';

  @override
  String get delayImmediately => 'Immediately';

  @override
  String get delay15Seconds => 'After 15 seconds';

  @override
  String get delay30Seconds => 'After 30 seconds';

  @override
  String get delay1Minute => 'After 1 minute';

  @override
  String get delayScreenOff => 'When screen turns off';

  @override
  String get settingLanguagesTitle => 'Setting Languages';

  @override
  String get settingLanguagesSubtitle =>
      'Choose your preferred language for the interface\nand document recognition.';

  @override
  String get langEnglish => 'English';

  @override
  String get langVietnamese => 'Vietnamese';

  @override
  String get langSpanish => 'Spanish';

  @override
  String get langFrench => 'French';

  @override
  String get langGerman => 'German';

  @override
  String get langJapanese => 'Japanese';

  @override
  String get langChinese => 'Chinese';

  @override
  String get contactUsIntro =>
      'We\'re here to help. Fill out the form below and\nour support team will get back to you as soon as\npossible.';

  @override
  String get emailAddressLabel => 'Email Address';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get subjectLabel => 'Subject';

  @override
  String get subjectHint => 'Brief summary of your issue';

  @override
  String get messageLabel => 'Message';

  @override
  String get messageHint => 'Describe your issue in detail...';

  @override
  String get contactPrivacyDisclaimer =>
      'By submitting this form, you agree to our Privacy Policy. We\nwill only use your email to respond to this request.';

  @override
  String get sendMessageButton => 'Send message';

  @override
  String get biometricNotSupportedError =>
      'Device does not support or has not set up biometrics';

  @override
  String get deleteFromVaultDialogTitle => 'Delete from Vault?';

  @override
  String get deleteFromVaultDialogDesc =>
      'This removes the encrypted vault copy from this device.';

  @override
  String get deletePermanentlyButton => 'Delete permanently';

  @override
  String get deleteAlertDialogTitle => 'Delete alert?';

  @override
  String get deleteAlertDialogDesc =>
      'This removes the captured intruder photo and event log from this device.';

  @override
  String get purchaseFallbackMonthlyPrice => '\$2.99';

  @override
  String get purchaseFallbackYearlyPrice => '\$25.99';

  @override
  String get purchaseFallbackYearlyOriginalPrice => '\$35.99';

  @override
  String purchaseSaveBadge(int percent) {
    return 'SAVE $percent%';
  }

  @override
  String get purchaseBillingUnavailable =>
      'Google Play Billing is unavailable on this device. Check your Play Store account and try again.';

  @override
  String get purchaseProductsNotFound =>
      'Premium plans are not available right now. Please try again later.';

  @override
  String get purchaseProductsLoading =>
      'Loading plans, please try again in a moment.';

  @override
  String get purchaseFailed => 'Purchase failed. Please try again.';

  @override
  String get purchasePending =>
      'Your purchase is pending. Premium will unlock once the payment is completed.';

  @override
  String get purchaseRestoreSuccess => 'Purchases restored. Premium is active.';

  @override
  String get purchaseRestoreNothing => 'No previous purchases found.';

  @override
  String get purchaseRestoreFailed =>
      'Could not restore purchases. Please try again.';

  @override
  String get purchaseAlreadyPremium => 'You\'re already Premium';

  @override
  String get purchaseOpenLinkFailed => 'Could not open the link.';

  @override
  String intruderFailedAttemptsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count failed unlock attempts today',
      one: '1 failed unlock attempt today',
      zero: 'No failed unlock attempts today',
    );
    return '$_temp0';
  }

  @override
  String intruderAlertsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alerts saved',
      one: '1 alert saved',
      zero: 'No alerts saved',
    );
    return '$_temp0';
  }

  @override
  String intruderAlertsShownOfTotal(int shown, int total) {
    return 'Showing $shown of $total saved alerts';
  }

  @override
  String get intruderMethodPin => 'PIN';

  @override
  String get intruderMethodPattern => 'Pattern';

  @override
  String get intruderMethodBiometric => 'Biometric';

  @override
  String get intruderMainUnlock => 'Main Unlock';

  @override
  String get intruderYesterday => 'Yesterday';

  @override
  String intruderEvidenceSavedTo(String path) {
    return 'Evidence saved to $path';
  }

  @override
  String get intruderEvidenceSaveFailed => 'Could not save evidence';

  @override
  String get intruderAlertDeleted => 'Alert deleted';

  @override
  String get intruderDeleteFailed => 'Could not delete alert';

  @override
  String get intruderNoAlertsTitle => 'No intruder alerts yet';

  @override
  String get intruderNoAlertsSubtitle =>
      'After 3 failed unlock attempts, App Lock silently takes a photo of the intruder and saves it here.';

  @override
  String get lockBiometricReason => 'Confirm your identity to unlock';

  @override
  String get lockEnableBiometricReason =>
      'Authenticate to enable biometric unlock';

  @override
  String get lockDeviceAuthReason =>
      'Verify it\'s you with your device screen lock';

  @override
  String get lockDeviceNotSecureError =>
      'Set up a screen lock on your device to recover access.';

  @override
  String get lockAuthFailedError => 'Authentication failed. Try again.';

  @override
  String get lockUsageAccessNeeded => 'Grant Usage Access to start protection.';

  @override
  String get lockPasscodeUpdated => 'Passcode updated';

  @override
  String get lockPatternUpdated => 'Pattern updated';

  @override
  String get lockSaveFailed => 'Couldn\'t save. Please try again.';

  @override
  String get lockPremiumPlanTitle => 'Premium Plan';

  @override
  String get lockPremiumPlanDesc => 'All premium features are unlocked.';

  @override
  String get lockContactFormIncomplete =>
      'Please enter your email and a message.';

  @override
  String get lockContactInvalidEmail => 'Please enter a valid email address.';

  @override
  String lockContactNoEmailApp(String email) {
    return 'No email app found. Please write to $email';
  }

  @override
  String get lockOpenLinkFailed => 'Couldn\'t open the link.';

  @override
  String get lockBatteryOptimizationTitle => 'Battery optimization';

  @override
  String get lockBatteryOptimizationDesc =>
      'Set App Lock to \"Not optimized\" so protection keeps running.';

  @override
  String vaultItemsProtectedUnlimited(int count) {
    return '$count items protected';
  }

  @override
  String get vaultLimitReachedTitle => 'Vault limit reached';

  @override
  String vaultLimitReachedDesc(int limit) {
    return 'The free plan protects up to $limit items. Upgrade to Premium for unlimited vault storage.';
  }

  @override
  String get vaultUpgradeButton => 'Upgrade';

  @override
  String get vaultOperationFailed => 'Something went wrong. Please try again.';

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
  String get vaultTypePhoto => 'Photo';

  @override
  String get vaultTypeVideo => 'Video';

  @override
  String get vaultPhotosEmptyTitle => 'No photos yet';

  @override
  String get vaultVideosEmptyTitle => 'No videos yet';

  @override
  String get vaultDetailEmptySubtitle =>
      'Tap + to choose items with the system photo picker. They are encrypted on this device.';

  @override
  String get vaultPreviewUnavailable => 'Preview unavailable';

  @override
  String get appsCategoryOther => 'Other';

  @override
  String get dialogAdvertisementDownload => 'Download Now';
}
