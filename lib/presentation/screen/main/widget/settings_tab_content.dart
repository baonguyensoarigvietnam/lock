import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/screen/home/view_model/home_state.dart';
import 'package:applock/presentation/screen/home/view_model/home_view_model.dart';
import 'package:applock/presentation/screen/main/widget/settings_change_pattern_view.dart';
import 'package:applock/presentation/screen/main/widget/settings_change_pin_view.dart';
import 'package:applock/presentation/screen/main/widget/settings_contact_us_view.dart';
import 'package:applock/presentation/screen/main/widget/settings_languages_view.dart';
import 'package:applock/presentation/screen/main/widget/settings_require_auth_view.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/enumeration/settings_tab_step.dart';

class SettingsTabContent extends StatefulWidget {
  final VoidCallback onGoToSetPasscode;
  final VoidCallback onGoToSetPattern;
  final VoidCallback onGoToLockScreen;
  final VoidCallback onGoToPermissionGuide;
  final VoidCallback onGoToPaywall;

  const SettingsTabContent({
    required this.onGoToSetPasscode,
    required this.onGoToSetPattern,
    required this.onGoToLockScreen,
    required this.onGoToPermissionGuide,
    required this.onGoToPaywall,
    super.key,
  });

  @override
  State<SettingsTabContent> createState() => _SettingsTabContentState();
}

