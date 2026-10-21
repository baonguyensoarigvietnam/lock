enum RouterEndpoint {
  splash(name: 'splash', path: '/splash'),
  onboarding(name: 'onboarding', path: '/onboarding'),
  unlockMethod(name: 'unlockMethod', path: '/unlock-method'),
  setPasscode(name: 'setPasscode', path: '/set-passcode'),
  setPattern(name: 'setPattern', path: '/set-pattern'),
  enableBiometric(name: 'enableBiometric', path: '/enable-biometric'),
  paywall(name: 'paywall', path: '/paywall'),
  home(name: 'home', path: '/'),
  main(name: 'main', path: '/main'),
  lockScreen(name: 'lockScreen', path: '/lock-screen'),
  permissionGuide(name: 'permissionGuide', path: '/permission-guide'),
  settings(name: 'settings', path: '/settings');

  const RouterEndpoint({required this.name, required this.path});

  final String name;
  final String path;
}
