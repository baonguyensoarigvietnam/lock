import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:applock/application/view_model/global_view_model.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/common/widget/native_ad_widget.dart';
import 'package:applock/presentation/screen/settings/settings_navigator.dart';
import 'package:applock/presentation/screen/settings/view_model/settings_state.dart';
import 'package:applock/presentation/screen/settings/view_model/settings_view_model.dart';
import 'package:applock/presentation/screen/settings/widget/settings_change_pattern_view.dart';
import 'package:applock/presentation/screen/settings/widget/settings_change_pin_view.dart';
import 'package:applock/presentation/screen/settings/widget/settings_contact_us_view.dart';
import 'package:applock/presentation/screen/settings/widget/settings_languages_view.dart';
import 'package:applock/presentation/screen/settings/widget/settings_require_auth_view.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/constant/link_constant.dart';
import 'package:applock/utility/enumeration/biometric_toggle_result.dart';
import 'package:applock/utility/enumeration/settings_tab_step.dart';
import 'package:applock/utility/extension/build_context.dart';
import 'package:applock/utility/snack_bar_utility.dart';
import 'package:applock/utility/url_launcher_utility.dart';

class SettingsViewContent extends StatefulWidget {
  const SettingsViewContent({super.key});

  @override
  State<SettingsViewContent> createState() => _SettingsViewContentState();
}