class _SettingsTabContentState extends State<SettingsTabContent> {
  SettingsTabStep _currentStep = SettingsTabStep.overview;
  String _firstPin = '';
  List<int> _firstPattern = const [];
  String _autoLockDelay = 'Immediately';
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      body: SafeArea(
        child: _buildStepContent(),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case SettingsTabStep.overview:
        return _buildSettingsOverview();
      case SettingsTabStep.changePin:
        return SettingsChangePinView(
          isConfirmStep: false,
          firstPin: _firstPin,
          onBack: () => setState(() => _currentStep = SettingsTabStep.overview),
          onFirstPinEntered: (pin) {
            setState(() {
              _firstPin = pin;
              _currentStep = SettingsTabStep.confirmPin;
            });
          },
          onPinConfirmed: () {
            setState(() => _currentStep = SettingsTabStep.overview);
          },
          onUsePatternInstead: () {
            setState(() => _currentStep = SettingsTabStep.changePattern);
          },
        );
      case SettingsTabStep.confirmPin:
        return SettingsChangePinView(
          isConfirmStep: true,
          firstPin: _firstPin,
          onBack: () =>
              setState(() => _currentStep = SettingsTabStep.changePin),
          onFirstPinEntered: (_) {},
          onPinConfirmed: () {
            setState(() => _currentStep = SettingsTabStep.overview);
          },
          onUsePatternInstead: () {
            setState(() => _currentStep = SettingsTabStep.changePattern);
          },
        );
      case SettingsTabStep.changePattern:
        return SettingsChangePatternView(
          isConfirmStep: false,
          firstPattern: _firstPattern,
          onBack: () => setState(() => _currentStep = SettingsTabStep.overview),
          onFirstPatternEntered: (pattern) {
            setState(() {
              _firstPattern = pattern;
              _currentStep = SettingsTabStep.confirmPattern;
            });
          },
          onPatternConfirmed: () {
            setState(() => _currentStep = SettingsTabStep.overview);
          },
          onUsePinInstead: () {
            setState(() => _currentStep = SettingsTabStep.changePin);
          },
        );
      case SettingsTabStep.confirmPattern:
        return SettingsChangePatternView(
          isConfirmStep: true,
          firstPattern: _firstPattern,
          onBack: () =>
              setState(() => _currentStep = SettingsTabStep.changePattern),
          onFirstPatternEntered: (_) {},
          onPatternConfirmed: () {
            setState(() => _currentStep = SettingsTabStep.overview);
          },
          onUsePinInstead: () {
            setState(() => _currentStep = SettingsTabStep.changePin);
          },
        );
      case SettingsTabStep.requireAuthentication:
        return SettingsRequireAuthView(
          currentDelay: _autoLockDelay,
          onBack: () => setState(() => _currentStep = SettingsTabStep.overview),
          onSave: (delay) {
            setState(() {
              _autoLockDelay = delay;
              _currentStep = SettingsTabStep.overview;
            });
          },
        );
      case SettingsTabStep.languages:
        return SettingsLanguagesView(
          currentLanguage: _selectedLanguage,
          onBack: () => setState(() => _currentStep = SettingsTabStep.overview),
          onSave: (language) {
            setState(() {
              _selectedLanguage = language;
              _currentStep = SettingsTabStep.overview;
            });
          },
        );
      case SettingsTabStep.contactUs:
        return SettingsContactUsView(
          onBack: () => setState(() => _currentStep = SettingsTabStep.overview),
          onSubmitted: () =>
              setState(() => _currentStep = SettingsTabStep.overview),
        );
    }
  }

  Widget _buildSettingsOverview() {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Top Title: App Lock
              Center(
                child: Text(
                  'App Lock',
                  style: AppTypography.bold.copyWith(
                    fontSize: 20,
                    color: AppColorsPalette.black,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Page Heading: Settings
              Text(
                'Settings',
                style: AppTypography.bold.copyWith(
                  fontSize: 24,
                  color: AppColorsPalette.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Manage your app preferences.',
                style: AppTypography.regular.copyWith(
                  fontSize: 13.5,
                  color: AppColorsPalette.gray500,
                ),
              ),
              const SizedBox(height: 20),

              // Free Plan Banner Card
              _buildFreePlanCard(),
              const SizedBox(height: 24),

              // Security Section Header
              _buildSectionHeader('Security'),
              const SizedBox(height: 12),

              // Security Group Container
              Container(
                decoration: BoxDecoration(
                  color: AppColorsPalette.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColorsPalette.gray200,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildGroupTile(
                      icon: Icons.password_rounded,
                      title: 'Change Passcode',
                      onTap: () {
                        setState(() {
                          _firstPin = '';
                          _currentStep = SettingsTabStep.changePin;
                        });
                      },
                    ),
                    _buildGroupDivider(),
                    _buildBiometricTile(
                      isEnabled: state.isBiometricEnabled,
                      onToggle: (val) {
                        context.read<HomeViewModel>().toggleBiometric(val);
                      },
                    ),
                    _buildGroupDivider(),
                    _buildGroupTile(
                      icon: Icons.timer_outlined,
                      title: 'Auto-lock delay',
                      subtitle: _autoLockDelay,
                      onTap: () {
                        setState(() {
                          _currentStep = SettingsTabStep.requireAuthentication;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Help & Support Section Header
              _buildSectionHeader('Help & Support'),
              const SizedBox(height: 12),

              // Help & Support Group Container
              Container(
                decoration: BoxDecoration(
                  color: AppColorsPalette.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColorsPalette.gray200,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildGroupTile(
                      icon: Icons.language_rounded,
                      title: 'Languages',
                      onTap: () {
                        setState(() {
                          _currentStep = SettingsTabStep.languages;
                        });
                      },
                    ),
                    _buildGroupDivider(),
                    _buildGroupTile(
                      icon: Icons.mail_outline_rounded,
                      title: 'Contact Us',
                      onTap: () {
                        setState(() {
                          _currentStep = SettingsTabStep.contactUs;
                        });
                      },
                    ),
                    _buildGroupDivider(),
                    _buildGroupTile(
                      icon: Icons.description_outlined,
                      title: 'Terms of Service',
                      onTap: () {},
                    ),
                    _buildGroupDivider(),
                    _buildGroupTile(
                      icon: Icons.policy_outlined,
                      title: 'Privacy Policy',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFreePlanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorsPalette.gray100,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColorsPalette.gray200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Free Plan',
                style: AppTypography.bold.copyWith(
                  fontSize: 15.5,
                  color: AppColorsPalette.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AppColorsPalette.gray100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColorsPalette.gray300,
                    width: 1,
                  ),
                ),
                child: Text(
                  'FREE',
                  style: AppTypography.medium.copyWith(
                    fontSize: 10.5,
                    letterSpacing: 0.4,
                    color: AppColorsPalette.gray500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Upgrade to Premium for advanced security\nfeatures.',
            style: AppTypography.regular.copyWith(
              fontSize: 12.5,
              color: AppColorsPalette.gray500,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          CommonButton.filled(
            text: 'Upgrade to Premium',
            height: 44,
            cornerRadius: 8,
            backgroundColor: AppColorsPalette.black,
            textColor: AppColorsPalette.white,
            textStyle: AppTypography.semiBold.copyWith(
              fontSize: 13.5,
              color: AppColorsPalette.white,
            ),
            leadingIcon: const Icon(
              Icons.workspace_premium_outlined,
              size: 18,
              color: AppColorsPalette.white,
            ),
            iconSpacingFromText: 8,
            onPressed: widget.onGoToPaywall,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 2.5,
          height: 18,
          decoration: BoxDecoration(
            color: AppColorsPalette.black,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTypography.bold.copyWith(
            fontSize: 16,
            color: AppColorsPalette.black,
          ),
        ),
      ],
    );
  }

  Widget _buildGroupTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _buildIconBox(icon),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.medium.copyWith(
                      fontSize: 15,
                      color: AppColorsPalette.black,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTypography.regular.copyWith(
                        fontSize: 12.5,
                        color: AppColorsPalette.gray500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColorsPalette.gray500,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBiometricTile({
    required bool isEnabled,
    required ValueChanged<bool> onToggle,
  }) {
    return GestureDetector(
      onTap: () => onToggle(!isEnabled),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _buildIconBox(Icons.fingerprint_rounded),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Biometric Unlock',
                    style: AppTypography.medium.copyWith(
                      fontSize: 15,
                      color: AppColorsPalette.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Use Face ID / Touch ID',
                    style: AppTypography.regular.copyWith(
                      fontSize: 12.5,
                      color: AppColorsPalette.gray500,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 44,
              height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: isEnabled
                    ? AppColorsPalette.black
                    : AppColorsPalette.gray50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isEnabled
                      ? AppColorsPalette.black
                      : AppColorsPalette.gray200,
                  width: 1,
                ),
              ),
              alignment:
                  isEnabled ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: isEnabled
                      ? AppColorsPalette.white
                      : const Color(0xFF5A5A5A),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBox(IconData icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: AppColorsPalette.gray50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColorsPalette.gray200,
          width: 1,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 19,
          color: AppColorsPalette.gray600,
        ),
      ),
    );
  }

  Widget _buildGroupDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColorsPalette.gray100,
    );
  }
}
