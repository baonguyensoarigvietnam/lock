import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/common/widget/common_app_lock_header.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/common/widget/common_feature_card.dart';
import 'package:applock/presentation/screen/enable_biometric/enable_biometric_navigator.dart';
import 'package:applock/presentation/screen/enable_biometric/view_model/enable_biometric_state.dart';
import 'package:applock/presentation/screen/enable_biometric/view_model/enable_biometric_view_model.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class EnableBiometricViewContent extends StatefulWidget {
  const EnableBiometricViewContent({super.key});

  @override
  State<EnableBiometricViewContent> createState() =>
      _EnableBiometricViewContentState();
}

class _EnableBiometricViewContentState
    extends State<EnableBiometricViewContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EnableBiometricViewModel>().checkBiometricAvailability();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EnableBiometricViewModel, EnableBiometricState>(
      listenWhen: (previous, current) =>
          !previous.isCompleted && current.isCompleted,
      listener: (context, state) {
        context.read<EnableBiometricNavigator>().goToPermissionGuide();
      },
      child: Scaffold(
        backgroundColor: AppColorsPalette.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 12),
                // Top Title
                const CommonAppLockHeader(),
                const SizedBox(height: 24),
                // Biometric Icon Circle
                Center(
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: const BoxDecoration(
                      color: AppColorsPalette.gray100,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.fingerprint_rounded,
                        size: 44,
                        color: AppColorsPalette.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Heading
                Text(
                  'Enable biometric fallback',
                  textAlign: TextAlign.center,
                  style: AppTypography.bold.copyWith(
                    fontSize: 24,
                    color: AppColorsPalette.black,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Use your device\'s fingerprint or face scan to regain access if needed.',
                    textAlign: TextAlign.center,
                    style: AppTypography.regular.copyWith(
                      fontSize: 15,
                      color: AppColorsPalette.gray600,
                      height: 1.35,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Feature Cards
                const CommonFeatureCard(
                  icon: Icons.bolt_rounded,
                  title: 'Faster unlock',
                  subtitle: 'Quickly access your vault without typing.',
                ),
                const SizedBox(height: 12),
                const CommonFeatureCard(
                  icon: Icons.shield_outlined,
                  title: 'Uses device security',
                  subtitle: 'Leverages built-in biometric hardware.',
                ),
                const SizedBox(height: 12),
                const CommonFeatureCard(
                  icon: Icons.lock_outline_rounded,
                  title: 'Helps if you forget your PIN',
                  subtitle: 'A secure alternative way to get back in.',
                ),
                const Spacer(),
                // Information box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColorsPalette.gray150,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.info_outline_rounded,
                          color: AppColorsPalette.black,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Biometric fallback only works if enabled before you forget your PIN.',
                          style: AppTypography.regular.copyWith(
                            fontSize: 13,
                            color: AppColorsPalette.gray700,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Buttons
                CommonButton.filled(
                  text: 'Enable biometric',
                  cornerRadius: 14,
                  height: 52,
                  backgroundColor: AppColorsPalette.black,
                  textColor: AppColorsPalette.white,
                  onPressed: () {
                    context.read<EnableBiometricViewModel>().enableBiometric();
                  },
                ),
                const SizedBox(height: 10),
                CommonButton.outline(
                  text: 'Skip',
                  cornerRadius: 14,
                  height: 52,
                  backgroundColor: AppColorsPalette.white,
                  textColor: AppColorsPalette.black,
                  borderColor: AppColorsPalette.gray800,
                  borderWidth: 1.4,
                  onPressed: () {
                    context.read<EnableBiometricViewModel>().skip();
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