class _SettingsViewContentState extends State<SettingsViewContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsViewModel>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      body: SafeArea(
        child: BlocBuilder<SettingsViewModel, SettingsState>(
          builder: (context, state) {
            return _buildStepContent(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildStepContent(BuildContext context, SettingsState state) {
    final vm = context.read<SettingsViewModel>();

    switch (state.currentStep) {
      case SettingsTabStep.overview:
        return _buildSettingsOverview(context, state);
      case SettingsTabStep.changePin:
        return SettingsChangePinView(
          isConfirmStep: false,
          firstPin: state.firstPin,
          onBack: () => vm.setStep(SettingsTabStep.overview),
          onFirstPinEntered: (pin) => vm.submitFirstPin(pin),
          onPinConfirmed: _onPinConfirmed,
          onUsePatternInstead: vm.startChangePattern,
        );
      case SettingsTabStep.confirmPin:
        return SettingsChangePinView(
          isConfirmStep: true,
          firstPin: state.firstPin,
          onBack: vm.startChangePin,
          onFirstPinEntered: (_) {},
          onPinConfirmed: _onPinConfirmed,
          onUsePatternInstead: vm.startChangePattern,
        );
      case SettingsTabStep.changePattern:
        return SettingsChangePatternView(
          isConfirmStep: false,
          firstPattern: state.firstPattern,
          onBack: () => vm.setStep(SettingsTabStep.overview),
          onFirstPatternEntered: (pattern) => vm.submitFirstPattern(pattern),
          onPatternConfirmed: _onPatternConfirmed,
          onUsePinInstead: vm.startChangePin,
        );
      case SettingsTabStep.confirmPattern:
        return SettingsChangePatternView(
          isConfirmStep: true,
          firstPattern: state.firstPattern,
          onBack: vm.startChangePattern,
          onFirstPatternEntered: (_) {},
          onPatternConfirmed: _onPatternConfirmed,
          onUsePinInstead: vm.startChangePin,
        );
      case SettingsTabStep.requireAuthentication:
        return SettingsRequireAuthView(
          currentDelay: state.autoLockDelay,
          onBack: () => vm.setStep(SettingsTabStep.overview),
          onSave: (delay) => vm.saveAutoLockDelay(delay),
        );
      case SettingsTabStep.languages:
        return SettingsLanguagesView(
          currentLanguage: state.selectedLanguage,
          onBack: () => vm.setStep(SettingsTabStep.overview),
          onSave: (language) {
            final globalVm = context.read<GlobalViewModel>();
            globalVm.setLanguage(language);
            globalVm.showInterstitialAd(
              onDismiss: () => vm.saveLanguage(language),
            );
          },
        );
      case SettingsTabStep.contactUs:
        return SettingsContactUsView(
          onBack: () => vm.setStep(SettingsTabStep.overview),
          onSubmitted: () => vm.setStep(SettingsTabStep.overview),
        );
    }
  }

  Future<void> _onPinConfirmed() async {
    final l10n = context.l10n;
    final saved = await context.read<SettingsViewModel>().confirmPin();
    if (!mounted) return;
    SnackBarUtility.show(
      context,
      saved ? l10n.lockPasscodeUpdated : l10n.lockSaveFailed,
    );
  }

  Future<void> _onPatternConfirmed() async {
    final l10n = context.l10n;
    final saved = await context.read<SettingsViewModel>().confirmPattern();
    if (!mounted) return;
    SnackBarUtility.show(
      context,
      saved ? l10n.lockPatternUpdated : l10n.lockSaveFailed,
    );
  }

  Future<void> _onToggleBiometric(bool enabled) async {
    final l10n = context.l10n;
    final result = await context.read<SettingsViewModel>().toggleBiometric(
      enabled,
      localizedReason: l10n.lockEnableBiometricReason,
    );
    if (!mounted) return;
    if (result == BiometricToggleResult.notSupported) {
      SnackBarUtility.show(context, l10n.biometricNotSupportedError);
    }
  }

  Future<void> _openLink(String url) async {
    final opened = await UrlLauncherUtility.openUrl(url);
    if (!opened && mounted) {
      SnackBarUtility.show(context, context.l10n.lockOpenLinkFailed);
    }
  }

  Widget _buildSettingsOverview(BuildContext context, SettingsState state) {
    final vm = context.read<SettingsViewModel>();
    final navigator = context.read<SettingsNavigator>();
    final l10n = context.l10n;
    final isPremium = context.select<GlobalViewModel, bool>(
      (vm) => vm.state.isPremium,
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const CommonAppBar.brand(),
          const SizedBox(height: 18),

          // Page Heading: Settings
          Text(
            l10n.settingsTitle,
            style: AppTypography.bold.copyWith(
              fontSize: 24,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.settingsSubtitle,
            style: AppTypography.regular.copyWith(
              fontSize: 13.5,
              color: AppColorsPalette.gray500,
            ),
          ),
          const SizedBox(height: 20),

          // Free Plan Banner Card
          if (isPremium)
            _buildPremiumPlanCard(context)
          else
            _buildFreePlanCard(context, navigator),
          const SizedBox(height: 24),

          // Security Section Header
          _buildSectionHeader(l10n.securitySectionHeader),
          const SizedBox(height: 12),

          // Security Group Container
          Container(
            decoration: BoxDecoration(
              color: AppColorsPalette.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColorsPalette.gray200, width: 1),
            ),
            child: Column(
              children: [
                _buildGroupTile(
                  icon: Icons.password_rounded,
                  title: l10n.changePasscodeTitle,
                  onTap: () => vm.startChangePin(),
                ),
                _buildGroupDivider(),
                _buildBiometricTile(
                  context: context,
                  isEnabled: state.isBiometricEnabled,
                  onToggle: _onToggleBiometric,
                ),
                _buildGroupDivider(),
                _buildGroupTile(
                  icon: Icons.timer_outlined,
                  title: l10n.autoLockDelayTitle,
                  subtitle: state.autoLockDelay.label(l10n),
                  onTap: () =>
                      vm.setStep(SettingsTabStep.requireAuthentication),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const NativeAdWidget(
            templateType: TemplateType.medium,
            padding: EdgeInsets.only(top: 20),
          ),
          const SizedBox(height: 24),
          // Help & Support Section Header
          _buildSectionHeader(l10n.helpAndSupportHeader),
          const SizedBox(height: 12),
          // Help & Support Group Container
          Container(
            decoration: BoxDecoration(
              color: AppColorsPalette.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColorsPalette.gray200, width: 1),
            ),
            child: Column(
              children: [
                _buildGroupTile(
                  icon: Icons.language_rounded,
                  title: l10n.languagesTitle,
                  subtitle: state.selectedLanguage.localizedName(l10n),
                  onTap: () => vm.setStep(SettingsTabStep.languages),
                ),
                _buildGroupDivider(),
                _buildGroupTile(
                  icon: Icons.mail_outline_rounded,
                  title: l10n.contactUsTitle,
                  onTap: () => vm.setStep(SettingsTabStep.contactUs),
                ),
                _buildGroupDivider(),
                _buildGroupTile(
                  icon: Icons.description_outlined,
                  title: l10n.termsOfServiceTitle,
                  onTap: () => _openLink(LinkConstants.termOfUse),
                ),
                _buildGroupDivider(),
                _buildGroupTile(
                  icon: Icons.policy_outlined,
                  title: l10n.privacyPolicyLink,
                  onTap: () => _openLink(LinkConstants.privacyPolicy),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumPlanCard(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorsPalette.black,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  l10n.lockPremiumPlanTitle,
                  style: AppTypography.bold.copyWith(
                    fontSize: 15.5,
                    color: AppColorsPalette.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AppColorsPalette.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  l10n.premiumBadge,
                  style: AppTypography.medium.copyWith(
                    fontSize: 10.5,
                    letterSpacing: 0.4,
                    color: AppColorsPalette.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            l10n.lockPremiumPlanDesc,
            style: AppTypography.regular.copyWith(
              fontSize: 12.5,
              color: AppColorsPalette.gray300,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFreePlanCard(BuildContext context, SettingsNavigator navigator) {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorsPalette.gray100,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColorsPalette.gray200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.freePlanTitle,
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
                  border: Border.all(color: AppColorsPalette.gray300, width: 1),
                ),
                child: Text(
                  l10n.freeBadge,
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
            l10n.freePlanDesc,
            style: AppTypography.regular.copyWith(
              fontSize: 12.5,
              color: AppColorsPalette.gray500,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          CommonButton.filled(
            text: l10n.upgradeToPremium,
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
            onPressed: navigator.goToPaywall,
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
    required BuildContext context,
    required bool isEnabled,
    required ValueChanged<bool> onToggle,
  }) {
    final l10n = context.l10n;
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
                    l10n.biometricUnlockTitle,
                    style: AppTypography.medium.copyWith(
                      fontSize: 15,
                      color: AppColorsPalette.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.biometricUnlockSubtitle,
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
              alignment: isEnabled
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: isEnabled
                      ? AppColorsPalette.white
                      : AppColorsPalette.gray550,
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
        border: Border.all(color: AppColorsPalette.gray200, width: 1),
      ),
      child: Center(
        child: Icon(icon, size: 19, color: AppColorsPalette.gray600),
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
