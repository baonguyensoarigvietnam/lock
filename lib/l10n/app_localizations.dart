import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'AppLock'**
  String get appTitle;

  /// No description provided for @appLockTitle.
  ///
  /// In en, this message translates to:
  /// **'App Lock'**
  String get appLockTitle;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @getStartedButton.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStartedButton;

  /// No description provided for @skipButton.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @doneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneButton;

  /// No description provided for @resetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetButton;

  /// No description provided for @deleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

  /// No description provided for @infoAction.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get infoAction;

  /// No description provided for @seeAllAction.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAllAction;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navApps.
  ///
  /// In en, this message translates to:
  /// **'Apps'**
  String get navApps;

  /// No description provided for @navVault.
  ///
  /// In en, this message translates to:
  /// **'Vault'**
  String get navVault;

  /// No description provided for @navAlerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get navAlerts;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @splashSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Protect your private content'**
  String get splashSubtitle;

  /// No description provided for @onboardingStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Protect your privacy'**
  String get onboardingStep1Title;

  /// No description provided for @onboardingStep1Desc.
  ///
  /// In en, this message translates to:
  /// **'Keep private photos, videos, and sensitive access protected on this device.'**
  String get onboardingStep1Desc;

  /// No description provided for @onboardingStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Local-only protection'**
  String get onboardingStep2Title;

  /// No description provided for @onboardingStep2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your data never leaves your device.'**
  String get onboardingStep2Subtitle;

  /// No description provided for @onboardingNoAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'No account'**
  String get onboardingNoAccountTitle;

  /// No description provided for @onboardingNoAccountDesc.
  ///
  /// In en, this message translates to:
  /// **'We don\'t ask for your email or phone number to use the app.'**
  String get onboardingNoAccountDesc;

  /// No description provided for @onboardingNoCloudTitle.
  ///
  /// In en, this message translates to:
  /// **'No cloud sync'**
  String get onboardingNoCloudTitle;

  /// No description provided for @onboardingNoCloudDesc.
  ///
  /// In en, this message translates to:
  /// **'Your data is never uploaded to any external servers or clouds.'**
  String get onboardingNoCloudDesc;

  /// No description provided for @onboardingNoRecoveryTitle.
  ///
  /// In en, this message translates to:
  /// **'No server-side recovery'**
  String get onboardingNoRecoveryTitle;

  /// No description provided for @onboardingNoRecoveryDesc.
  ///
  /// In en, this message translates to:
  /// **'If you lose your PIN, we cannot recover your data for you.'**
  String get onboardingNoRecoveryDesc;

  /// No description provided for @onboardingVaultStaysTitle.
  ///
  /// In en, this message translates to:
  /// **'Vault files stay here'**
  String get onboardingVaultStaysTitle;

  /// No description provided for @onboardingVaultStaysDesc.
  ///
  /// In en, this message translates to:
  /// **'Everything secured in the vault remains strictly on this device.'**
  String get onboardingVaultStaysDesc;

  /// No description provided for @unlockMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up your unlock method'**
  String get unlockMethodTitle;

  /// No description provided for @unlockMethodSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how you\'ll unlock your private content.'**
  String get unlockMethodSubtitle;

  /// No description provided for @createPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Create PIN'**
  String get createPinTitle;

  /// No description provided for @createPinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'4-8 digit numerical code'**
  String get createPinSubtitle;

  /// No description provided for @drawPatternTitle.
  ///
  /// In en, this message translates to:
  /// **'Draw pattern'**
  String get drawPatternTitle;

  /// No description provided for @drawPatternSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect at least 4 dots'**
  String get drawPatternSubtitle;

  /// No description provided for @unlockMethodWarning.
  ///
  /// In en, this message translates to:
  /// **'Keep this safe. Vault data cannot be recovered if you forget it and biometric fallback is unavailable.'**
  String get unlockMethodWarning;

  /// No description provided for @createYourPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your PIN'**
  String get createYourPinTitle;

  /// No description provided for @confirmYourPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your PIN'**
  String get confirmYourPinTitle;

  /// No description provided for @changePasscodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Passcode'**
  String get changePasscodeTitle;

  /// No description provided for @confirmYourPasscodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your Passcode'**
  String get confirmYourPasscodeTitle;

  /// No description provided for @usePinToAccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use this PIN to access your protected content.'**
  String get usePinToAccessSubtitle;

  /// No description provided for @reEnterPinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your PIN to confirm.'**
  String get reEnterPinSubtitle;

  /// No description provided for @reEnterPinShort.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your PIN.'**
  String get reEnterPinShort;

  /// No description provided for @pinDoesNotMatchError.
  ///
  /// In en, this message translates to:
  /// **'PIN does not match.'**
  String get pinDoesNotMatchError;

  /// No description provided for @usePatternInstead.
  ///
  /// In en, this message translates to:
  /// **'Use pattern instead'**
  String get usePatternInstead;

  /// No description provided for @usePinInstead.
  ///
  /// In en, this message translates to:
  /// **'Use PIN instead'**
  String get usePinInstead;

  /// No description provided for @drawUnlockPatternTitle.
  ///
  /// In en, this message translates to:
  /// **'Draw an unlock pattern'**
  String get drawUnlockPatternTitle;

  /// No description provided for @confirmYourPatternTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your pattern'**
  String get confirmYourPatternTitle;

  /// No description provided for @connectAtLeast4Dots.
  ///
  /// In en, this message translates to:
  /// **'Connect at least 4 dots.'**
  String get connectAtLeast4Dots;

  /// No description provided for @drawPatternAgainConfirm.
  ///
  /// In en, this message translates to:
  /// **'Draw your pattern again to confirm.'**
  String get drawPatternAgainConfirm;

  /// No description provided for @patternDoesNotMatchError.
  ///
  /// In en, this message translates to:
  /// **'Pattern does not match'**
  String get patternDoesNotMatchError;

  /// No description provided for @enableBiometricTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable biometric fallback'**
  String get enableBiometricTitle;

  /// No description provided for @enableBiometricSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use your device\'s fingerprint or face scan to regain access if needed.'**
  String get enableBiometricSubtitle;

  /// No description provided for @fasterUnlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Faster unlock'**
  String get fasterUnlockTitle;

  /// No description provided for @fasterUnlockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Quickly access your vault without typing.'**
  String get fasterUnlockSubtitle;

  /// No description provided for @usesDeviceSecurityTitle.
  ///
  /// In en, this message translates to:
  /// **'Uses device security'**
  String get usesDeviceSecurityTitle;

  /// No description provided for @usesDeviceSecuritySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Leverages built-in biometric hardware.'**
  String get usesDeviceSecuritySubtitle;

  /// No description provided for @helpsForgetPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Helps if you forget your PIN'**
  String get helpsForgetPinTitle;

  /// No description provided for @helpsForgetPinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A secure alternative way to get back in.'**
  String get helpsForgetPinSubtitle;

  /// No description provided for @biometricInfoNote.
  ///
  /// In en, this message translates to:
  /// **'Biometric fallback only works if enabled before you forget your PIN.'**
  String get biometricInfoNote;

  /// No description provided for @enableBiometricButton.
  ///
  /// In en, this message translates to:
  /// **'Enable biometric'**
  String get enableBiometricButton;

  /// No description provided for @setUpPermissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up permissions'**
  String get setUpPermissionsTitle;

  /// No description provided for @permissionGuideSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable the permissions needed for App Lock, Vault, and security alerts. You can skip optional features and turn them on later.'**
  String get permissionGuideSubtitle;

  /// No description provided for @usageAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Usage Access'**
  String get usageAccessTitle;

  /// No description provided for @usageAccessDesc.
  ///
  /// In en, this message translates to:
  /// **'Detect when selected apps are opened so App Lock can show the unlock screen.'**
  String get usageAccessDesc;

  /// No description provided for @displayOverOtherAppsTitle.
  ///
  /// In en, this message translates to:
  /// **'Display over other apps'**
  String get displayOverOtherAppsTitle;

  /// No description provided for @displayOverOtherAppsDesc.
  ///
  /// In en, this message translates to:
  /// **'Show the unlock screen over protected apps for better reliability.'**
  String get displayOverOtherAppsDesc;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Show protection status, security alerts, and permission warnings.'**
  String get notificationsDesc;

  /// No description provided for @cameraTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraTitle;

  /// No description provided for @cameraDesc.
  ///
  /// In en, this message translates to:
  /// **'Capture a front-camera photo after 3 failed unlock attempts.'**
  String get cameraDesc;

  /// No description provided for @badgeRequired.
  ///
  /// In en, this message translates to:
  /// **'REQUIRED'**
  String get badgeRequired;

  /// No description provided for @badgeRecommended.
  ///
  /// In en, this message translates to:
  /// **'RECOMMENDED'**
  String get badgeRecommended;

  /// No description provided for @badgeIntruder.
  ///
  /// In en, this message translates to:
  /// **'INTRUDER'**
  String get badgeIntruder;

  /// No description provided for @upgradeToPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeToPremium;

  /// No description provided for @paywallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock more themes and remove ads.'**
  String get paywallSubtitle;

  /// No description provided for @paywallFeatureThemes.
  ///
  /// In en, this message translates to:
  /// **'Premium themes in future'**
  String get paywallFeatureThemes;

  /// No description provided for @paywallFeatureVault.
  ///
  /// In en, this message translates to:
  /// **'Unlimited vault'**
  String get paywallFeatureVault;

  /// No description provided for @paywallFeatureAlerts.
  ///
  /// In en, this message translates to:
  /// **'Full intruder alert history'**
  String get paywallFeatureAlerts;

  /// No description provided for @paywallFeatureNoAds.
  ///
  /// In en, this message translates to:
  /// **'No ads'**
  String get paywallFeatureNoAds;

  /// No description provided for @monthlyPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthlyPlanTitle;

  /// No description provided for @monthlyPlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Billed every month'**
  String get monthlyPlanSubtitle;

  /// No description provided for @yearlyPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearlyPlanTitle;

  /// No description provided for @yearlyPlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Billed annually'**
  String get yearlyPlanSubtitle;

  /// No description provided for @save40Badge.
  ///
  /// In en, this message translates to:
  /// **'SAVE 40%'**
  String get save40Badge;

  /// No description provided for @wasPrice.
  ///
  /// In en, this message translates to:
  /// **'was {price}'**
  String wasPrice(String price);

  /// No description provided for @startPremiumButton.
  ///
  /// In en, this message translates to:
  /// **'Start Premium'**
  String get startPremiumButton;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchases;

  /// No description provided for @termsLink.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get termsLink;

  /// No description provided for @privacyPolicyLink.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyLink;

  /// No description provided for @unlockAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock {appName}'**
  String unlockAppTitle(String appName);

  /// No description provided for @enterPinToContinue.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN to continue.'**
  String get enterPinToContinue;

  /// No description provided for @incorrectPinTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Incorrect PIN. Try again.'**
  String get incorrectPinTryAgain;

  /// No description provided for @incorrectPatternTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Incorrect pattern. Try again.'**
  String get incorrectPatternTryAgain;

  /// No description provided for @forgotPinLink.
  ///
  /// In en, this message translates to:
  /// **'Forgot PIN?'**
  String get forgotPinLink;

  /// No description provided for @forgotPatternLink.
  ///
  /// In en, this message translates to:
  /// **'Forgot Pattern?'**
  String get forgotPatternLink;

  /// No description provided for @useBiometricUnlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Use biometric unlock'**
  String get useBiometricUnlockTitle;

  /// No description provided for @unlockWithDeviceAuthSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock with device authentication.'**
  String get unlockWithDeviceAuthSubtitle;

  /// No description provided for @biometricNotRecognized.
  ///
  /// In en, this message translates to:
  /// **'BIOMETRIC NOT RECOGNIZED'**
  String get biometricNotRecognized;

  /// No description provided for @recoverAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Recover access'**
  String get recoverAccessTitle;

  /// No description provided for @useBiometricFallbackCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Use biometric fallback'**
  String get useBiometricFallbackCardTitle;

  /// No description provided for @useBiometricFallbackCardDesc.
  ///
  /// In en, this message translates to:
  /// **'Authenticate with device biometrics, then create a new PIN or pattern.'**
  String get useBiometricFallbackCardDesc;

  /// No description provided for @authenticateButton.
  ///
  /// In en, this message translates to:
  /// **'Authenticate'**
  String get authenticateButton;

  /// No description provided for @vaultCannotBeRecoveredTitle.
  ///
  /// In en, this message translates to:
  /// **'Vault cannot be recovered'**
  String get vaultCannotBeRecoveredTitle;

  /// No description provided for @vaultCannotBeRecoveredDesc.
  ///
  /// In en, this message translates to:
  /// **'Without PIN, pattern, or biometric fallback, encrypted vault data cannot be recovered.'**
  String get vaultCannotBeRecoveredDesc;

  /// No description provided for @resetAppSecurityButton.
  ///
  /// In en, this message translates to:
  /// **'Reset app security'**
  String get resetAppSecurityButton;

  /// No description provided for @backToUnlockLink.
  ///
  /// In en, this message translates to:
  /// **'Back to unlock'**
  String get backToUnlockLink;

  /// No description provided for @resetSecurityQuestionTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset security?'**
  String get resetSecurityQuestionTitle;

  /// No description provided for @resetSecurityWarningDesc.
  ///
  /// In en, this message translates to:
  /// **'This will delete the key envelope.\nEncrypted vault data will no longer be\naccessible.'**
  String get resetSecurityWarningDesc;

  /// No description provided for @resetSecurityConfirmCheckbox.
  ///
  /// In en, this message translates to:
  /// **'I understand this cannot be\nundone'**
  String get resetSecurityConfirmCheckbox;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get statusActive;

  /// No description provided for @statusIdle.
  ///
  /// In en, this message translates to:
  /// **'IDLE'**
  String get statusIdle;

  /// No description provided for @appsProtectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Apps protected'**
  String get appsProtectedLabel;

  /// No description provided for @vaultItemsLabel.
  ///
  /// In en, this message translates to:
  /// **'Vault items'**
  String get vaultItemsLabel;

  /// No description provided for @intruderAlertsLabel.
  ///
  /// In en, this message translates to:
  /// **'Intruder alerts'**
  String get intruderAlertsLabel;

  /// No description provided for @biometricFallbackLabel.
  ///
  /// In en, this message translates to:
  /// **'Biometric fallback'**
  String get biometricFallbackLabel;

  /// No description provided for @quickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActionsTitle;

  /// No description provided for @lockAppsAction.
  ///
  /// In en, this message translates to:
  /// **'Lock Apps'**
  String get lockAppsAction;

  /// No description provided for @themesAction.
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get themesAction;

  /// No description provided for @promoBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'UNLOCK ALL FEATURES'**
  String get promoBannerTitle;

  /// No description provided for @promoBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlimited themes, free ads and more.'**
  String get promoBannerSubtitle;

  /// No description provided for @themeMinimal.
  ///
  /// In en, this message translates to:
  /// **'Minimal'**
  String get themeMinimal;

  /// No description provided for @themeClassicPin.
  ///
  /// In en, this message translates to:
  /// **'Classic PIN'**
  String get themeClassicPin;

  /// No description provided for @themePattern.
  ///
  /// In en, this message translates to:
  /// **'Pattern'**
  String get themePattern;

  /// No description provided for @themeVault.
  ///
  /// In en, this message translates to:
  /// **'Vault'**
  String get themeVault;

  /// No description provided for @themeFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get themeFocus;

  /// No description provided for @themePremiumColors.
  ///
  /// In en, this message translates to:
  /// **'Premium Colors'**
  String get themePremiumColors;

  /// No description provided for @premiumBadge.
  ///
  /// In en, this message translates to:
  /// **'PREMIUM'**
  String get premiumBadge;

  /// No description provided for @applyThemeButton.
  ///
  /// In en, this message translates to:
  /// **'Apply theme'**
  String get applyThemeButton;

  /// No description provided for @themeAppliedTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme applied'**
  String get themeAppliedTitle;

  /// No description provided for @themeAppliedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your lock screens now use the\nselected theme.'**
  String get themeAppliedSubtitle;

  /// No description provided for @premiumColorPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium Color Preview'**
  String get premiumColorPreviewTitle;

  /// No description provided for @premiumThemesSubscriptionNote.
  ///
  /// In en, this message translates to:
  /// **'Premium themes are available with subscription.'**
  String get premiumThemesSubscriptionNote;

  /// No description provided for @backToThemesButton.
  ///
  /// In en, this message translates to:
  /// **'Back to themes'**
  String get backToThemesButton;

  /// No description provided for @lockedAppsHeader.
  ///
  /// In en, this message translates to:
  /// **'Locked Apps'**
  String get lockedAppsHeader;

  /// No description provided for @protectedAppsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} protected apps'**
  String protectedAppsCount(int count);

  /// No description provided for @searchAppsHint.
  ///
  /// In en, this message translates to:
  /// **'Search apps...'**
  String get searchAppsHint;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get filterCategories;

  /// No description provided for @filterLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get filterLocked;

  /// No description provided for @categoryChipLabel.
  ///
  /// In en, this message translates to:
  /// **'Category: {category}'**
  String categoryChipLabel(String category);

  /// No description provided for @noLockedAppsFound.
  ///
  /// In en, this message translates to:
  /// **'No locked apps found'**
  String get noLockedAppsFound;

  /// No description provided for @noAppsFound.
  ///
  /// In en, this message translates to:
  /// **'No apps found'**
  String get noAppsFound;

  /// No description provided for @categorySocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get categorySocial;

  /// No description provided for @categoryMessaging.
  ///
  /// In en, this message translates to:
  /// **'Messaging'**
  String get categoryMessaging;

  /// No description provided for @categoryPhotosVideo.
  ///
  /// In en, this message translates to:
  /// **'Photos & Video'**
  String get categoryPhotosVideo;

  /// No description provided for @categoryFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get categoryFinance;

  /// No description provided for @categoryShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get categoryShopping;

  /// No description provided for @categorySystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get categorySystem;

  /// No description provided for @categoryAppsBullet.
  ///
  /// In en, this message translates to:
  /// **'{count} Apps • '**
  String categoryAppsBullet(int count);

  /// No description provided for @categoryProtectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Protected'**
  String categoryProtectedCount(int count);

  /// No description provided for @usageAccessRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Usage Access required'**
  String get usageAccessRequiredTitle;

  /// No description provided for @usageAccessRequiredDesc.
  ///
  /// In en, this message translates to:
  /// **'Enable Usage Access to protect selected\napps.'**
  String get usageAccessRequiredDesc;

  /// No description provided for @enableUsageAccessButton.
  ///
  /// In en, this message translates to:
  /// **'Enable Usage Access'**
  String get enableUsageAccessButton;

  /// No description provided for @protectionMayBeLimitedTitle.
  ///
  /// In en, this message translates to:
  /// **'Protection may be limited'**
  String get protectionMayBeLimitedTitle;

  /// No description provided for @protectionMayBeLimitedDesc.
  ///
  /// In en, this message translates to:
  /// **'To ensure App Lock works reliably in the background, please review the following Android system settings.'**
  String get protectionMayBeLimitedDesc;

  /// No description provided for @displayOverOtherAppsWarningDesc.
  ///
  /// In en, this message translates to:
  /// **'Required to show the lock screen over protected apps. Without this, apps will not be locked.'**
  String get displayOverOtherAppsWarningDesc;

  /// No description provided for @statusDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get statusDisabled;

  /// No description provided for @batteryOptimizationTitle.
  ///
  /// In en, this message translates to:
  /// **'Battery optimization'**
  String get batteryOptimizationTitle;

  /// No description provided for @batteryOptimizationDesc.
  ///
  /// In en, this message translates to:
  /// **'Android may aggressively kill App Lock in the background. Disable optimization to keep protection active.'**
  String get batteryOptimizationDesc;

  /// No description provided for @statusRestricted.
  ///
  /// In en, this message translates to:
  /// **'Restricted'**
  String get statusRestricted;

  /// No description provided for @fixPermissionsButton.
  ///
  /// In en, this message translates to:
  /// **'Fix permissions'**
  String get fixPermissionsButton;

  /// No description provided for @continueWithLimitedProtectionButton.
  ///
  /// In en, this message translates to:
  /// **'Continue with limited protection'**
  String get continueWithLimitedProtectionButton;

  /// No description provided for @itemsProtectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count}/100 items protected'**
  String itemsProtectedCount(int count);

  /// No description provided for @encryptedOnThisDevice.
  ///
  /// In en, this message translates to:
  /// **'Encrypted on this device'**
  String get encryptedOnThisDevice;

  /// No description provided for @quickActionsSmallTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get quickActionsSmallTitle;

  /// No description provided for @addPhotosAction.
  ///
  /// In en, this message translates to:
  /// **'Add\nPhotos'**
  String get addPhotosAction;

  /// No description provided for @importVideosAction.
  ///
  /// In en, this message translates to:
  /// **'Import\nVideos'**
  String get importVideosAction;

  /// No description provided for @albumsHeader.
  ///
  /// In en, this message translates to:
  /// **'Albums'**
  String get albumsHeader;

  /// No description provided for @vaultEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your vault is empty'**
  String get vaultEmptyTitle;

  /// No description provided for @vaultEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Import photos and videos to keep them\nencrypted on this device.'**
  String get vaultEmptySubtitle;

  /// No description provided for @albumVideos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get albumVideos;

  /// No description provided for @albumPhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get albumPhotos;

  /// No description provided for @vaultAlbumItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String vaultAlbumItemsCount(int count);

  /// No description provided for @vaultItemsProtectedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} items • Protected'**
  String vaultItemsProtectedSubtitle(int count);

  /// No description provided for @encryptingItemsTitle.
  ///
  /// In en, this message translates to:
  /// **'Encrypting selected items...'**
  String get encryptingItemsTitle;

  /// No description provided for @filesProcessedProgress.
  ///
  /// In en, this message translates to:
  /// **'{processed} of {total} files processed'**
  String filesProcessedProgress(int processed, int total);

  /// No description provided for @keepAppOpenWarning.
  ///
  /// In en, this message translates to:
  /// **'Keep App Lock open until import finishes.'**
  String get keepAppOpenWarning;

  /// No description provided for @importCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Import complete'**
  String get importCompleteTitle;

  /// No description provided for @importCompleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your data is now secured and encrypted.'**
  String get importCompleteSubtitle;

  /// No description provided for @itemsEncryptedTitle.
  ///
  /// In en, this message translates to:
  /// **'{count} items encrypted'**
  String itemsEncryptedTitle(int count);

  /// No description provided for @aes256Subtitle.
  ///
  /// In en, this message translates to:
  /// **'AES-256 Military Grade'**
  String get aes256Subtitle;

  /// No description provided for @originalsCouldNotBeDeletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Originals could not be deleted\nautomatically'**
  String get originalsCouldNotBeDeletedTitle;

  /// No description provided for @nextStepRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Next Step Required'**
  String get nextStepRequiredTitle;

  /// No description provided for @deleteOriginalsManuallyDesc.
  ///
  /// In en, this message translates to:
  /// **'Open Photos or Gallery to delete\noriginals manually.'**
  String get deleteOriginalsManuallyDesc;

  /// No description provided for @viewVaultButton.
  ///
  /// In en, this message translates to:
  /// **'View Vault'**
  String get viewVaultButton;

  /// No description provided for @backToVaultHomeLink.
  ///
  /// In en, this message translates to:
  /// **'Back to Vault Home'**
  String get backToVaultHomeLink;

  /// No description provided for @fileInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'File info'**
  String get fileInfoTitle;

  /// No description provided for @protectedBadge.
  ///
  /// In en, this message translates to:
  /// **'Protected'**
  String get protectedBadge;

  /// No description provided for @propertiesHeader.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get propertiesHeader;

  /// No description provided for @propertyName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get propertyName;

  /// No description provided for @propertyType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get propertyType;

  /// No description provided for @propertySize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get propertySize;

  /// No description provided for @propertyImportedDate.
  ///
  /// In en, this message translates to:
  /// **'Imported date'**
  String get propertyImportedDate;

  /// No description provided for @propertyEncryptionStatus.
  ///
  /// In en, this message translates to:
  /// **'Encryption status'**
  String get propertyEncryptionStatus;

  /// No description provided for @intruderSelfieOffTitle.
  ///
  /// In en, this message translates to:
  /// **'Intruder Selfie is off'**
  String get intruderSelfieOffTitle;

  /// No description provided for @intruderSelfieOffSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable it to capture a photo after 3\nfailed unlock attempts.'**
  String get intruderSelfieOffSubtitle;

  /// No description provided for @secureLogsTitle.
  ///
  /// In en, this message translates to:
  /// **'Secure Logs'**
  String get secureLogsTitle;

  /// No description provided for @secureLogsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View date, time, and photo of\nunauthorized attempts.'**
  String get secureLogsSubtitle;

  /// No description provided for @stealthCaptureTitle.
  ///
  /// In en, this message translates to:
  /// **'Stealth Capture'**
  String get stealthCaptureTitle;

  /// No description provided for @stealthCaptureSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The front camera captures the photo\nsilently.'**
  String get stealthCaptureSubtitle;

  /// No description provided for @enableIntruderSelfieButton.
  ///
  /// In en, this message translates to:
  /// **'Enable Intruder Selfie'**
  String get enableIntruderSelfieButton;

  /// No description provided for @cameraPermissionDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera permission denied'**
  String get cameraPermissionDeniedTitle;

  /// No description provided for @cameraPermissionDeniedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Intruder events can still be recorded\nwithout a photo.'**
  String get cameraPermissionDeniedSubtitle;

  /// No description provided for @intruderLoggingTitle.
  ///
  /// In en, this message translates to:
  /// **'Intruder Logging'**
  String get intruderLoggingTitle;

  /// No description provided for @intruderLoggingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Time, date, and attempted PINs will still\nbe stored in your security vault.'**
  String get intruderLoggingSubtitle;

  /// No description provided for @privacyFirstTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy First'**
  String get privacyFirstTitle;

  /// No description provided for @privacyFirstSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No photos are taken or stored without\nyour explicit camera permission.'**
  String get privacyFirstSubtitle;

  /// No description provided for @openSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettingsButton;

  /// No description provided for @statusSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Status Summary'**
  String get statusSummaryTitle;

  /// No description provided for @failedMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'Failed method: {method}'**
  String failedMethodLabel(String method);

  /// No description provided for @viewDetailsAction.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetailsAction;

  /// No description provided for @keepFullAlertHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep full alert history'**
  String get keepFullAlertHistoryTitle;

  /// No description provided for @keepFullAlertHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Free users only see the last 10\nalerts. Upgrade to store indefinitely.'**
  String get keepFullAlertHistoryDesc;

  /// No description provided for @alertDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Alert detail'**
  String get alertDetailTitle;

  /// No description provided for @noPhotoCapturedTitle.
  ///
  /// In en, this message translates to:
  /// **'No photo captured'**
  String get noPhotoCapturedTitle;

  /// No description provided for @noPhotoCapturedDesc.
  ///
  /// In en, this message translates to:
  /// **'The security system failed to\ninitialize the camera during this\nevent.'**
  String get noPhotoCapturedDesc;

  /// No description provided for @eventSummaryHeader.
  ///
  /// In en, this message translates to:
  /// **'EVENT SUMMARY'**
  String get eventSummaryHeader;

  /// No description provided for @highAlertBadge.
  ///
  /// In en, this message translates to:
  /// **'High Alert'**
  String get highAlertBadge;

  /// No description provided for @captureAnalysisTitle.
  ///
  /// In en, this message translates to:
  /// **'Capture Analysis'**
  String get captureAnalysisTitle;

  /// No description provided for @attemptedContextLabel.
  ///
  /// In en, this message translates to:
  /// **'Attempted context'**
  String get attemptedContextLabel;

  /// No description provided for @failedMethodRowLabel.
  ///
  /// In en, this message translates to:
  /// **'Failed method'**
  String get failedMethodRowLabel;

  /// No description provided for @failedCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Failed count'**
  String get failedCountLabel;

  /// No description provided for @dateTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Date/time'**
  String get dateTimeLabel;

  /// No description provided for @saveEvidenceButton.
  ///
  /// In en, this message translates to:
  /// **'Save evidence'**
  String get saveEvidenceButton;

  /// No description provided for @enableCameraPermissionButton.
  ///
  /// In en, this message translates to:
  /// **'Enable camera permission'**
  String get enableCameraPermissionButton;

  /// No description provided for @deleteAlertButton.
  ///
  /// In en, this message translates to:
  /// **'Delete alert'**
  String get deleteAlertButton;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your app preferences.'**
  String get settingsSubtitle;

  /// No description provided for @freePlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Free Plan'**
  String get freePlanTitle;

  /// No description provided for @freeBadge.
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get freeBadge;

  /// No description provided for @freePlanDesc.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium for advanced security\nfeatures.'**
  String get freePlanDesc;

  /// No description provided for @securitySectionHeader.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get securitySectionHeader;

  /// No description provided for @biometricUnlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Biometric Unlock'**
  String get biometricUnlockTitle;

  /// No description provided for @biometricUnlockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use Face ID / Touch ID'**
  String get biometricUnlockSubtitle;

  /// No description provided for @autoLockDelayTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto-lock delay'**
  String get autoLockDelayTitle;

  /// No description provided for @helpAndSupportHeader.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupportHeader;

  /// No description provided for @languagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languagesTitle;

  /// No description provided for @contactUsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUsTitle;

  /// No description provided for @termsOfServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfServiceTitle;

  /// No description provided for @requireAuthenticationTitle.
  ///
  /// In en, this message translates to:
  /// **'Require Authentication'**
  String get requireAuthenticationTitle;

  /// No description provided for @requireAuthenticationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how quickly the app locks after you\nleave it. Shorter delays provide stronger privacy\nprotection.'**
  String get requireAuthenticationSubtitle;

  /// No description provided for @delayImmediately.
  ///
  /// In en, this message translates to:
  /// **'Immediately'**
  String get delayImmediately;

  /// No description provided for @delay15Seconds.
  ///
  /// In en, this message translates to:
  /// **'After 15 seconds'**
  String get delay15Seconds;

  /// No description provided for @delay30Seconds.
  ///
  /// In en, this message translates to:
  /// **'After 30 seconds'**
  String get delay30Seconds;

  /// No description provided for @delay1Minute.
  ///
  /// In en, this message translates to:
  /// **'After 1 minute'**
  String get delay1Minute;

  /// No description provided for @delayScreenOff.
  ///
  /// In en, this message translates to:
  /// **'When screen turns off'**
  String get delayScreenOff;

  /// No description provided for @settingLanguagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Setting Languages'**
  String get settingLanguagesTitle;

  /// No description provided for @settingLanguagesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language for the interface\nand document recognition.'**
  String get settingLanguagesSubtitle;

  /// No description provided for @langEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get langEnglish;

  /// No description provided for @langVietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get langVietnamese;

  /// No description provided for @langSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get langSpanish;

  /// No description provided for @langFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get langFrench;

  /// No description provided for @langGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get langGerman;

  /// No description provided for @langJapanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get langJapanese;

  /// No description provided for @langChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get langChinese;

  /// No description provided for @contactUsIntro.
  ///
  /// In en, this message translates to:
  /// **'We\'re here to help. Fill out the form below and\nour support team will get back to you as soon as\npossible.'**
  String get contactUsIntro;

  /// No description provided for @emailAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddressLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get emailHint;

  /// No description provided for @subjectLabel.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subjectLabel;

  /// No description provided for @subjectHint.
  ///
  /// In en, this message translates to:
  /// **'Brief summary of your issue'**
  String get subjectHint;

  /// No description provided for @messageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageLabel;

  /// No description provided for @messageHint.
  ///
  /// In en, this message translates to:
  /// **'Describe your issue in detail...'**
  String get messageHint;

  /// No description provided for @contactPrivacyDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'By submitting this form, you agree to our Privacy Policy. We\nwill only use your email to respond to this request.'**
  String get contactPrivacyDisclaimer;

  /// No description provided for @sendMessageButton.
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get sendMessageButton;

  /// No description provided for @biometricNotSupportedError.
  ///
  /// In en, this message translates to:
  /// **'Device does not support or has not set up biometrics'**
  String get biometricNotSupportedError;

  /// No description provided for @deleteFromVaultDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete from Vault?'**
  String get deleteFromVaultDialogTitle;

  /// No description provided for @deleteFromVaultDialogDesc.
  ///
  /// In en, this message translates to:
  /// **'This removes the encrypted vault copy from this device.'**
  String get deleteFromVaultDialogDesc;

  /// No description provided for @deletePermanentlyButton.
  ///
  /// In en, this message translates to:
  /// **'Delete permanently'**
  String get deletePermanentlyButton;

  /// No description provided for @deleteAlertDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete alert?'**
  String get deleteAlertDialogTitle;

  /// No description provided for @deleteAlertDialogDesc.
  ///
  /// In en, this message translates to:
  /// **'This removes the captured intruder photo and event log from this device.'**
  String get deleteAlertDialogDesc;

  /// No description provided for @purchaseFallbackMonthlyPrice.
  ///
  /// In en, this message translates to:
  /// **'\$2.99'**
  String get purchaseFallbackMonthlyPrice;

  /// No description provided for @purchaseFallbackYearlyPrice.
  ///
  /// In en, this message translates to:
  /// **'\$25.99'**
  String get purchaseFallbackYearlyPrice;

  /// No description provided for @purchaseFallbackYearlyOriginalPrice.
  ///
  /// In en, this message translates to:
  /// **'\$35.99'**
  String get purchaseFallbackYearlyOriginalPrice;

  /// No description provided for @purchaseSaveBadge.
  ///
  /// In en, this message translates to:
  /// **'SAVE {percent}%'**
  String purchaseSaveBadge(int percent);

  /// No description provided for @purchaseBillingUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Google Play Billing is unavailable on this device. Check your Play Store account and try again.'**
  String get purchaseBillingUnavailable;

  /// No description provided for @purchaseProductsNotFound.
  ///
  /// In en, this message translates to:
  /// **'Premium plans are not available right now. Please try again later.'**
  String get purchaseProductsNotFound;

  /// No description provided for @purchaseProductsLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading plans, please try again in a moment.'**
  String get purchaseProductsLoading;

  /// No description provided for @purchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchase failed. Please try again.'**
  String get purchaseFailed;

  /// No description provided for @purchasePending.
  ///
  /// In en, this message translates to:
  /// **'Your purchase is pending. Premium will unlock once the payment is completed.'**
  String get purchasePending;

  /// No description provided for @purchaseRestoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Purchases restored. Premium is active.'**
  String get purchaseRestoreSuccess;

  /// No description provided for @purchaseRestoreNothing.
  ///
  /// In en, this message translates to:
  /// **'No previous purchases found.'**
  String get purchaseRestoreNothing;

  /// No description provided for @purchaseRestoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not restore purchases. Please try again.'**
  String get purchaseRestoreFailed;

  /// No description provided for @purchaseAlreadyPremium.
  ///
  /// In en, this message translates to:
  /// **'You\'re already Premium'**
  String get purchaseAlreadyPremium;

  /// No description provided for @purchaseOpenLinkFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the link.'**
  String get purchaseOpenLinkFailed;

  /// No description provided for @intruderFailedAttemptsToday.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No failed unlock attempts today} =1{1 failed unlock attempt today} other{{count} failed unlock attempts today}}'**
  String intruderFailedAttemptsToday(int count);

  /// No description provided for @intruderAlertsSaved.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No alerts saved} =1{1 alert saved} other{{count} alerts saved}}'**
  String intruderAlertsSaved(int count);

  /// No description provided for @intruderAlertsShownOfTotal.
  ///
  /// In en, this message translates to:
  /// **'Showing {shown} of {total} saved alerts'**
  String intruderAlertsShownOfTotal(int shown, int total);

  /// No description provided for @intruderMethodPin.
  ///
  /// In en, this message translates to:
  /// **'PIN'**
  String get intruderMethodPin;

  /// No description provided for @intruderMethodPattern.
  ///
  /// In en, this message translates to:
  /// **'Pattern'**
  String get intruderMethodPattern;

  /// No description provided for @intruderMethodBiometric.
  ///
  /// In en, this message translates to:
  /// **'Biometric'**
  String get intruderMethodBiometric;

  /// No description provided for @intruderMainUnlock.
  ///
  /// In en, this message translates to:
  /// **'Main Unlock'**
  String get intruderMainUnlock;

  /// No description provided for @intruderYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get intruderYesterday;

  /// No description provided for @intruderEvidenceSavedTo.
  ///
  /// In en, this message translates to:
  /// **'Evidence saved to {path}'**
  String intruderEvidenceSavedTo(String path);

  /// No description provided for @intruderEvidenceSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save evidence'**
  String get intruderEvidenceSaveFailed;

  /// No description provided for @intruderAlertDeleted.
  ///
  /// In en, this message translates to:
  /// **'Alert deleted'**
  String get intruderAlertDeleted;

  /// No description provided for @intruderDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not delete alert'**
  String get intruderDeleteFailed;

  /// No description provided for @intruderNoAlertsTitle.
  ///
  /// In en, this message translates to:
  /// **'No intruder alerts yet'**
  String get intruderNoAlertsTitle;

  /// No description provided for @intruderNoAlertsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'After 3 failed unlock attempts, App Lock silently takes a photo of the intruder and saves it here.'**
  String get intruderNoAlertsSubtitle;

  /// No description provided for @lockBiometricReason.
  ///
  /// In en, this message translates to:
  /// **'Confirm your identity to unlock'**
  String get lockBiometricReason;

  /// No description provided for @lockEnableBiometricReason.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to enable biometric unlock'**
  String get lockEnableBiometricReason;

  /// No description provided for @lockDeviceAuthReason.
  ///
  /// In en, this message translates to:
  /// **'Verify it\'s you with your device screen lock'**
  String get lockDeviceAuthReason;

  /// No description provided for @lockDeviceNotSecureError.
  ///
  /// In en, this message translates to:
  /// **'Set up a screen lock on your device to recover access.'**
  String get lockDeviceNotSecureError;

  /// No description provided for @lockAuthFailedError.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Try again.'**
  String get lockAuthFailedError;

  /// No description provided for @lockUsageAccessNeeded.
  ///
  /// In en, this message translates to:
  /// **'Grant Usage Access to start protection.'**
  String get lockUsageAccessNeeded;

  /// No description provided for @lockPasscodeUpdated.
  ///
  /// In en, this message translates to:
  /// **'Passcode updated'**
  String get lockPasscodeUpdated;

  /// No description provided for @lockPatternUpdated.
  ///
  /// In en, this message translates to:
  /// **'Pattern updated'**
  String get lockPatternUpdated;

  /// No description provided for @lockSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save. Please try again.'**
  String get lockSaveFailed;

  /// No description provided for @lockPremiumPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium Plan'**
  String get lockPremiumPlanTitle;

  /// No description provided for @lockPremiumPlanDesc.
  ///
  /// In en, this message translates to:
  /// **'All premium features are unlocked.'**
  String get lockPremiumPlanDesc;

  /// No description provided for @lockContactFormIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and a message.'**
  String get lockContactFormIncomplete;

  /// No description provided for @lockContactInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get lockContactInvalidEmail;

  /// No description provided for @lockContactNoEmailApp.
  ///
  /// In en, this message translates to:
  /// **'No email app found. Please write to {email}'**
  String lockContactNoEmailApp(String email);

  /// No description provided for @lockOpenLinkFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the link.'**
  String get lockOpenLinkFailed;

  /// No description provided for @lockBatteryOptimizationTitle.
  ///
  /// In en, this message translates to:
  /// **'Battery optimization'**
  String get lockBatteryOptimizationTitle;

  /// No description provided for @lockBatteryOptimizationDesc.
  ///
  /// In en, this message translates to:
  /// **'Set App Lock to \"Not optimized\" so protection keeps running.'**
  String get lockBatteryOptimizationDesc;

  /// No description provided for @vaultItemsProtectedUnlimited.
  ///
  /// In en, this message translates to:
  /// **'{count} items protected'**
  String vaultItemsProtectedUnlimited(int count);

  /// No description provided for @vaultLimitReachedTitle.
  ///
  /// In en, this message translates to:
  /// **'Vault limit reached'**
  String get vaultLimitReachedTitle;

  /// No description provided for @vaultLimitReachedDesc.
  ///
  /// In en, this message translates to:
  /// **'The free plan protects up to {limit} items. Upgrade to Premium for unlimited vault storage.'**
  String vaultLimitReachedDesc(int limit);

  /// No description provided for @vaultUpgradeButton.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get vaultUpgradeButton;

  /// No description provided for @vaultOperationFailed.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get vaultOperationFailed;

  /// No description provided for @vaultSizeBytes.
  ///
  /// In en, this message translates to:
  /// **'{size} B'**
  String vaultSizeBytes(String size);

  /// No description provided for @vaultSizeKb.
  ///
  /// In en, this message translates to:
  /// **'{size} KB'**
  String vaultSizeKb(String size);

  /// No description provided for @vaultSizeMb.
  ///
  /// In en, this message translates to:
  /// **'{size} MB'**
  String vaultSizeMb(String size);

  /// No description provided for @vaultSizeGb.
  ///
  /// In en, this message translates to:
  /// **'{size} GB'**
  String vaultSizeGb(String size);

  /// No description provided for @vaultItemSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{date} • {size}'**
  String vaultItemSubtitle(String date, String size);

  /// No description provided for @vaultEncryptionAes256.
  ///
  /// In en, this message translates to:
  /// **'AES-256'**
  String get vaultEncryptionAes256;

  /// No description provided for @vaultTypePhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get vaultTypePhoto;

  /// No description provided for @vaultTypeVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get vaultTypeVideo;

  /// No description provided for @vaultPhotosEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No photos yet'**
  String get vaultPhotosEmptyTitle;

  /// No description provided for @vaultVideosEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No videos yet'**
  String get vaultVideosEmptyTitle;

  /// No description provided for @vaultDetailEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap + to choose items with the system photo picker. They are encrypted on this device.'**
  String get vaultDetailEmptySubtitle;

  /// No description provided for @vaultPreviewUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Preview unavailable'**
  String get vaultPreviewUnavailable;

  /// No description provided for @appsCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get appsCategoryOther;

  /// No description provided for @dialogAdvertisementDownload.
  ///
  /// In en, this message translates to:
  /// **'Download Now'**
  String get dialogAdvertisementDownload;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
