import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/domain/model/lock_screen_args.dart';
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
  final LockScreenArgs args;

  const LockScreenViewContent({super.key, required this.args});

  @override
  State<LockScreenViewContent> createState() => _LockScreenViewContentState();
}

class _LockScreenViewContentState extends State<LockScreenViewContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final vm = context.read<LockScreenViewModel>();
      final reason = context.l10n.lockBiometricReason;
      await vm.init(widget.args);
      // Offer biometrics right away when the user enabled it.
      if (mounted && vm.state.isBiometricAvailable && !vm.state.isSecurityReset) {
        vm.showBiometricStep(reason);
      }
    });
  }

  String _resolveSubtitle(BuildContext context, LockScreenState state) {
    final l10n = context.l10n;
    switch (state.error) {
      case LockScreenError.incorrectPin:
        return l10n.incorrectPinTryAgain;
      case LockScreenError.incorrectPattern:
        return l10n.incorrectPatternTryAgain;
      case LockScreenError.patternTooShort:
        return l10n.connectAtLeast4Dots;
      case LockScreenError.biometricFailed:
        return l10n.lockAuthFailedError;
      case LockScreenError.deviceNotSecure:
        return l10n.lockDeviceNotSecureError;
      case null:
        return state.step == LockScreenStep.pattern
            ? l10n.drawUnlockPatternTitle
            : l10n.enterPinToContinue;
    }
  }

  void _onUnlocked(BuildContext context, LockScreenState state) {
    final navigator = context.read<LockScreenNavigator>();
    switch (state.mode) {
      case LockScreenMode.external:
        context.read<LockScreenViewModel>().returnToProtectedApp();
        navigator.closeExternal();
      case LockScreenMode.selfUnlock:
        navigator.enterApp();
      case LockScreenMode.preview:
        navigator.unlockSuccess();
    }
  }

  void _onLeave(BuildContext context) {
    final vm = context.read<LockScreenViewModel>();
    if (vm.handleBack()) return;
    final navigator = context.read<LockScreenNavigator>();
    switch (vm.state.mode) {
      case LockScreenMode.external:
        vm.leaveProtectedApp();
        navigator.closeExternal();
      case LockScreenMode.selfUnlock:
        vm.returnToProtectedApp();
      case LockScreenMode.preview:
        navigator.goBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LockScreenViewModel, LockScreenState>(
          listenWhen: (prev, curr) => !prev.isUnlocked && curr.isUnlocked,
          listener: _onUnlocked,
        ),
        BlocListener<LockScreenViewModel, LockScreenState>(
          listenWhen: (prev, curr) =>
              !prev.isSecurityReset && curr.isSecurityReset,
          listener: (context, state) {
            context.read<LockScreenNavigator>().goToUnlockMethod();
          },
        ),
      ],
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) _onLeave(context);
        },
        child: Scaffold(
          backgroundColor: AppColorsPalette.white,
          body: SafeArea(
            child: BlocBuilder<LockScreenViewModel, LockScreenState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        padding: const EdgeInsets.only(left: 16, top: 8),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: AppColorsPalette.black,
                          size: 24,
                        ),
                        onPressed: () => _onLeave(context),
                      ),
                    ),
                    Expanded(child: _buildStepBody(context, state)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepBody(BuildContext context, LockScreenState state) {
    final l10n = context.l10n;
    final vm = context.read<LockScreenViewModel>();
    switch (state.step) {
      case LockScreenStep.pin:
        return _buildPinUnlockBody(context, state);
      case LockScreenStep.pattern:
        return _buildPatternUnlockBody(context, state);
      case LockScreenStep.biometric:
        return LockScreenBiometricView(
          statusText: state.error != null ? l10n.biometricNotRecognized : null,
          onRetryBiometric: () =>
              vm.authenticateWithBiometric(l10n.lockBiometricReason),
          onUsePinInstead: vm.usePinInstead,
        );
      case LockScreenStep.recoverAccess:
        return Column(
          children: [
            if (state.error != null) _buildInlineError(context, state),
            Expanded(
              child: LockScreenRecoverAccessView(
                onAuthenticate: () =>
                    vm.authenticateFromRecovery(l10n.lockDeviceAuthReason),
                onResetAppSecurity: vm.showResetSecurityStep,
                onBackToUnlock: vm.backToUnlock,
              ),
            ),
          ],
        );
      case LockScreenStep.resetSecurity:
        return Column(
          children: [
            if (state.error != null) _buildInlineError(context, state),
            Expanded(
              child: LockScreenResetSecurityView(
                isConfirmed: state.isResetConfirmed,
                onToggleConfirmed: vm.toggleResetConfirmed,
                onReset: () =>
                    vm.confirmResetSecurity(l10n.lockDeviceAuthReason),
                onCancel: vm.handleBack,
              ),
            ),
          ],
        );
    }
  }

  Widget _buildInlineError(BuildContext context, LockScreenState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        _resolveSubtitle(context, state),
        textAlign: TextAlign.center,
        style: AppTypography.medium.copyWith(
          fontSize: 13.5,
          color: AppColorsPalette.red500,
        ),
      ),
    );
  }

  Widget _buildAppIcon(LockScreenState state) {
    final icon = state.appIcon;
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: AppColorsPalette.gray50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColorsPalette.gray200, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: icon != null
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: Image.memory(icon, fit: BoxFit.contain),
            )
          : const Center(
              child: Icon(
                Icons.lock_outline_rounded,
                size: 30,
                color: AppColorsPalette.black,
              ),
            ),
    );
  }

  Widget _buildAppUnlockHeader(BuildContext context, LockScreenState state) {
    final l10n = context.l10n;
    final appName = state.targetAppName ?? l10n.appTitle;

    return Column(
      children: [
        const SizedBox(height: 16),
        _buildAppIcon(state),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            l10n.unlockAppTitle(appName),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bold.copyWith(
              fontSize: 24,
              color: AppColorsPalette.black,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _resolveSubtitle(context, state),
          textAlign: TextAlign.center,
          style: AppTypography.regular.copyWith(
            fontSize: 14,
            color: state.error != null
                ? AppColorsPalette.red500
                : AppColorsPalette.gray500,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchMethodLink(BuildContext context, LockScreenState state) {
    if (!state.canSwitchMethod) return const SizedBox.shrink();
    final l10n = context.l10n;
    return TextButton(
      onPressed: () => context.read<LockScreenViewModel>().togglePinAndPattern(),
      child: Text(
        state.step == LockScreenStep.pin
            ? l10n.usePatternInstead
            : l10n.usePinInstead,
        style: AppTypography.semiBold.copyWith(
          fontSize: 14,
          color: AppColorsPalette.black,
        ),
      ),
    );
  }

  Widget _buildForgotLink(BuildContext context, String text) {
    return GestureDetector(
      onTap: () => context.read<LockScreenViewModel>().showRecoverAccessStep(),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          text,
          style: AppTypography.medium.copyWith(
            fontSize: 14,
            color: AppColorsPalette.gray600,
          ),
        ),
      ),
    );
  }

  Widget _buildPinUnlockBody(BuildContext context, LockScreenState state) {
    final l10n = context.l10n;
    final vm = context.read<LockScreenViewModel>();
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
          onDigitTap: vm.appendDigit,
          onBackspaceTap: vm.deleteDigit,
          onBiometricTap: state.isBiometricAvailable
              ? () => vm.showBiometricStep(l10n.lockBiometricReason)
              : null,
        ),
        const Spacer(),
        _buildSwitchMethodLink(context, state),
        _buildForgotLink(context, l10n.forgotPinLink),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPatternUnlockBody(BuildContext context, LockScreenState state) {
    final l10n = context.l10n;
    final vm = context.read<LockScreenViewModel>();
    return Column(
      children: [
        _buildAppUnlockHeader(context, state),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 52),
          child: PatternLockGrid(
            selectedDots: state.currentPattern,
            isError: state.hasErrorShake,
            onPatternStart: vm.onPatternStart,
            onPatternComplete: vm.onPatternComplete,
          ),
        ),
        const SizedBox(height: 16),
        if (state.isBiometricAvailable)
          InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () => vm.showBiometricStep(l10n.lockBiometricReason),
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: AppColorsPalette.gray50,
                shape: BoxShape.circle,
                border: Border.all(color: AppColorsPalette.gray200, width: 1),
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
        _buildSwitchMethodLink(context, state),
        _buildForgotLink(context, l10n.forgotPatternLink),
        const SizedBox(height: 16),
      ],
    );
  }
}
