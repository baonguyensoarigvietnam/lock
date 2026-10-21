// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'AppLock';

  @override
  String get appLockTitle => 'アプリロック';

  @override
  String get continueButton => '続ける';

  @override
  String get getStartedButton => '始める';

  @override
  String get skipButton => 'スキップ';

  @override
  String get cancelButton => 'キャンセル';

  @override
  String get saveButton => '保存';

  @override
  String get doneButton => '完了';

  @override
  String get resetButton => 'リセット';

  @override
  String get deleteAction => '削除';

  @override
  String get infoAction => '情報';

  @override
  String get seeAllAction => 'すべて見る';

  @override
  String get navHome => 'ホーム';

  @override
  String get navApps => 'アプリ';

  @override
  String get navVault => '金庫';

  @override
  String get navAlerts => 'アラート';

  @override
  String get navSettings => '設定';

  @override
  String get splashSubtitle => 'プライベートなコンテンツを保護';

  @override
  String get onboardingStep1Title => 'プライバシーを保護';

  @override
  String get onboardingStep1Desc => 'プライベートな写真、動画、機密アクセスをこのデバイス上で保護します。';

  @override
  String get onboardingStep2Title => 'ローカルのみの保護';

  @override
  String get onboardingStep2Subtitle => 'データがデバイスから外部に出ることはありません。';

  @override
  String get onboardingNoAccountTitle => 'アカウント不要';

  @override
  String get onboardingNoAccountDesc => 'アプリの利用にメールアドレスや電話番号は不要です。';

  @override
  String get onboardingNoCloudTitle => 'クラウド同期なし';

  @override
  String get onboardingNoCloudDesc => 'データが外部サーバーやクラウドにアップロードされることはありません。';

  @override
  String get onboardingNoRecoveryTitle => 'サーバー側での復元なし';

  @override
  String get onboardingNoRecoveryDesc => 'PINを紛失した場合、当社でデータを復元することはできません。';

  @override
  String get onboardingVaultStaysTitle => 'ファイルは端末内に保持';

  @override
  String get onboardingVaultStaysDesc => '金庫内のすべてのデータはこのデバイス内にのみ保存されます。';

  @override
  String get unlockMethodTitle => 'ロック解除方法の設定';

  @override
  String get unlockMethodSubtitle => 'プライベートコンテンツのロック解除方法を選択してください。';

  @override
  String get createPinTitle => 'PINを作成';

  @override
  String get createPinSubtitle => '4〜8桁の数字コード';

  @override
  String get drawPatternTitle => 'パターンを描画';

  @override
  String get drawPatternSubtitle => '少なくとも4つの点を結ぶ';

  @override
  String get unlockMethodWarning =>
      '大切に保管してください。忘れた場合、生体認証が有効でなければ金庫のデータは復元できません。';

  @override
  String get createYourPinTitle => 'PINを作成';

  @override
  String get confirmYourPinTitle => 'PINの確認';

  @override
  String get changePasscodeTitle => 'パスコードを変更';

  @override
  String get confirmYourPasscodeTitle => 'パスコードの確認';

  @override
  String get usePinToAccessSubtitle => '保護されたコンテンツにアクセスするためにこのPINを使用します。';

  @override
  String get reEnterPinSubtitle => '確認のためもう一度PINを入力してください。';

  @override
  String get reEnterPinShort => 'PINを再入力してください。';

  @override
  String get pinDoesNotMatchError => 'PINが一致しません。';

  @override
  String get usePatternInstead => '代わりにパターンを使用';

  @override
  String get usePinInstead => '代わりにPINを使用';

  @override
  String get drawUnlockPatternTitle => 'ロック解除パターンを描画';

  @override
  String get confirmYourPatternTitle => 'パターンの確認';

  @override
  String get connectAtLeast4Dots => '少なくとも4つの点を結んでください。';

  @override
  String get drawPatternAgainConfirm => '確認のためもう一度パターンを描画してください。';

  @override
  String get patternDoesNotMatchError => 'パターンが一致しません';

  @override
  String get enableBiometricTitle => '生体認証の代替手段を有効化';

  @override
  String get enableBiometricSubtitle => '必要に応じて端末の指紋や顔認証でアクセスを回復できます。';

  @override
  String get fasterUnlockTitle => '素早いロック解除';

  @override
  String get fasterUnlockSubtitle => '入力なしで素早く金庫にアクセスできます。';

  @override
  String get usesDeviceSecurityTitle => '端末のセキュリティを活用';

  @override
  String get usesDeviceSecuritySubtitle => '内蔵の生体認証ハードウェアを活用します。';

  @override
  String get helpsForgetPinTitle => 'PINを忘れた際も安心';

  @override
  String get helpsForgetPinSubtitle => '安全に再アクセスするための代替手段になります。';

  @override
  String get biometricInfoNote => '生体認証による復旧は、PINを忘れる前に有効にしていた場合のみ機能します。';

  @override
  String get enableBiometricButton => '生体認証を有効にする';

  @override
  String get setUpPermissionsTitle => '権限のセットアップ';

  @override
  String get permissionGuideSubtitle =>
      'アプリロック、金庫、セキュリティ警告に必要な権限を有効にします。オプション機能はスキップして後でオンにできます。';

  @override
  String get usageAccessTitle => '使用状況へのアクセス';

  @override
  String get usageAccessDesc => '選択したアプリが起動されたことを検知し、ロック解除画面を表示します。';

  @override
  String get displayOverOtherAppsTitle => '他のアプリの上に重ねて表示';

  @override
  String get displayOverOtherAppsDesc => '保護されたアプリの上にロック画面を表示し、信頼性を高めます。';

  @override
  String get notificationsTitle => '通知';

  @override
  String get notificationsDesc => '保護ステータス、セキュリティ警告、権限の警告を表示します。';

  @override
  String get cameraTitle => 'カメラ';

  @override
  String get cameraDesc => 'ロック解除に3回失敗するとフロントカメラで写真を撮影します。';

  @override
  String get badgeRequired => '必須';

  @override
  String get badgeRecommended => '推奨';

  @override
  String get badgeIntruder => '侵入者';

  @override
  String get upgradeToPremium => 'プレミアムにアップグレード';

  @override
  String get paywallSubtitle => 'さらに多くのテーマを解放し、広告を非表示にします。';

  @override
  String get paywallFeatureThemes => '今後のプレミアムテーマ';

  @override
  String get paywallFeatureVault => '無制限の金庫';

  @override
  String get paywallFeatureAlerts => '完全な侵入警告履歴';

  @override
  String get paywallFeatureNoAds => '広告なし';

  @override
  String get monthlyPlanTitle => '月額プラン';

  @override
  String get monthlyPlanSubtitle => '毎月請求';

  @override
  String get yearlyPlanTitle => '年額プラン';

  @override
  String get yearlyPlanSubtitle => '毎年請求';

  @override
  String get save40Badge => '40%お得';

  @override
  String wasPrice(String price) {
    return '通常 $price';
  }

  @override
  String get startPremiumButton => 'プレミアムを開始';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get termsLink => '利用規約';

  @override
  String get privacyPolicyLink => 'プライバシーポリシー';

  @override
  String unlockAppTitle(String appName) {
    return '$appName のロックを解除';
  }

  @override
  String get enterPinToContinue => '続行するにはPINを入力してください。';

  @override
  String get incorrectPinTryAgain => 'PINが正しくありません。もう一度お試しください。';

  @override
  String get incorrectPatternTryAgain => 'パターンが正しくありません。もう一度お試しください。';

  @override
  String get forgotPinLink => 'PINをお忘れですか？';

  @override
  String get forgotPatternLink => 'パターンをお忘れですか？';

  @override
  String get useBiometricUnlockTitle => '生体認証でロック解除';

  @override
  String get unlockWithDeviceAuthSubtitle => 'デバイスの認証機能でロックを解除します。';

  @override
  String get biometricNotRecognized => '生体認証を認識できませんでした';

  @override
  String get recoverAccessTitle => 'アクセスの回復';

  @override
  String get useBiometricFallbackCardTitle => '生体認証の代替手段を使用';

  @override
  String get useBiometricFallbackCardDesc =>
      '端末の生体認証で認証した後、新しいPINまたはパターンを作成します。';

  @override
  String get authenticateButton => '認証する';

  @override
  String get vaultCannotBeRecoveredTitle => '金庫は復元できません';

  @override
  String get vaultCannotBeRecoveredDesc =>
      'PIN、パターン、または生体認証がない場合、暗号化された金庫データは復元できません。';

  @override
  String get resetAppSecurityButton => 'アプリのセキュリティをリセット';

  @override
  String get backToUnlockLink => 'ロック解除に戻る';

  @override
  String get resetSecurityQuestionTitle => 'セキュリティをリセットしますか？';

  @override
  String get resetSecurityWarningDesc =>
      'これにより鍵データが削除されます。\n暗号化された金庫のデータには今後アクセス\nできなくなります。';

  @override
  String get resetSecurityConfirmCheckbox => 'この操作は元に戻せないことを\n理解しました';

  @override
  String get statusActive => '有効';

  @override
  String get statusIdle => '待機中';

  @override
  String get appsProtectedLabel => '保護されたアプリ';

  @override
  String get vaultItemsLabel => '金庫のアイテム';

  @override
  String get intruderAlertsLabel => '侵入者アラート';

  @override
  String get biometricFallbackLabel => '生体認証の代替';

  @override
  String get quickActionsTitle => 'クイックアクション';

  @override
  String get lockAppsAction => 'アプリをロック';

  @override
  String get themesAction => 'テーマ';

  @override
  String get promoBannerTitle => 'すべての機能をアンロック';

  @override
  String get promoBannerSubtitle => '無制限のテーマ、広告なし、その他多数の特典。';

  @override
  String get themeMinimal => 'ミニマル';

  @override
  String get themeClassicPin => 'クラシックPIN';

  @override
  String get themePattern => 'パターン';

  @override
  String get themeVault => '金庫';

  @override
  String get themeFocus => 'フォーカス';

  @override
  String get themePremiumColors => 'プレミアムカラー';

  @override
  String get premiumBadge => 'プレミアム';

  @override
  String get applyThemeButton => 'テーマを適用';

  @override
  String get themeAppliedTitle => 'テーマを適用しました';

  @override
  String get themeAppliedSubtitle => 'ロック画面に選択したテーマが\n適用されました。';

  @override
  String get premiumColorPreviewTitle => 'プレミアムカラーのプレビュー';

  @override
  String get premiumThemesSubscriptionNote => 'プレミアムテーマはサブスクリプションでご利用いただけます。';

  @override
  String get backToThemesButton => 'テーマ一覧に戻る';

  @override
  String get lockedAppsHeader => 'ロック中のアプリ';

  @override
  String protectedAppsCount(int count) {
    return '$count 個の保護されたアプリ';
  }

  @override
  String get searchAppsHint => 'アプリを検索...';

  @override
  String get filterAll => 'すべて';

  @override
  String get filterCategories => 'カテゴリ';

  @override
  String get filterLocked => 'ロック中';

  @override
  String categoryChipLabel(String category) {
    return 'カテゴリ: $category';
  }

  @override
  String get noLockedAppsFound => 'ロックされたアプリが見つかりません';

  @override
  String get noAppsFound => 'アプリが見つかりません';

  @override
  String get categorySocial => 'ソーシャル';

  @override
  String get categoryMessaging => 'メッセージ';

  @override
  String get categoryPhotosVideo => '写真＆動画';

  @override
  String get categoryFinance => 'ファイナンス';

  @override
  String get categoryShopping => 'ショッピング';

  @override
  String get categorySystem => 'システム';

  @override
  String categoryAppsBullet(int count) {
    return '$count アプリ • ';
  }

  @override
  String categoryProtectedCount(int count) {
    return '$count 件保護中';
  }

  @override
  String get usageAccessRequiredTitle => '使用状況へのアクセスが必要です';

  @override
  String get usageAccessRequiredDesc =>
      '選択したアプリを保護するには、使用状況への\nアクセスを有効にしてください。';

  @override
  String get enableUsageAccessButton => '使用状況へのアクセスを有効化';

  @override
  String get protectionMayBeLimitedTitle => '保護が制限される可能性があります';

  @override
  String get protectionMayBeLimitedDesc =>
      'バックグラウンドで確実に動作させるため、以下のAndroidシステム設定をご確認ください。';

  @override
  String get displayOverOtherAppsWarningDesc => '保護されたアプリの上にロック画面を表示するために必要です。';

  @override
  String get statusDisabled => '無効';

  @override
  String get batteryOptimizationTitle => 'バッテリーの最適化';

  @override
  String get batteryOptimizationDesc =>
      'Androidがバックグラウンドでアプリを終了させる場合があります。保護を維持するには最適化を無効にしてください。';

  @override
  String get statusRestricted => '制限あり';

  @override
  String get fixPermissionsButton => '権限を修正する';

  @override
  String get continueWithLimitedProtectionButton => '制限付きの保護で続行';

  @override
  String itemsProtectedCount(int count) {
    return '$count/100 件のアイテムを保護中';
  }

  @override
  String get encryptedOnThisDevice => 'このデバイス上で暗号化済み';

  @override
  String get quickActionsSmallTitle => 'クイックアクション';

  @override
  String get addPhotosAction => '写真を\n追加';

  @override
  String get importVideosAction => '動画を\nインポート';

  @override
  String get albumsHeader => 'アルバム';

  @override
  String get vaultEmptyTitle => '金庫は空です';

  @override
  String get vaultEmptySubtitle => '写真や動画をインポートして\nこの端末内で暗号化して保管しましょう。';

  @override
  String get albumVideos => '動画';

  @override
  String get albumPhotos => '写真';

  @override
  String vaultAlbumItemsCount(int count) {
    return '$count 件';
  }

  @override
  String vaultItemsProtectedSubtitle(int count) {
    return '$count 件 • 保護済み';
  }

  @override
  String get encryptingItemsTitle => '選択したアイテムを暗号化しています...';

  @override
  String filesProcessedProgress(int processed, int total) {
    return '$total 件中 $processed 件を処理済み';
  }

  @override
  String get keepAppOpenWarning => 'インポートが完了するまでアプリを閉じないでください。';

  @override
  String get importCompleteTitle => 'インポート完了';

  @override
  String get importCompleteSubtitle => 'データは安全に暗号化されました。';

  @override
  String itemsEncryptedTitle(int count) {
    return '$count 件のアイテムを暗号化';
  }

  @override
  String get aes256Subtitle => 'AES-256 軍事グレード';

  @override
  String get originalsCouldNotBeDeletedTitle => '元のファイルを自動的に削除\nできませんでした';

  @override
  String get nextStepRequiredTitle => '次のステップが必要です';

  @override
  String get deleteOriginalsManuallyDesc =>
      '写真またはギャラリーを開いて\n元のファイルを手動で削除してください。';

  @override
  String get viewVaultButton => '金庫を表示';

  @override
  String get backToVaultHomeLink => '金庫のホームに戻る';

  @override
  String get fileInfoTitle => 'ファイル情報';

  @override
  String get protectedBadge => '保護済み';

  @override
  String get propertiesHeader => 'プロパティ';

  @override
  String get propertyName => '名前';

  @override
  String get propertyType => '種類';

  @override
  String get propertySize => 'サイズ';

  @override
  String get propertyImportedDate => 'インポート日';

  @override
  String get propertyEncryptionStatus => '暗号化ステータス';

  @override
  String get intruderSelfieOffTitle => '侵入者セルフィーはオフです';

  @override
  String get intruderSelfieOffSubtitle => '有効にすると、ロック解除に3回失敗した際に\n写真を撮影します。';

  @override
  String get secureLogsTitle => 'セキュアログ';

  @override
  String get secureLogsSubtitle => '不正なアクセス試行の日時と写真を\n確認できます。';

  @override
  String get stealthCaptureTitle => 'ステルス撮影';

  @override
  String get stealthCaptureSubtitle => 'フロントカメラで音を立てずに\n撮影します。';

  @override
  String get enableIntruderSelfieButton => '侵入者セルフィーを有効化';

  @override
  String get cameraPermissionDeniedTitle => 'カメラの権限が拒否されました';

  @override
  String get cameraPermissionDeniedSubtitle => '写真なしでも侵入イベントの記録は\n引き続き行われます。';

  @override
  String get intruderLoggingTitle => '侵入ログ記録';

  @override
  String get intruderLoggingSubtitle => '日時や試行されたPINは引き続き\nセキュリティ金庫に保存されます。';

  @override
  String get privacyFirstTitle => 'プライバシー第一';

  @override
  String get privacyFirstSubtitle => '明示的なカメラの許可なしに写真が撮影・保存\nされることはありません。';

  @override
  String get openSettingsButton => '設定を開く';

  @override
  String get statusSummaryTitle => 'ステータス概要';

  @override
  String failedMethodLabel(String method) {
    return '失敗した方法: $method';
  }

  @override
  String get viewDetailsAction => '詳細を見る';

  @override
  String get keepFullAlertHistoryTitle => 'すべてのアラート履歴を保持';

  @override
  String get keepFullAlertHistoryDesc =>
      '無料プランでは最新10件のみ表示されます。\n無期限に保存するにはアップグレードしてください。';

  @override
  String get alertDetailTitle => 'アラートの詳細';

  @override
  String get noPhotoCapturedTitle => '写真は撮影されませんでした';

  @override
  String get noPhotoCapturedDesc => 'このイベント中にセキュリティシステムが\nカメラを初期化できませんでした。';

  @override
  String get eventSummaryHeader => 'イベント概要';

  @override
  String get highAlertBadge => '高警戒';

  @override
  String get captureAnalysisTitle => 'キャプチャ分析';

  @override
  String get attemptedContextLabel => '試行された対象';

  @override
  String get failedMethodRowLabel => '失敗した認証方法';

  @override
  String get failedCountLabel => '失敗回数';

  @override
  String get dateTimeLabel => '日時';

  @override
  String get saveEvidenceButton => '証拠を保存';

  @override
  String get enableCameraPermissionButton => 'カメラ権限を有効にする';

  @override
  String get deleteAlertButton => 'アラートを削除';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsSubtitle => 'アプリの設定を管理します。';

  @override
  String get freePlanTitle => '無料プラン';

  @override
  String get freeBadge => '無料';

  @override
  String get freePlanDesc => '高度なセキュリティ機能を利用するには\nプレミアムにアップグレードしてください。';

  @override
  String get securitySectionHeader => 'セキュリティ';

  @override
  String get biometricUnlockTitle => '生体認証ロック解除';

  @override
  String get biometricUnlockSubtitle => 'Face ID / Touch ID を使用';

  @override
  String get autoLockDelayTitle => '自動ロックの遅延';

  @override
  String get helpAndSupportHeader => 'ヘルプ＆サポート';

  @override
  String get languagesTitle => '言語';

  @override
  String get contactUsTitle => 'お問い合わせ';

  @override
  String get termsOfServiceTitle => '利用規約';

  @override
  String get requireAuthenticationTitle => '認証を要求';

  @override
  String get requireAuthenticationSubtitle =>
      'アプリを離れた後にロックされるまでの時間を選択します。\n短いほどプライバシー保護が強化されます。';

  @override
  String get delayImmediately => '即時';

  @override
  String get delay15Seconds => '15秒後';

  @override
  String get delay30Seconds => '30秒後';

  @override
  String get delay1Minute => '1分後';

  @override
  String get delayScreenOff => '画面オフ時';

  @override
  String get settingLanguagesTitle => '言語設定';

  @override
  String get settingLanguagesSubtitle =>
      'インターフェースとドキュメント認識に使用する\n優先言語を選択してください。';

  @override
  String get langEnglish => '英語 (English)';

  @override
  String get langVietnamese => 'ベトナム語 (Vietnamese)';

  @override
  String get langSpanish => 'スペイン語 (Spanish)';

  @override
  String get langFrench => 'フランス語 (French)';

  @override
  String get langGerman => 'ドイツ語 (German)';

  @override
  String get langJapanese => '日本語';

  @override
  String get langChinese => '中国語 (Chinese)';

  @override
  String get contactUsIntro =>
      'サポートいたします。以下のフォームにご記入いただければ、\nサポートチームより折り返しご連絡\nいたします。';

  @override
  String get emailAddressLabel => 'メールアドレス';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get subjectLabel => '件名';

  @override
  String get subjectHint => '問題の概要を簡潔に入力';

  @override
  String get messageLabel => 'メッセージ';

  @override
  String get messageHint => '問題の詳細をご記入ください...';

  @override
  String get contactPrivacyDisclaimer =>
      'このフォームを送信することで、プライバシーポリシーに同意したものとみなされます。\nメールアドレスはこのお問い合わせへの返信にのみ使用されます。';

  @override
  String get sendMessageButton => 'メッセージを送信';

  @override
  String get biometricNotSupportedError => 'この端末は生体認証に対応していないか、未設定です';

  @override
  String get deleteFromVaultDialogTitle => '金庫から削除しますか？';

  @override
  String get deleteFromVaultDialogDesc => '暗号化された金庫のコピーをこの端末から削除します。';

  @override
  String get deletePermanentlyButton => '完全に削除';

  @override
  String get deleteAlertDialogTitle => 'アラートを削除しますか？';

  @override
  String get deleteAlertDialogDesc => '撮影された侵入者の写真とイベントログをこの端末から削除します。';

  @override
  String get purchaseFallbackMonthlyPrice => '\$2.99';

  @override
  String get purchaseFallbackYearlyPrice => '\$25.99';

  @override
  String get purchaseFallbackYearlyOriginalPrice => '\$35.99';

  @override
  String purchaseSaveBadge(int percent) {
    return '$percent%お得';
  }

  @override
  String get purchaseBillingUnavailable =>
      'この端末では Google Play 課金を利用できません。Play ストアのアカウントを確認して、もう一度お試しください。';

  @override
  String get purchaseProductsNotFound =>
      '現在プレミアムプランをご利用いただけません。しばらくしてから再度お試しください。';

  @override
  String get purchaseProductsLoading => 'プランを読み込み中です。少し待ってから再度お試しください。';

  @override
  String get purchaseFailed => '購入に失敗しました。もう一度お試しください。';

  @override
  String get purchasePending => '購入は保留中です。支払いが完了するとプレミアムが有効になります。';

  @override
  String get purchaseRestoreSuccess => '購入を復元しました。プレミアムが有効です。';

  @override
  String get purchaseRestoreNothing => '以前の購入が見つかりませんでした。';

  @override
  String get purchaseRestoreFailed => '購入を復元できませんでした。もう一度お試しください。';

  @override
  String get purchaseAlreadyPremium => 'すでにプレミアム会員です';

  @override
  String get purchaseOpenLinkFailed => 'リンクを開けませんでした。';

  @override
  String intruderFailedAttemptsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '今日のロック解除失敗: $count回',
      zero: '今日のロック解除失敗はありません',
    );
    return '$_temp0';
  }

  @override
  String intruderAlertsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件のアラートを保存済み',
      zero: '保存されたアラートはありません',
    );
    return '$_temp0';
  }

  @override
  String intruderAlertsShownOfTotal(int shown, int total) {
    return '保存済みアラート$total件中$shown件を表示';
  }

  @override
  String get intruderMethodPin => 'PIN';

  @override
  String get intruderMethodPattern => 'パターン';

  @override
  String get intruderMethodBiometric => '生体認証';

  @override
  String get intruderMainUnlock => 'メインのロック解除';

  @override
  String get intruderYesterday => '昨日';

  @override
  String intruderEvidenceSavedTo(String path) {
    return '証拠を$pathに保存しました';
  }

  @override
  String get intruderEvidenceSaveFailed => '証拠を保存できませんでした';

  @override
  String get intruderAlertDeleted => 'アラートを削除しました';

  @override
  String get intruderDeleteFailed => 'アラートを削除できませんでした';

  @override
  String get intruderNoAlertsTitle => '侵入者アラートはまだありません';

  @override
  String get intruderNoAlertsSubtitle =>
      'ロック解除に3回失敗すると、App Lockが侵入者の写真をこっそり撮影してここに保存します。';

  @override
  String get lockBiometricReason => 'ロックを解除するには本人確認してください';

  @override
  String get lockEnableBiometricReason => '生体認証ロック解除を有効にするには認証してください';

  @override
  String get lockDeviceAuthReason => '端末の画面ロックで本人確認してください';

  @override
  String get lockDeviceNotSecureError => 'アクセスを回復するには端末に画面ロックを設定してください。';

  @override
  String get lockAuthFailedError => '認証に失敗しました。もう一度お試しください。';

  @override
  String get lockUsageAccessNeeded => '保護を開始するには使用状況へのアクセスを許可してください。';

  @override
  String get lockPasscodeUpdated => 'パスコードを更新しました';

  @override
  String get lockPatternUpdated => 'パターンを更新しました';

  @override
  String get lockSaveFailed => '保存できませんでした。もう一度お試しください。';

  @override
  String get lockPremiumPlanTitle => 'プレミアムプラン';

  @override
  String get lockPremiumPlanDesc => 'すべてのプレミアム機能が利用可能です。';

  @override
  String get lockContactFormIncomplete => 'メールアドレスとメッセージを入力してください。';

  @override
  String get lockContactInvalidEmail => '有効なメールアドレスを入力してください。';

  @override
  String lockContactNoEmailApp(String email) {
    return 'メールアプリが見つかりません。$email までご連絡ください';
  }

  @override
  String get lockOpenLinkFailed => 'リンクを開けませんでした。';

  @override
  String get lockBatteryOptimizationTitle => 'バッテリーの最適化';

  @override
  String get lockBatteryOptimizationDesc =>
      '保護を継続するため App Lock を「最適化しない」に設定してください。';

  @override
  String vaultItemsProtectedUnlimited(int count) {
    return '$count 件のアイテムを保護中';
  }

  @override
  String get vaultLimitReachedTitle => '金庫の上限に達しました';

  @override
  String vaultLimitReachedDesc(int limit) {
    return '無料プランでは最大 $limit 件まで保護できます。プレミアムにアップグレードすると無制限に保存できます。';
  }

  @override
  String get vaultUpgradeButton => 'アップグレード';

  @override
  String get vaultOperationFailed => '問題が発生しました。もう一度お試しください。';

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
  String get vaultTypePhoto => '写真';

  @override
  String get vaultTypeVideo => '動画';

  @override
  String get vaultPhotosEmptyTitle => '写真はまだありません';

  @override
  String get vaultVideosEmptyTitle => '動画はまだありません';

  @override
  String get vaultDetailEmptySubtitle =>
      '+ をタップして、システムの写真選択ツールから選んでください。この端末上で暗号化されます。';

  @override
  String get vaultPreviewUnavailable => 'プレビューを表示できません';

  @override
  String get appsCategoryOther => 'その他';

  @override
  String get dialogAdvertisementDownload => '今すぐダウンロード';
}
