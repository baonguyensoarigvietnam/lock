// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'AppLock';

  @override
  String get appLockTitle => 'App-Sperre';

  @override
  String get continueButton => 'Weiter';

  @override
  String get getStartedButton => 'Loslegen';

  @override
  String get skipButton => 'Überspringen';

  @override
  String get cancelButton => 'Abbrechen';

  @override
  String get saveButton => 'Speichern';

  @override
  String get doneButton => 'Fertig';

  @override
  String get resetButton => 'Zurücksetzen';

  @override
  String get deleteAction => 'Löschen';

  @override
  String get infoAction => 'Info';

  @override
  String get seeAllAction => 'Alle ansehen';

  @override
  String get navHome => 'Start';

  @override
  String get navApps => 'Apps';

  @override
  String get navVault => 'Tresor';

  @override
  String get navAlerts => 'Warnungen';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get splashSubtitle => 'Schützen Sie Ihre privaten Inhalte';

  @override
  String get onboardingStep1Title => 'Schützen Sie Ihre Privatsphäre';

  @override
  String get onboardingStep1Desc =>
      'Schützen Sie private Fotos, Videos und sensible Zugriffe auf diesem Gerät.';

  @override
  String get onboardingStep2Title => 'Nur lokaler Schutz';

  @override
  String get onboardingStep2Subtitle =>
      'Ihre Daten verlassen niemals Ihr Gerät.';

  @override
  String get onboardingNoAccountTitle => 'Kein Konto';

  @override
  String get onboardingNoAccountDesc =>
      'Wir fragen weder nach E-Mail noch Telefonnummer, um die App zu nutzen.';

  @override
  String get onboardingNoCloudTitle => 'Keine Cloud-Synchronisierung';

  @override
  String get onboardingNoCloudDesc =>
      'Ihre Daten werden niemals auf externe Server oder Clouds hochgeladen.';

  @override
  String get onboardingNoRecoveryTitle => 'Keine Server-Wiederherstellung';

  @override
  String get onboardingNoRecoveryDesc =>
      'Wenn Sie Ihre PIN verlieren, können wir Ihre Daten nicht wiederherstellen.';

  @override
  String get onboardingVaultStaysTitle => 'Tresor-Dateien bleiben hier';

  @override
  String get onboardingVaultStaysDesc =>
      'Alles im Tresor bleibt ausschließlich auf diesem Gerät gespeichert.';

  @override
  String get unlockMethodTitle => 'Entsperrmethode einrichten';

  @override
  String get unlockMethodSubtitle =>
      'Wählen Sie, wie Sie Ihre privaten Inhalte entsperren möchten.';

  @override
  String get createPinTitle => 'PIN erstellen';

  @override
  String get createPinSubtitle => '4- bis 8-stelliger Zahlencode';

  @override
  String get drawPatternTitle => 'Muster zeichnen';

  @override
  String get drawPatternSubtitle => 'Mindestens 4 Punkte verbinden';

  @override
  String get unlockMethodWarning =>
      'Gut aufbewahren. Tresordaten können nicht wiederhergestellt werden, wenn Sie ihn vergessen und Biometrie nicht verfügbar ist.';

  @override
  String get createYourPinTitle => 'Erstellen Sie Ihre PIN';

  @override
  String get confirmYourPinTitle => 'Bestätigen Sie Ihre PIN';

  @override
  String get changePasscodeTitle => 'Passcode ändern';

  @override
  String get confirmYourPasscodeTitle => 'Bestätigen Sie Ihren Passcode';

  @override
  String get usePinToAccessSubtitle =>
      'Verwenden Sie diese PIN für den Zugriff auf geschützte Inhalte.';

  @override
  String get reEnterPinSubtitle =>
      'Geben Sie Ihre PIN zur Bestätigung erneut ein.';

  @override
  String get reEnterPinShort => 'PIN erneut eingeben.';

  @override
  String get pinDoesNotMatchError => 'PIN stimmt nicht überein.';

  @override
  String get usePatternInstead => 'Stattdessen Muster verwenden';

  @override
  String get usePinInstead => 'Stattdessen PIN verwenden';

  @override
  String get drawUnlockPatternTitle => 'Entsperrmuster zeichnen';

  @override
  String get confirmYourPatternTitle => 'Bestätigen Sie Ihr Muster';

  @override
  String get connectAtLeast4Dots => 'Verbinden Sie mindestens 4 Punkte.';

  @override
  String get drawPatternAgainConfirm =>
      'Zeichnen Sie Ihr Muster zur Bestätigung erneut.';

  @override
  String get patternDoesNotMatchError => 'Muster stimmt nicht überein';

  @override
  String get enableBiometricTitle => 'Biometrisches Fallback aktivieren';

  @override
  String get enableBiometricSubtitle =>
      'Nutzen Sie Fingerabdruck oder Gesichtsscan Ihres Geräts, um bei Bedarf wieder Zugriff zu erhalten.';

  @override
  String get fasterUnlockTitle => 'Schnelleres Entsperren';

  @override
  String get fasterUnlockSubtitle =>
      'Schneller Zugriff auf Ihren Tresor ohne Tippen.';

  @override
  String get usesDeviceSecurityTitle => 'Nutzt die Gerätesicherheit';

  @override
  String get usesDeviceSecuritySubtitle =>
      'Verwendet die integrierte Biometrie-Hardware.';

  @override
  String get helpsForgetPinTitle => 'Hilft bei vergessener PIN';

  @override
  String get helpsForgetPinSubtitle =>
      'Ein sicherer alternativer Weg zurück in die App.';

  @override
  String get biometricInfoNote =>
      'Das biometrische Fallback funktioniert nur, wenn es vor dem Vergessen der PIN aktiviert wurde.';

  @override
  String get enableBiometricButton => 'Biometrie aktivieren';

  @override
  String get setUpPermissionsTitle => 'Berechtigungen einrichten';

  @override
  String get permissionGuideSubtitle =>
      'Aktivieren Sie die erforderlichen Berechtigungen für App-Sperre, Tresor und Warnungen. Optionale Funktionen können später aktiviert werden.';

  @override
  String get usageAccessTitle => 'Nutzungszugriff';

  @override
  String get usageAccessDesc =>
      'Erkennt das Öffnen ausgewählter Apps, um den Entsperrbildschirm anzuzeigen.';

  @override
  String get displayOverOtherAppsTitle => 'Über anderen Apps einblenden';

  @override
  String get displayOverOtherAppsDesc =>
      'Zeigt den Entsperrbildschirm zuverlässig über geschützten Apps an.';

  @override
  String get notificationsTitle => 'Benachrichtigungen';

  @override
  String get notificationsDesc =>
      'Zeigt Schutzstatus, Sicherheitswarnungen und Berechtigungshinweise an.';

  @override
  String get cameraTitle => 'Kamera';

  @override
  String get cameraDesc =>
      'Macht nach 3 fehlgeschlagenen Entsperrversuchen ein Foto mit der Frontkamera.';

  @override
  String get badgeRequired => 'ERFORDERLICH';

  @override
  String get badgeRecommended => 'EMPFOHLEN';

  @override
  String get badgeIntruder => 'EINDRINGLING';

  @override
  String get upgradeToPremium => 'Auf Premium upgraden';

  @override
  String get paywallSubtitle =>
      'Schalten Sie weitere Themen frei und entfernen Sie Werbung.';

  @override
  String get paywallFeatureThemes => 'Zukünftige Premium-Themen';

  @override
  String get paywallFeatureVault => 'Unbegrenzter Tresor';

  @override
  String get paywallFeatureAlerts => 'Vollständiger Warnungsverlauf';

  @override
  String get paywallFeatureNoAds => 'Keine Werbung';

  @override
  String get monthlyPlanTitle => 'Monatlich';

  @override
  String get monthlyPlanSubtitle => 'Monatliche Abrechnung';

  @override
  String get yearlyPlanTitle => 'Jährlich';

  @override
  String get yearlyPlanSubtitle => 'Jährliche Abrechnung';

  @override
  String get save40Badge => '40% SPAREN';

  @override
  String wasPrice(String price) {
    return 'vorher $price';
  }

  @override
  String get startPremiumButton => 'Premium starten';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get termsLink => 'AGB';

  @override
  String get privacyPolicyLink => 'Datenschutzrichtlinie';

  @override
  String unlockAppTitle(String appName) {
    return '$appName entsperren';
  }

  @override
  String get enterPinToContinue => 'Geben Sie Ihre PIN ein, um fortzufahren.';

  @override
  String get incorrectPinTryAgain => 'Falsche PIN. Bitte erneut versuchen.';

  @override
  String get incorrectPatternTryAgain =>
      'Falsches Muster. Bitte erneut versuchen.';

  @override
  String get forgotPinLink => 'PIN vergessen?';

  @override
  String get forgotPatternLink => 'Muster vergessen?';

  @override
  String get useBiometricUnlockTitle => 'Biometrisches Entsperren verwenden';

  @override
  String get unlockWithDeviceAuthSubtitle =>
      'Mit Geräteauthentifizierung entsperren.';

  @override
  String get biometricNotRecognized => 'BIOMETRIE NICHT ERKANNT';

  @override
  String get recoverAccessTitle => 'Zugriff wiederherstellen';

  @override
  String get useBiometricFallbackCardTitle => 'Biometrisches Fallback nutzen';

  @override
  String get useBiometricFallbackCardDesc =>
      'Authentifizieren Sie sich biometrisch und erstellen Sie dann eine neue PIN oder ein Muster.';

  @override
  String get authenticateButton => 'Authentifizieren';

  @override
  String get vaultCannotBeRecoveredTitle => 'Tresor nicht wiederherstellbar';

  @override
  String get vaultCannotBeRecoveredDesc =>
      'Ohne PIN, Muster oder biometrisches Fallback können verschlüsselte Tresordaten nicht wiederhergestellt werden.';

  @override
  String get resetAppSecurityButton => 'App-Sicherheit zurücksetzen';

  @override
  String get backToUnlockLink => 'Zurück zum Entsperren';

  @override
  String get resetSecurityQuestionTitle => 'Sicherheit zurücksetzen?';

  @override
  String get resetSecurityWarningDesc =>
      'Dadurch wird der Schlüsselumschlag gelöscht.\nVerschlüsselte Tresordaten sind danach nicht mehr\nzugänglich.';

  @override
  String get resetSecurityConfirmCheckbox =>
      'Ich verstehe, dass dies nicht rückgängig\ngemacht werden kann';

  @override
  String get statusActive => 'AKTIV';

  @override
  String get statusIdle => 'INAKTIV';

  @override
  String get appsProtectedLabel => 'Geschützte Apps';

  @override
  String get vaultItemsLabel => 'Tresor-Elemente';

  @override
  String get intruderAlertsLabel => 'Eindringlingswarnungen';

  @override
  String get biometricFallbackLabel => 'Biometrisches Fallback';

  @override
  String get quickActionsTitle => 'Schnellaktionen';

  @override
  String get lockAppsAction => 'Apps sperren';

  @override
  String get themesAction => 'Themen';

  @override
  String get promoBannerTitle => 'ALLE FUNKTIONEN FREISCHALTEN';

  @override
  String get promoBannerSubtitle =>
      'Unbegrenzte Themen, werbefrei und vieles mehr.';

  @override
  String get themeMinimal => 'Minimal';

  @override
  String get themeClassicPin => 'Klassische PIN';

  @override
  String get themePattern => 'Muster';

  @override
  String get themeVault => 'Tresor';

  @override
  String get themeFocus => 'Fokus';

  @override
  String get themePremiumColors => 'Premium-Farben';

  @override
  String get premiumBadge => 'PREMIUM';

  @override
  String get applyThemeButton => 'Thema anwenden';

  @override
  String get themeAppliedTitle => 'Thema angewendet';

  @override
  String get themeAppliedSubtitle =>
      'Ihre Sperrbildschirme verwenden jetzt das\nausgewählte Thema.';

  @override
  String get premiumColorPreviewTitle => 'Premium-Farbvorschau';

  @override
  String get premiumThemesSubscriptionNote =>
      'Premium-Themen sind mit einem Abonnement verfügbar.';

  @override
  String get backToThemesButton => 'Zurück zu Themen';

  @override
  String get lockedAppsHeader => 'Gesperrte Apps';

  @override
  String protectedAppsCount(int count) {
    return '$count geschützte Apps';
  }

  @override
  String get searchAppsHint => 'Apps suchen...';

  @override
  String get filterAll => 'Alle';

  @override
  String get filterCategories => 'Kategorien';

  @override
  String get filterLocked => 'Gesperrt';

  @override
  String categoryChipLabel(String category) {
    return 'Kategorie: $category';
  }

  @override
  String get noLockedAppsFound => 'Keine gesperrten Apps gefunden';

  @override
  String get noAppsFound => 'Keine Apps gefunden';

  @override
  String get categorySocial => 'Soziale Netzwerke';

  @override
  String get categoryMessaging => 'Messaging';

  @override
  String get categoryPhotosVideo => 'Fotos & Videos';

  @override
  String get categoryFinance => 'Finanzen';

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
    return '$count geschützt';
  }

  @override
  String get usageAccessRequiredTitle => 'Nutzungszugriff erforderlich';

  @override
  String get usageAccessRequiredDesc =>
      'Aktivieren Sie den Nutzungszugriff, um ausgewählte\nApps zu schützen.';

  @override
  String get enableUsageAccessButton => 'Nutzungszugriff aktivieren';

  @override
  String get protectionMayBeLimitedTitle =>
      'Schutz möglicherweise eingeschränkt';

  @override
  String get protectionMayBeLimitedDesc =>
      'Damit App-Sperre zuverlässig im Hintergrund arbeitet, überprüfen Sie bitte folgende Android-Systemeinstellungen.';

  @override
  String get displayOverOtherAppsWarningDesc =>
      'Erforderlich, um den Sperrbildschirm über geschützten Apps anzuzeigen.';

  @override
  String get statusDisabled => 'Deaktiviert';

  @override
  String get batteryOptimizationTitle => 'Akku-Optimierung';

  @override
  String get batteryOptimizationDesc =>
      'Android kann die App im Hintergrund beenden. Deaktivieren Sie die Optimierung für dauerhaften Schutz.';

  @override
  String get statusRestricted => 'Eingeschränkt';

  @override
  String get fixPermissionsButton => 'Berechtigungen korrigieren';

  @override
  String get continueWithLimitedProtectionButton =>
      'Mit eingeschränktem Schutz fortfahren';

  @override
  String itemsProtectedCount(int count) {
    return '$count/100 Elemente geschützt';
  }

  @override
  String get encryptedOnThisDevice => 'Auf diesem Gerät verschlüsselt';

  @override
  String get quickActionsSmallTitle => 'Schnellaktionen';

  @override
  String get addPhotosAction => 'Fotos\nhinzufügen';

  @override
  String get importVideosAction => 'Videos\nimportieren';

  @override
  String get albumsHeader => 'Alben';

  @override
  String get vaultEmptyTitle => 'Ihr Tresor ist leer';

  @override
  String get vaultEmptySubtitle =>
      'Importieren Sie Fotos und Videos, um sie\nauf diesem Gerät verschlüsselt aufzubewahren.';

  @override
  String get albumVideos => 'Videos';

  @override
  String get albumPhotos => 'Fotos';

  @override
  String vaultAlbumItemsCount(int count) {
    return '$count Elemente';
  }

  @override
  String vaultItemsProtectedSubtitle(int count) {
    return '$count Elemente • Geschützt';
  }

  @override
  String get encryptingItemsTitle =>
      'Ausgewählte Elemente werden verschlüsselt...';

  @override
  String filesProcessedProgress(int processed, int total) {
    return '$processed von $total Dateien verarbeitet';
  }

  @override
  String get keepAppOpenWarning =>
      'Lassen Sie die App geöffnet, bis der Import abgeschlossen ist.';

  @override
  String get importCompleteTitle => 'Import abgeschlossen';

  @override
  String get importCompleteSubtitle =>
      'Ihre Daten sind nun gesichert und verschlüsselt.';

  @override
  String itemsEncryptedTitle(int count) {
    return '$count Elemente verschlüsselt';
  }

  @override
  String get aes256Subtitle => 'AES-256 Militärstandard';

  @override
  String get originalsCouldNotBeDeletedTitle =>
      'Originale konnten nicht automatisch\ngelöscht werden';

  @override
  String get nextStepRequiredTitle => 'Nächster Schritt erforderlich';

  @override
  String get deleteOriginalsManuallyDesc =>
      'Öffnen Sie Fotos oder Galerie, um\nOriginale manuell zu löschen.';

  @override
  String get viewVaultButton => 'Tresor ansehen';

  @override
  String get backToVaultHomeLink => 'Zurück zur Tresor-Startseite';

  @override
  String get fileInfoTitle => 'Datei-Info';

  @override
  String get protectedBadge => 'Geschützt';

  @override
  String get propertiesHeader => 'Eigenschaften';

  @override
  String get propertyName => 'Name';

  @override
  String get propertyType => 'Typ';

  @override
  String get propertySize => 'Größe';

  @override
  String get propertyImportedDate => 'Importdatum';

  @override
  String get propertyEncryptionStatus => 'Verschlüsselungsstatus';

  @override
  String get intruderSelfieOffTitle => 'Eindringlings-Selfie ist aus';

  @override
  String get intruderSelfieOffSubtitle =>
      'Aktivieren, um nach 3 fehlgeschlagenen\nEntsperrversuchen ein Foto aufzunehmen.';

  @override
  String get secureLogsTitle => 'Sichere Protokolle';

  @override
  String get secureLogsSubtitle =>
      'Datum, Uhrzeit und Foto unbefugter\nZugriffsversuche ansehen.';

  @override
  String get stealthCaptureTitle => 'Heimliche Aufnahme';

  @override
  String get stealthCaptureSubtitle =>
      'Die Frontkamera nimmt das Foto\ngeräuschlos auf.';

  @override
  String get enableIntruderSelfieButton => 'Eindringlings-Selfie aktivieren';

  @override
  String get cameraPermissionDeniedTitle => 'Kameraberechtigung verweigert';

  @override
  String get cameraPermissionDeniedSubtitle =>
      'Eindringlingsereignisse können weiterhin\nohne Foto protokolliert werden.';

  @override
  String get intruderLoggingTitle => 'Eindringlings-Protokollierung';

  @override
  String get intruderLoggingSubtitle =>
      'Uhrzeit, Datum und versuchte PINs werden weiterhin\nin Ihrem Sicherheitstresor gespeichert.';

  @override
  String get privacyFirstTitle => 'Privatsphäre zuerst';

  @override
  String get privacyFirstSubtitle =>
      'Ohne Ihre ausdrückliche Kameraberechtigung werden\nkeine Fotos aufgenommen oder gespeichert.';

  @override
  String get openSettingsButton => 'Einstellungen öffnen';

  @override
  String get statusSummaryTitle => 'Statusübersicht';

  @override
  String failedMethodLabel(String method) {
    return 'Fehlgeschlagene Methode: $method';
  }

  @override
  String get viewDetailsAction => 'Details ansehen';

  @override
  String get keepFullAlertHistoryTitle =>
      'Vollständigen Warnungsverlauf behalten';

  @override
  String get keepFullAlertHistoryDesc =>
      'Kostenlose Nutzer sehen nur die letzten 10\nWarnungen. Für unbegrenzte Speicherung upgraden.';

  @override
  String get alertDetailTitle => 'Warnungsdetails';

  @override
  String get noPhotoCapturedTitle => 'Kein Foto aufgenommen';

  @override
  String get noPhotoCapturedDesc =>
      'Das Sicherheitssystem konnte die Kamera\nwährend dieses Ereignisses nicht\ninitialisieren.';

  @override
  String get eventSummaryHeader => 'EREIGNISÜBERSICHT';

  @override
  String get highAlertBadge => 'Hohe Warnstufe';

  @override
  String get captureAnalysisTitle => 'Aufnahmeanalyse';

  @override
  String get attemptedContextLabel => 'Versuchter Kontext';

  @override
  String get failedMethodRowLabel => 'Fehlgeschlagene Methode';

  @override
  String get failedCountLabel => 'Fehlversuche';

  @override
  String get dateTimeLabel => 'Datum/Uhrzeit';

  @override
  String get saveEvidenceButton => 'Beweis sichern';

  @override
  String get enableCameraPermissionButton => 'Kameraberechtigung aktivieren';

  @override
  String get deleteAlertButton => 'Warnung löschen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsSubtitle => 'Verwalten Sie Ihre App-Einstellungen.';

  @override
  String get freePlanTitle => 'Kostenloser Tarif';

  @override
  String get freeBadge => 'KOSTENLOS';

  @override
  String get freePlanDesc =>
      'Upgraden Sie auf Premium für erweiterte\nSicherheitsfunktionen.';

  @override
  String get securitySectionHeader => 'Sicherheit';

  @override
  String get biometricUnlockTitle => 'Biometrische Entsperrung';

  @override
  String get biometricUnlockSubtitle => 'Face ID / Touch ID verwenden';

  @override
  String get autoLockDelayTitle => 'Automatische Sperrverzögerung';

  @override
  String get helpAndSupportHeader => 'Hilfe & Support';

  @override
  String get languagesTitle => 'Sprachen';

  @override
  String get contactUsTitle => 'Kontakt';

  @override
  String get termsOfServiceTitle => 'Nutzungsbedingungen';

  @override
  String get requireAuthenticationTitle => 'Authentifizierung anfordern';

  @override
  String get requireAuthenticationSubtitle =>
      'Wählen Sie, wie schnell die App nach dem Verlassen sperrt.\nKürzere Zeiten bieten stärkeren Schutz Ihrer\nPrivatsphäre.';

  @override
  String get delayImmediately => 'Sofort';

  @override
  String get delay15Seconds => 'Nach 15 Sekunden';

  @override
  String get delay30Seconds => 'Nach 30 Sekunden';

  @override
  String get delay1Minute => 'Nach 1 Minute';

  @override
  String get delayScreenOff => 'Wenn der Bildschirm ausgeht';

  @override
  String get settingLanguagesTitle => 'Spracheinstellungen';

  @override
  String get settingLanguagesSubtitle =>
      'Wählen Sie Ihre bevorzugte Sprache für die Oberfläche\nund die Dokumentenerkennung.';

  @override
  String get langEnglish => 'Englisch (English)';

  @override
  String get langVietnamese => 'Vietnamesisch (Vietnamese)';

  @override
  String get langSpanish => 'Spanisch (Spanish)';

  @override
  String get langFrench => 'Französisch (French)';

  @override
  String get langGerman => 'Deutsch';

  @override
  String get langJapanese => 'Japanisch (Japanese)';

  @override
  String get langChinese => 'Chinesisch (Chinese)';

  @override
  String get contactUsIntro =>
      'Wir helfen gerne. Füllen Sie das Formular unten aus und\nunser Support-Team meldet sich schnellstmöglich\nbei Ihnen.';

  @override
  String get emailAddressLabel => 'E-Mail-Adresse';

  @override
  String get emailHint => 'sie@beispiel.de';

  @override
  String get subjectLabel => 'Betreff';

  @override
  String get subjectHint => 'Kurze Zusammenfassung Ihres Anliegens';

  @override
  String get messageLabel => 'Nachricht';

  @override
  String get messageHint => 'Beschreiben Sie Ihr Problem im Detail...';

  @override
  String get contactPrivacyDisclaimer =>
      'Mit dem Absenden stimmen Sie unserer Datenschutzrichtlinie zu. Wir\nverwenden Ihre E-Mail nur zur Beantwortung dieser Anfrage.';

  @override
  String get sendMessageButton => 'Nachricht senden';

  @override
  String get biometricNotSupportedError =>
      'Gerät unterstützt keine Biometrie oder ist nicht eingerichtet';

  @override
  String get deleteFromVaultDialogTitle => 'Aus Tresor löschen?';

  @override
  String get deleteFromVaultDialogDesc =>
      'Dadurch wird die verschlüsselte Tresorkopie von diesem Gerät entfernt.';

  @override
  String get deletePermanentlyButton => 'Dauerhaft löschen';

  @override
  String get deleteAlertDialogTitle => 'Warnung löschen?';

  @override
  String get deleteAlertDialogDesc =>
      'Dadurch werden das Eindringlingsfoto und das Ereignisprotokoll von diesem Gerät entfernt.';

  @override
  String get purchaseFallbackMonthlyPrice => '\$2.99';

  @override
  String get purchaseFallbackYearlyPrice => '\$25.99';

  @override
  String get purchaseFallbackYearlyOriginalPrice => '\$35.99';

  @override
  String purchaseSaveBadge(int percent) {
    return '$percent % SPAREN';
  }

  @override
  String get purchaseBillingUnavailable =>
      'Google Play Billing ist auf diesem Gerät nicht verfügbar. Prüfe dein Play Store-Konto und versuche es erneut.';

  @override
  String get purchaseProductsNotFound =>
      'Premium-Tarife sind derzeit nicht verfügbar. Bitte versuche es später erneut.';

  @override
  String get purchaseProductsLoading =>
      'Tarife werden geladen, bitte versuche es gleich noch einmal.';

  @override
  String get purchaseFailed => 'Kauf fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String get purchasePending =>
      'Dein Kauf ist ausstehend. Premium wird freigeschaltet, sobald die Zahlung abgeschlossen ist.';

  @override
  String get purchaseRestoreSuccess =>
      'Käufe wiederhergestellt. Premium ist aktiv.';

  @override
  String get purchaseRestoreNothing => 'Keine früheren Käufe gefunden.';

  @override
  String get purchaseRestoreFailed =>
      'Käufe konnten nicht wiederhergestellt werden. Bitte versuche es erneut.';

  @override
  String get purchaseAlreadyPremium => 'Du bist bereits Premium';

  @override
  String get purchaseOpenLinkFailed => 'Der Link konnte nicht geöffnet werden.';

  @override
  String intruderFailedAttemptsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fehlgeschlagene Entsperrversuche heute',
      one: '1 fehlgeschlagener Entsperrversuch heute',
      zero: 'Heute keine fehlgeschlagenen Entsperrversuche',
    );
    return '$_temp0';
  }

  @override
  String intruderAlertsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Warnungen gespeichert',
      one: '1 Warnung gespeichert',
      zero: 'Keine Warnungen gespeichert',
    );
    return '$_temp0';
  }

  @override
  String intruderAlertsShownOfTotal(int shown, int total) {
    return '$shown von $total gespeicherten Warnungen angezeigt';
  }

  @override
  String get intruderMethodPin => 'PIN';

  @override
  String get intruderMethodPattern => 'Muster';

  @override
  String get intruderMethodBiometric => 'Biometrie';

  @override
  String get intruderMainUnlock => 'Hauptentsperrung';

  @override
  String get intruderYesterday => 'Gestern';

  @override
  String intruderEvidenceSavedTo(String path) {
    return 'Beweis gespeichert unter $path';
  }

  @override
  String get intruderEvidenceSaveFailed =>
      'Beweis konnte nicht gespeichert werden';

  @override
  String get intruderAlertDeleted => 'Warnung gelöscht';

  @override
  String get intruderDeleteFailed => 'Warnung konnte nicht gelöscht werden';

  @override
  String get intruderNoAlertsTitle => 'Noch keine Eindringlingswarnungen';

  @override
  String get intruderNoAlertsSubtitle =>
      'Nach 3 fehlgeschlagenen Entsperrversuchen macht App Lock unbemerkt ein Foto des Eindringlings und speichert es hier.';

  @override
  String get lockBiometricReason => 'Bestätige deine Identität zum Entsperren';

  @override
  String get lockEnableBiometricReason =>
      'Authentifiziere dich, um biometrisches Entsperren zu aktivieren';

  @override
  String get lockDeviceAuthReason =>
      'Bestätige mit der Displaysperre deines Geräts, dass du es bist';

  @override
  String get lockDeviceNotSecureError =>
      'Richte eine Displaysperre auf deinem Gerät ein, um den Zugriff wiederherzustellen.';

  @override
  String get lockAuthFailedError =>
      'Authentifizierung fehlgeschlagen. Versuche es erneut.';

  @override
  String get lockUsageAccessNeeded =>
      'Erteile den Nutzungszugriff, um den Schutz zu starten.';

  @override
  String get lockPasscodeUpdated => 'Code aktualisiert';

  @override
  String get lockPatternUpdated => 'Muster aktualisiert';

  @override
  String get lockSaveFailed =>
      'Speichern fehlgeschlagen. Bitte erneut versuchen.';

  @override
  String get lockPremiumPlanTitle => 'Premium-Tarif';

  @override
  String get lockPremiumPlanDesc =>
      'Alle Premium-Funktionen sind freigeschaltet.';

  @override
  String get lockContactFormIncomplete =>
      'Bitte gib deine E-Mail und eine Nachricht ein.';

  @override
  String get lockContactInvalidEmail =>
      'Bitte gib eine gültige E-Mail-Adresse ein.';

  @override
  String lockContactNoEmailApp(String email) {
    return 'Keine E-Mail-App gefunden. Bitte schreibe an $email';
  }

  @override
  String get lockOpenLinkFailed => 'Link konnte nicht geöffnet werden.';

  @override
  String get lockBatteryOptimizationTitle => 'Akkuoptimierung';

  @override
  String get lockBatteryOptimizationDesc =>
      'Stelle App Lock auf „Nicht optimiert“, damit der Schutz aktiv bleibt.';

  @override
  String vaultItemsProtectedUnlimited(int count) {
    return '$count Elemente geschützt';
  }

  @override
  String get vaultLimitReachedTitle => 'Tresorlimit erreicht';

  @override
  String vaultLimitReachedDesc(int limit) {
    return 'Der kostenlose Plan schützt bis zu $limit Elemente. Upgrade auf Premium für unbegrenzten Speicher.';
  }

  @override
  String get vaultUpgradeButton => 'Upgraden';

  @override
  String get vaultOperationFailed =>
      'Etwas ist schiefgelaufen. Bitte versuche es erneut.';

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
  String get vaultTypePhoto => 'Foto';

  @override
  String get vaultTypeVideo => 'Video';

  @override
  String get vaultPhotosEmptyTitle => 'Noch keine Fotos';

  @override
  String get vaultVideosEmptyTitle => 'Noch keine Videos';

  @override
  String get vaultDetailEmptySubtitle =>
      'Tippe auf +, um Elemente mit der System-Fotoauswahl auszuwählen. Sie werden auf diesem Gerät verschlüsselt.';

  @override
  String get vaultPreviewUnavailable => 'Vorschau nicht verfügbar';

  @override
  String get appsCategoryOther => 'Sonstige';

  @override
  String get dialogAdvertisementDownload => 'Jetzt herunterladen';
}
