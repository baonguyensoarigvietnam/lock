import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/common/widget/common_pin_dots.dart';
import 'package:applock/presentation/common/widget/common_pin_keypad.dart';
import 'package:applock/presentation/common/widget/pattern_lock_grid.dart';
import 'package:applock/presentation/screen/lock_screen/lock_screen_navigator.dart';
import 'package:applock/presentation/screen/lock_screen/view_model/lock_screen_state.dart';
import 'package:applock/presentation/screen/lock_screen/view_model/lock_screen_view_model.dart';
import 'package:applock/presentation/screen/lock_screen/widget/lock_screen_biometric_view.dart';
import 'package:applock/presentation/screen/lock_screen/widget/lock_screen_recover_access_view.dart';
import 'package:applock/presentation/screen/lock_screen/widget/lock_screen_reset_security_view.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/enumeration/lock_screen_step.dart';
import 'package:applock/utility/extension/build_context.dart';

class LockScreenViewContent extends StatefulWidget {
  final String? appName;

  const LockScreenViewContent({super.key, this.appName});

  @override
  State<LockScreenViewContent> createState() => _LockScreenViewContentState();
}

class _LockScreenViewContentState extends State<LockScreenViewContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LockScreenViewModel>().init(appName: widget.appName);
    });
  }

  IconData _resolveAppIcon(String appName) {
    final lower = appName.toLowerCase();
    if (lower.contains('gallery')) return Icons.image_outlined;
    if (lower.contains('message')) return Icons.chat_outlined;
    if (lower.contains('photo')) return Icons.photo_library_outlined;
    if (lower.contains('gmail') || lower.contains('email')) {
      return Icons.email_outlined;
    }
    if (lower.contains('instagram')) return Icons.camera_alt_outlined;
    if (lower.contains('bank')) return Icons.account_balance_outlined;
    if (lower.contains('file')) return Icons.folder_outlined;
    if (lower.contains('setting')) return Icons.settings_outlined;
    if (lower.contains('contact')) return Icons.contact_page_outlined;
    return Icons.image_outlined;
  }

  String _resolveErrorMessage(BuildContext context, String? errorMessage) {
    final l10n = context.l10n;
    if (errorMessage == null) return l10n.enterPinToContinue;
    if (errorMessage.contains('4')) return l10n.connectAtLeast4Dots;
    if (errorMessage.toLowerCase().contains('pattern')) {
      return l10n.incorrectPatternTryAgain;
    }
    return l10n.incorrectPinTryAgain;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LockScreenViewModel, LockScreenState>(
          listenWhen: (prev, curr) => !prev.isUnlocked && curr.isUnlocked,
          listener: (context, state) {
            context.read<LockScreenNavigator>().unlockSuccess();
          },
        ),
        BlocListener<LockScreenViewModel, LockScreenState>(
          listenWhen: (prev, curr) =>
              !prev.isSecurityReset && curr.isSecurityReset,
          listener: (context, state) {
            context.read<LockScreenNavigator>().goToUnlockMethod();
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColorsPalette.white,
        body: SafeArea(
          child: BlocBuilder<LockScreenViewModel, LockScreenState>(
            builder: (context, state) {
              return Column(
                children: [
                  // Top Bar with back button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColorsPalette.black,
                        size: 24,
                      ),
                      onPressed: () {
                        final handled =
                            context.read<LockScreenViewModel>().handleBack();
                        if (!handled) {
                          context.read<LockScreenNavigator>().goBack();
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: _buildStepBody(context, state),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStepBody(BuildContext context, LockScreenState state) {
    final l10n = context.l10n;
    switch (state.step) {
      case LockScreenStep.pin:
        return _buildPinUnlockBody(context, state);
      case LockScreenStep.pattern:
        return _buildPatternUnlockBody(context, state);
      case LockScreenStep.biometric:
        return LockScreenBiometricView(
          statusText: state.biometricStatusText != null
              ? l10n.biometricNotRecognized
              : null,
          onRetryBiometric: () =>
              context.read<LockScreenViewModel>().authenticateWithBiometric(),
          onUsePinInstead: () =>
              context.read<LockScreenViewModel>().usePinInstead(),
        );
      case LockScreenStep.recoverAccess:
        return LockScreenRecoverAccessView(
          onAuthenticate: () =>
              context.read<LockScreenViewModel>().authenticateFromRecovery(),
          onResetAppSecurity: () =>
              context.read<LockScreenViewModel>().showResetSecurityStep(),
          onBackToUnlock: () =>
              context.read<LockScreenViewModel>().backToUnlock(),
        );
      case LockScreenStep.resetSecurity:
        return LockScreenResetSecurityView(
          isConfirmed: state.isResetConfirmed,
          onToggleConfirmed: () =>
              context.read<LockScreenViewModel>().toggleResetConfirmed(),
          onReset: () =>
              context.read<LockScreenViewModel>().confirmResetSecurity(),
          onCancel: () => context.read<LockScreenViewModel>().handleBack(),
        );
    }
  }

  Widget _buildAppUnlockHeader(BuildContext context, LockScreenState state) {
    final l10n = context.l10n;
    final subtitleText = _resolveErrorMessage(context, state.errorMessage);

    return Column(
      children: [
        const SizedBox(height: 16),
        // App Icon Box (tapping toggles between PIN and Pattern unlock views)
        GestureDetector(
          onTap: () =>
              context.read<LockScreenViewModel>().togglePinAndPattern(),
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColorsPalette.gray50,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColorsPalette.gray200,
                width: 1,
              ),
            ),
            child: Center(
              child: Icon(
                _resolveAppIcon(state.targetAppName),
                size: 30,
                color: AppColorsPalette.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          l10n.unlockAppTitle(state.targetAppName),
          style: AppTypography.bold.copyWith(
            fontSize: 24,
            color: AppColorsPalette.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitleText,
          textAlign: TextAlign.center,
          style: AppTypography.regular.copyWith(
            fontSize: 14,
            color: state.errorMessage != null
                ? AppColorsPalette.red500
                : AppColorsPalette.gray500,
          ),
        ),
      ],
    );
  }

  Widget _buildPinUnlockBody(BuildContext context, LockScreenState state) {
    final l10n = context.l10n;
    return Column(
      children: [
        _buildAppUnlockHeader(context, state),
        const SizedBox(height: 32),
        CommonPinDots(
          pinLength: LockScreenViewModel.pinLength,
          filledCount: state.currentInput.length,
        ),
        const Spacer(),
        CommonPinKeypad(
          onDigitTap: (digit) =>
              context.read<LockScreenViewModel>().appendDigit(digit),
          onBackspaceTap: () =>
              context.read<LockScreenViewModel>().deleteDigit(),
          onBiometricTap: state.isBiometricAvailable
              ? () => context.read<LockScreenViewModel>().showBiometricStep()
              : null,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () =>
              context.read<LockScreenViewModel>().showRecoverAccessStep(),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              l10n.forgotPinLink,
              style: AppTypography.medium.copyWith(
                fontSize: 14,
                color: AppColorsPalette.gray600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPatternUnlockBody(BuildContext context, LockScreenState state) {
    final l10n = context.l10n;
    return Column(
      children: [
        _buildAppUnlockHeader(context, state),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 52),
          child: PatternLockGrid(
            selectedDots: state.currentPattern,
            isError: state.hasErrorShake,
            onPatternStart: () =>
                context.read<LockScreenViewModel>().onPatternStart(),
            onPatternComplete: (dots) =>
                context.read<LockScreenViewModel>().onPatternComplete(dots),
          ),
        ),
        const SizedBox(height: 16),
        if (state.isBiometricAvailable)
          InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () =>
                context.read<LockScreenViewModel>().showBiometricStep(),
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: AppColorsPalette.gray50,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColorsPalette.gray200,
                  width: 1,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.fingerprint_rounded,
                  color: AppColorsPalette.black,
                  size: 26,
                ),
              ),
            ),
          ),
        const Spacer(),
        GestureDetector(
          onTap: () =>
              context.read<LockScreenViewModel>().showRecoverAccessStep(),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              l10n.forgotPatternLink,
              style: AppTypography.medium.copyWith(
                fontSize: 14,
                color: AppColorsPalette.gray600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
