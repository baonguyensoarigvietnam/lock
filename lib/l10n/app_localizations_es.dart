// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'AppLock';

  @override
  String get appLockTitle => 'Bloqueo de Apps';

  @override
  String get continueButton => 'Continuar';

  @override
  String get getStartedButton => 'Comenzar';

  @override
  String get skipButton => 'Omitir';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get saveButton => 'Guardar';

  @override
  String get doneButton => 'Listo';

  @override
  String get resetButton => 'Restablecer';

  @override
  String get deleteAction => 'Eliminar';

  @override
  String get infoAction => 'Info';

  @override
  String get seeAllAction => 'Ver todo';

  @override
  String get navHome => 'Inicio';

  @override
  String get navApps => 'Apps';

  @override
  String get navVault => 'Bóveda';

  @override
  String get navAlerts => 'Alertas';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get splashSubtitle => 'Protege tu contenido privado';

  @override
  String get onboardingStep1Title => 'Protege tu privacidad';

  @override
  String get onboardingStep1Desc =>
      'Mantén fotos, videos privados y accesos sensibles protegidos en este dispositivo.';

  @override
  String get onboardingStep2Title => 'Protección solo local';

  @override
  String get onboardingStep2Subtitle =>
      'Tus datos nunca salen de tu dispositivo.';

  @override
  String get onboardingNoAccountTitle => 'Sin cuenta';

  @override
  String get onboardingNoAccountDesc =>
      'No pedimos tu correo ni número de teléfono para usar la aplicación.';

  @override
  String get onboardingNoCloudTitle => 'Sin sincronización en la nube';

  @override
  String get onboardingNoCloudDesc =>
      'Tus datos nunca se suben a servidores externos ni a la nube.';

  @override
  String get onboardingNoRecoveryTitle => 'Sin recuperación por servidor';

  @override
  String get onboardingNoRecoveryDesc =>
      'Si pierdes tu PIN, no podremos recuperar tus datos.';

  @override
  String get onboardingVaultStaysTitle => 'Los archivos se quedan aquí';

  @override
  String get onboardingVaultStaysDesc =>
      'Todo lo asegurado en la bóveda permanece estrictamente en este dispositivo.';

  @override
  String get unlockMethodTitle => 'Configura tu método de desbloqueo';

  @override
  String get unlockMethodSubtitle =>
      'Elige cómo desbloquearás tu contenido privado.';

  @override
  String get createPinTitle => 'Crear PIN';

  @override
  String get createPinSubtitle => 'Código numérico de 4 a 8 dígitos';

  @override
  String get drawPatternTitle => 'Dibujar patrón';

  @override
  String get drawPatternSubtitle => 'Conecta al menos 4 puntos';

  @override
  String get unlockMethodWarning =>
      'Guárdalo en un lugar seguro. Los datos de la bóveda no se pueden recuperar si lo olvidas y la biometría no está disponible.';

  @override
  String get createYourPinTitle => 'Crea tu PIN';

  @override
  String get confirmYourPinTitle => 'Confirma tu PIN';

  @override
  String get changePasscodeTitle => 'Cambiar código';

  @override
  String get confirmYourPasscodeTitle => 'Confirma tu código';

  @override
  String get usePinToAccessSubtitle =>
      'Usa este PIN para acceder a tu contenido protegido.';

  @override
  String get reEnterPinSubtitle => 'Vuelve a ingresar tu PIN para confirmar.';

  @override
  String get reEnterPinShort => 'Vuelve a ingresar tu PIN.';

  @override
  String get pinDoesNotMatchError => 'El PIN no coincide.';

  @override
  String get usePatternInstead => 'Usar patrón en su lugar';

  @override
  String get usePinInstead => 'Usar PIN en su lugar';

  @override
  String get drawUnlockPatternTitle => 'Dibuja un patrón de desbloqueo';

  @override
  String get confirmYourPatternTitle => 'Confirma tu patrón';

  @override
  String get connectAtLeast4Dots => 'Conecta al menos 4 puntos.';

  @override
  String get drawPatternAgainConfirm =>
      'Dibuja tu patrón de nuevo para confirmar.';

  @override
  String get patternDoesNotMatchError => 'El patrón no coincide';

  @override
  String get enableBiometricTitle => 'Activar respaldo biométrico';

  @override
  String get enableBiometricSubtitle =>
      'Usa la huella digital o el reconocimiento facial de tu dispositivo para recuperar el acceso si es necesario.';

  @override
  String get fasterUnlockTitle => 'Desbloqueo más rápido';

  @override
  String get fasterUnlockSubtitle =>
      'Accede rápidamente a tu bóveda sin escribir.';

  @override
  String get usesDeviceSecurityTitle => 'Usa la seguridad del dispositivo';

  @override
  String get usesDeviceSecuritySubtitle =>
      'Aprovecha el hardware biométrico integrado.';

  @override
  String get helpsForgetPinTitle => 'Ayuda si olvidas tu PIN';

  @override
  String get helpsForgetPinSubtitle =>
      'Una alternativa segura para volver a entrar.';

  @override
  String get biometricInfoNote =>
      'El respaldo biométrico solo funciona si se activa antes de olvidar tu PIN.';

  @override
  String get enableBiometricButton => 'Activar biometría';

  @override
  String get setUpPermissionsTitle => 'Configurar permisos';

  @override
  String get permissionGuideSubtitle =>
      'Activa los permisos necesarios para Bloqueo de Apps, Bóveda y alertas. Puedes omitir funciones opcionales y activarlas después.';

  @override
  String get usageAccessTitle => 'Acceso de uso';

  @override
  String get usageAccessDesc =>
      'Detecta cuándo se abren las apps seleccionadas para mostrar la pantalla de desbloqueo.';

  @override
  String get displayOverOtherAppsTitle => 'Mostrar sobre otras apps';

  @override
  String get displayOverOtherAppsDesc =>
      'Muestra la pantalla de desbloqueo sobre las apps protegidas para mayor fiabilidad.';

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get notificationsDesc =>
      'Muestra el estado de protección, alertas de seguridad y avisos de permisos.';

  @override
  String get cameraTitle => 'Cámara';

  @override
  String get cameraDesc =>
      'Toma una foto con la cámara frontal tras 3 intentos fallidos de desbloqueo.';

  @override
  String get badgeRequired => 'REQUERIDO';

  @override
  String get badgeRecommended => 'RECOMENDADO';

  @override
  String get badgeIntruder => 'INTRUSO';

  @override
  String get upgradeToPremium => 'Actualizar a Premium';

  @override
  String get paywallSubtitle => 'Desbloquea más temas y elimina los anuncios.';

  @override
  String get paywallFeatureThemes => 'Temas premium futuros';

  @override
  String get paywallFeatureVault => 'Bóveda ilimitada';

  @override
  String get paywallFeatureAlerts => 'Historial completo de alertas';

  @override
  String get paywallFeatureNoAds => 'Sin anuncios';

  @override
  String get monthlyPlanTitle => 'Mensual';

  @override
  String get monthlyPlanSubtitle => 'Facturado cada mes';

  @override
  String get yearlyPlanTitle => 'Anual';

  @override
  String get yearlyPlanSubtitle => 'Facturado anualmente';

  @override
  String get save40Badge => 'AHORRA 40%';

  @override
  String wasPrice(String price) {
    return 'antes $price';
  }

  @override
  String get startPremiumButton => 'Iniciar Premium';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get termsLink => 'Términos';

  @override
  String get privacyPolicyLink => 'Política de privacidad';

  @override
  String unlockAppTitle(String appName) {
    return 'Desbloquear $appName';
  }

  @override
  String get enterPinToContinue => 'Ingresa tu PIN para continuar.';

  @override
  String get incorrectPinTryAgain => 'PIN incorrecto. Inténtalo de nuevo.';

  @override
  String get incorrectPatternTryAgain =>
      'Patrón incorrecto. Inténtalo de nuevo.';

  @override
  String get forgotPinLink => '¿Olvidaste tu PIN?';

  @override
  String get forgotPatternLink => '¿Olvidaste el patrón?';

  @override
  String get useBiometricUnlockTitle => 'Usar desbloqueo biométrico';

  @override
  String get unlockWithDeviceAuthSubtitle =>
      'Desbloquea con la autenticación del dispositivo.';

  @override
  String get biometricNotRecognized => 'BIOMETRÍA NO RECONOCIDA';

  @override
  String get recoverAccessTitle => 'Recuperar acceso';

  @override
  String get useBiometricFallbackCardTitle => 'Usar respaldo biométrico';

  @override
  String get useBiometricFallbackCardDesc =>
      'Autentícate con la biometría del dispositivo y luego crea un nuevo PIN o patrón.';

  @override
  String get authenticateButton => 'Autenticar';

  @override
  String get vaultCannotBeRecoveredTitle => 'La bóveda no se puede recuperar';

  @override
  String get vaultCannotBeRecoveredDesc =>
      'Sin PIN, patrón o respaldo biométrico, los datos cifrados de la bóveda no se pueden recuperar.';

  @override
  String get resetAppSecurityButton => 'Restablecer seguridad de la app';

  @override
  String get backToUnlockLink => 'Volver al desbloqueo';

  @override
  String get resetSecurityQuestionTitle => '¿Restablecer seguridad?';

  @override
  String get resetSecurityWarningDesc =>
      'Esto eliminará el sobre de claves.\nLos datos cifrados de la bóveda ya no serán\naccesibles.';

  @override
  String get resetSecurityConfirmCheckbox =>
      'Entiendo que esto no se puede\ndeshacer';

  @override
  String get statusActive => 'ACTIVO';

  @override
  String get statusIdle => 'INACTIVO';

  @override
  String get appsProtectedLabel => 'Apps protegidas';

  @override
  String get vaultItemsLabel => 'Elementos en bóveda';

  @override
  String get intruderAlertsLabel => 'Alertas de intrusos';

  @override
  String get biometricFallbackLabel => 'Respaldo biométrico';

  @override
  String get quickActionsTitle => 'Acciones rápidas';

  @override
  String get lockAppsAction => 'Bloquear apps';

  @override
  String get themesAction => 'Temas';

  @override
  String get promoBannerTitle => 'DESBLOQUEA TODAS LAS FUNCIONES';

  @override
  String get promoBannerSubtitle =>
      'Temas ilimitados, sin anuncios y mucho más.';

  @override
  String get themeMinimal => 'Minimalista';

  @override
  String get themeClassicPin => 'PIN clásico';

  @override
  String get themePattern => 'Patrón';

  @override
  String get themeVault => 'Bóveda';

  @override
  String get themeFocus => 'Enfoque';

  @override
  String get themePremiumColors => 'Colores Premium';

  @override
  String get premiumBadge => 'PREMIUM';

  @override
  String get applyThemeButton => 'Aplicar tema';

  @override
  String get themeAppliedTitle => 'Tema aplicado';

  @override
  String get themeAppliedSubtitle =>
      'Tus pantallas de bloqueo ahora usan el\ntema seleccionado.';

  @override
  String get premiumColorPreviewTitle => 'Vista previa de color Premium';

  @override
  String get premiumThemesSubscriptionNote =>
      'Los temas premium están disponibles con suscripción.';

  @override
  String get backToThemesButton => 'Volver a temas';

  @override
  String get lockedAppsHeader => 'Apps bloqueadas';

  @override
  String protectedAppsCount(int count) {
    return '$count apps protegidas';
  }

  @override
  String get searchAppsHint => 'Buscar aplicaciones...';

  @override
  String get filterAll => 'Todas';

  @override
  String get filterCategories => 'Categorías';

  @override
  String get filterLocked => 'Bloqueadas';

  @override
  String categoryChipLabel(String category) {
    return 'Categoría: $category';
  }

  @override
  String get noLockedAppsFound => 'No se encontraron apps bloqueadas';

  @override
  String get noAppsFound => 'No se encontraron aplicaciones';

  @override
  String get categorySocial => 'Social';

  @override
  String get categoryMessaging => 'Mensajería';

  @override
  String get categoryPhotosVideo => 'Fotos y video';

  @override
  String get categoryFinance => 'Finanzas';

  @override
  String get categoryShopping => 'Compras';

  @override
  String get categorySystem => 'Sistema';

  @override
  String categoryAppsBullet(int count) {
    return '$count Apps • ';
  }

  @override
  String categoryProtectedCount(int count) {
    return '$count protegidas';
  }

  @override
  String get usageAccessRequiredTitle => 'Se requiere acceso de uso';

  @override
  String get usageAccessRequiredDesc =>
      'Activa el acceso de uso para proteger las\naplicaciones seleccionadas.';

  @override
  String get enableUsageAccessButton => 'Activar acceso de uso';

  @override
  String get protectionMayBeLimitedTitle =>
      'La protección puede verse limitada';

  @override
  String get protectionMayBeLimitedDesc =>
      'Para garantizar que Bloqueo de Apps funcione de forma fiable en segundo plano, revisa los siguientes ajustes de Android.';

  @override
  String get displayOverOtherAppsWarningDesc =>
      'Necesario para mostrar la pantalla de bloqueo sobre las apps protegidas. Sin esto, no se bloquearán.';

  @override
  String get statusDisabled => 'Desactivado';

  @override
  String get batteryOptimizationTitle => 'Optimización de batería';

  @override
  String get batteryOptimizationDesc =>
      'Android puede cerrar la app en segundo plano. Desactiva la optimización para mantener la protección activa.';

  @override
  String get statusRestricted => 'Restringido';

  @override
  String get fixPermissionsButton => 'Corregir permisos';

  @override
  String get continueWithLimitedProtectionButton =>
      'Continuar con protección limitada';

  @override
  String itemsProtectedCount(int count) {
    return '$count/100 elementos protegidos';
  }

  @override
  String get encryptedOnThisDevice => 'Cifrado en este dispositivo';

  @override
  String get quickActionsSmallTitle => 'Acciones rápidas';

  @override
  String get addPhotosAction => 'Añadir\nFotos';

  @override
  String get importVideosAction => 'Importar\nVideos';

  @override
  String get albumsHeader => 'Álbumes';

  @override
  String get vaultEmptyTitle => 'Tu bóveda está vacía';

  @override
  String get vaultEmptySubtitle =>
      'Importa fotos y videos para mantenerlos\ncifrados en este dispositivo.';

  @override
  String get albumVideos => 'Videos';

  @override
  String get albumPhotos => 'Fotos';

  @override
  String vaultAlbumItemsCount(int count) {
    return '$count elementos';
  }

  @override
  String vaultItemsProtectedSubtitle(int count) {
    return '$count elementos • Protegidos';
  }

  @override
  String get encryptingItemsTitle => 'Cifrando elementos seleccionados...';

  @override
  String filesProcessedProgress(int processed, int total) {
    return '$processed de $total archivos procesados';
  }

  @override
  String get keepAppOpenWarning =>
      'Mantén la aplicación abierta hasta que termine la importación.';

  @override
  String get importCompleteTitle => 'Importación completada';

  @override
  String get importCompleteSubtitle =>
      'Tus datos ahora están seguros y cifrados.';

  @override
  String itemsEncryptedTitle(int count) {
    return '$count elementos cifrados';
  }

  @override
  String get aes256Subtitle => 'Grado militar AES-256';

  @override
  String get originalsCouldNotBeDeletedTitle =>
      'No se pudieron eliminar los originales\nautomáticamente';

  @override
  String get nextStepRequiredTitle => 'Siguiente paso requerido';

  @override
  String get deleteOriginalsManuallyDesc =>
      'Abre Fotos o Galería para eliminar\nlos originales manualmente.';

  @override
  String get viewVaultButton => 'Ver Bóveda';

  @override
  String get backToVaultHomeLink => 'Volver al inicio de la Bóveda';

  @override
  String get fileInfoTitle => 'Información del archivo';

  @override
  String get protectedBadge => 'Protegido';

  @override
  String get propertiesHeader => 'Propiedades';

  @override
  String get propertyName => 'Nombre';

  @override
  String get propertyType => 'Tipo';

  @override
  String get propertySize => 'Tamaño';

  @override
  String get propertyImportedDate => 'Fecha de importación';

  @override
  String get propertyEncryptionStatus => 'Estado de cifrado';

  @override
  String get intruderSelfieOffTitle => 'Selfie de intruso desactivado';

  @override
  String get intruderSelfieOffSubtitle =>
      'Actívalo para tomar una foto tras 3\nintentos fallidos de desbloqueo.';

  @override
  String get secureLogsTitle => 'Registros seguros';

  @override
  String get secureLogsSubtitle =>
      'Consulta fecha, hora y foto de\nintentos no autorizados.';

  @override
  String get stealthCaptureTitle => 'Captura silenciosa';

  @override
  String get stealthCaptureSubtitle =>
      'La cámara frontal toma la foto\nsilenciosamente.';

  @override
  String get enableIntruderSelfieButton => 'Activar Selfie de intruso';

  @override
  String get cameraPermissionDeniedTitle => 'Permiso de cámara denegado';

  @override
  String get cameraPermissionDeniedSubtitle =>
      'Los eventos de intrusos aún pueden registrarse\nsin una foto.';

  @override
  String get intruderLoggingTitle => 'Registro de intrusos';

  @override
  String get intruderLoggingSubtitle =>
      'La hora, fecha e intentos de PIN seguirán\nguardándose en tu bóveda de seguridad.';

  @override
  String get privacyFirstTitle => 'Privacidad primero';

  @override
  String get privacyFirstSubtitle =>
      'No se toman ni guardan fotos sin tu\npermiso explícito de cámara.';

  @override
  String get openSettingsButton => 'Abrir ajustes';

  @override
  String get statusSummaryTitle => 'Resumen de estado';

  @override
  String failedMethodLabel(String method) {
    return 'Método fallido: $method';
  }

  @override
  String get viewDetailsAction => 'Ver detalles';

  @override
  String get keepFullAlertHistoryTitle =>
      'Conserva todo el historial de alertas';

  @override
  String get keepFullAlertHistoryDesc =>
      'Los usuarios gratuitos solo ven las últimas 10\nalertas. Actualiza para guardar sin límite.';

  @override
  String get alertDetailTitle => 'Detalle de alerta';

  @override
  String get noPhotoCapturedTitle => 'No se capturó foto';

  @override
  String get noPhotoCapturedDesc =>
      'El sistema de seguridad no pudo\ninicializar la cámara durante este\nevento.';

  @override
  String get eventSummaryHeader => 'RESUMEN DEL EVENTO';

  @override
  String get highAlertBadge => 'Alerta alta';

  @override
  String get captureAnalysisTitle => 'Análisis de captura';

  @override
  String get attemptedContextLabel => 'Contexto del intento';

  @override
  String get failedMethodRowLabel => 'Método fallido';

  @override
  String get failedCountLabel => 'Intentos fallidos';

  @override
  String get dateTimeLabel => 'Fecha/hora';

  @override
  String get saveEvidenceButton => 'Guardar evidencia';

  @override
  String get enableCameraPermissionButton => 'Activar permiso de cámara';

  @override
  String get deleteAlertButton => 'Eliminar alerta';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsSubtitle =>
      'Administra las preferencias de la aplicación.';

  @override
  String get freePlanTitle => 'Plan Gratuito';

  @override
  String get freeBadge => 'GRATIS';

  @override
  String get freePlanDesc =>
      'Actualiza a Premium para funciones de seguridad\navanzadas.';

  @override
  String get securitySectionHeader => 'Seguridad';

  @override
  String get biometricUnlockTitle => 'Desbloqueo biométrico';

  @override
  String get biometricUnlockSubtitle => 'Usar Face ID / Touch ID';

  @override
  String get autoLockDelayTitle => 'Retraso de bloqueo automático';

  @override
  String get helpAndSupportHeader => 'Ayuda y soporte';

  @override
  String get languagesTitle => 'Idiomas';

  @override
  String get contactUsTitle => 'Contáctanos';

  @override
  String get termsOfServiceTitle => 'Términos de servicio';

  @override
  String get requireAuthenticationTitle => 'Requerir autenticación';

  @override
  String get requireAuthenticationSubtitle =>
      'Elige qué tan rápido se bloquea la app al salir.\nLos tiempos más cortos brindan mayor protección\nde privacidad.';

  @override
  String get delayImmediately => 'Inmediatamente';

  @override
  String get delay15Seconds => 'Después de 15 segundos';

  @override
  String get delay30Seconds => 'Después de 30 segundos';

  @override
  String get delay1Minute => 'Después de 1 minuto';

  @override
  String get delayScreenOff => 'Cuando se apague la pantalla';

  @override
  String get settingLanguagesTitle => 'Configuración de idioma';

  @override
  String get settingLanguagesSubtitle =>
      'Elige tu idioma preferido para la interfaz\ny el reconocimiento de documentos.';

  @override
  String get langEnglish => 'Inglés (English)';

  @override
  String get langVietnamese => 'Vietnamita (Vietnamese)';

  @override
  String get langSpanish => 'Español';

  @override
  String get langFrench => 'Francés (French)';

  @override
  String get langGerman => 'Alemán (German)';

  @override
  String get langJapanese => 'Japonés (Japanese)';

  @override
  String get langChinese => 'Chino (Chinese)';

  @override
  String get contactUsIntro =>
      'Estamos aquí para ayudar. Completa el formulario y\nnuestro equipo de soporte te responderá lo antes\nposible.';

  @override
  String get emailAddressLabel => 'Correo electrónico';

  @override
  String get emailHint => 'tu@ejemplo.com';

  @override
  String get subjectLabel => 'Asunto';

  @override
  String get subjectHint => 'Resumen breve de tu problema';

  @override
  String get messageLabel => 'Mensaje';

  @override
  String get messageHint => 'Describe tu problema en detalle...';

  @override
  String get contactPrivacyDisclaimer =>
      'Al enviar este formulario, aceptas nuestra Política de privacidad.\nSolo usaremos tu correo para responder a esta solicitud.';

  @override
  String get sendMessageButton => 'Enviar mensaje';

  @override
  String get biometricNotSupportedError =>
      'El dispositivo no admite o no tiene configurada la biometría';

  @override
  String get deleteFromVaultDialogTitle => '¿Eliminar de la Bóveda?';

  @override
  String get deleteFromVaultDialogDesc =>
      'Esto eliminará la copia cifrada de la bóveda de este dispositivo.';

  @override
  String get deletePermanentlyButton => 'Eliminar permanentemente';

  @override
  String get deleteAlertDialogTitle => '¿Eliminar alerta?';

  @override
  String get deleteAlertDialogDesc =>
      'Esto eliminará la foto del intruso y el registro del evento de este dispositivo.';

  @override
  String get purchaseFallbackMonthlyPrice => '\$2.99';

  @override
  String get purchaseFallbackYearlyPrice => '\$25.99';

  @override
  String get purchaseFallbackYearlyOriginalPrice => '\$35.99';

  @override
  String purchaseSaveBadge(int percent) {
    return 'AHORRA $percent%';
  }

  @override
  String get purchaseBillingUnavailable =>
      'Google Play Billing no está disponible en este dispositivo. Revisa tu cuenta de Play Store e inténtalo de nuevo.';

  @override
  String get purchaseProductsNotFound =>
      'Los planes Premium no están disponibles en este momento. Inténtalo más tarde.';

  @override
  String get purchaseProductsLoading =>
      'Cargando planes, inténtalo de nuevo en un momento.';

  @override
  String get purchaseFailed => 'La compra ha fallado. Inténtalo de nuevo.';

  @override
  String get purchasePending =>
      'Tu compra está pendiente. Premium se desbloqueará cuando se complete el pago.';

  @override
  String get purchaseRestoreSuccess =>
      'Compras restauradas. Premium está activo.';

  @override
  String get purchaseRestoreNothing => 'No se encontraron compras anteriores.';

  @override
  String get purchaseRestoreFailed =>
      'No se pudieron restaurar las compras. Inténtalo de nuevo.';

  @override
  String get purchaseAlreadyPremium => 'Ya eres Premium';

  @override
  String get purchaseOpenLinkFailed => 'No se pudo abrir el enlace.';

  @override
  String intruderFailedAttemptsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count intentos de desbloqueo fallidos hoy',
      one: '1 intento de desbloqueo fallido hoy',
      zero: 'Ningún intento de desbloqueo fallido hoy',
    );
    return '$_temp0';
  }

  @override
  String intruderAlertsSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alertas guardadas',
      one: '1 alerta guardada',
      zero: 'Ninguna alerta guardada',
    );
    return '$_temp0';
  }

  @override
  String intruderAlertsShownOfTotal(int shown, int total) {
    return 'Mostrando $shown de $total alertas guardadas';
  }

  @override
  String get intruderMethodPin => 'PIN';

  @override
  String get intruderMethodPattern => 'Patrón';

  @override
  String get intruderMethodBiometric => 'Biometría';

  @override
  String get intruderMainUnlock => 'Desbloqueo principal';

  @override
  String get intruderYesterday => 'Ayer';

  @override
  String intruderEvidenceSavedTo(String path) {
    return 'Evidencia guardada en $path';
  }

  @override
  String get intruderEvidenceSaveFailed => 'No se pudo guardar la evidencia';

  @override
  String get intruderAlertDeleted => 'Alerta eliminada';

  @override
  String get intruderDeleteFailed => 'No se pudo eliminar la alerta';

  @override
  String get intruderNoAlertsTitle => 'Aún no hay alertas de intrusos';

  @override
  String get intruderNoAlertsSubtitle =>
      'Tras 3 intentos de desbloqueo fallidos, App Lock toma en silencio una foto del intruso y la guarda aquí.';

  @override
  String get lockBiometricReason => 'Confirma tu identidad para desbloquear';

  @override
  String get lockEnableBiometricReason =>
      'Autentícate para activar el desbloqueo biométrico';

  @override
  String get lockDeviceAuthReason =>
      'Verifica que eres tú con el bloqueo de pantalla del dispositivo';

  @override
  String get lockDeviceNotSecureError =>
      'Configura un bloqueo de pantalla en tu dispositivo para recuperar el acceso.';

  @override
  String get lockAuthFailedError =>
      'La autenticación falló. Inténtalo de nuevo.';

  @override
  String get lockUsageAccessNeeded =>
      'Concede el acceso de uso para iniciar la protección.';

  @override
  String get lockPasscodeUpdated => 'Código actualizado';

  @override
  String get lockPatternUpdated => 'Patrón actualizado';

  @override
  String get lockSaveFailed => 'No se pudo guardar. Inténtalo de nuevo.';

  @override
  String get lockPremiumPlanTitle => 'Plan Premium';

  @override
  String get lockPremiumPlanDesc =>
      'Todas las funciones Premium están desbloqueadas.';

  @override
  String get lockContactFormIncomplete => 'Introduce tu correo y un mensaje.';

  @override
  String get lockContactInvalidEmail =>
      'Introduce una dirección de correo válida.';

  @override
  String lockContactNoEmailApp(String email) {
    return 'No se encontró una app de correo. Escribe a $email';
  }

  @override
  String get lockOpenLinkFailed => 'No se pudo abrir el enlace.';

  @override
  String get lockBatteryOptimizationTitle => 'Optimización de batería';

  @override
  String get lockBatteryOptimizationDesc =>
      'Configura App Lock como \"No optimizada\" para que la protección siga activa.';

  @override
  String vaultItemsProtectedUnlimited(int count) {
    return '$count elementos protegidos';
  }

  @override
  String get vaultLimitReachedTitle => 'Límite de la bóveda alcanzado';

  @override
  String vaultLimitReachedDesc(int limit) {
    return 'El plan gratuito protege hasta $limit elementos. Mejora a Premium para tener almacenamiento ilimitado.';
  }

  @override
  String get vaultUpgradeButton => 'Mejorar';

  @override
  String get vaultOperationFailed => 'Algo salió mal. Inténtalo de nuevo.';

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
  String get vaultTypeVideo => 'Vídeo';

  @override
  String get vaultPhotosEmptyTitle => 'Aún no hay fotos';

  @override
  String get vaultVideosEmptyTitle => 'Aún no hay vídeos';

  @override
  String get vaultDetailEmptySubtitle =>
      'Toca + para elegir elementos con el selector de fotos del sistema. Se cifran en este dispositivo.';

  @override
  String get vaultPreviewUnavailable => 'Vista previa no disponible';

  @override
  String get appsCategoryOther => 'Otros';
}
