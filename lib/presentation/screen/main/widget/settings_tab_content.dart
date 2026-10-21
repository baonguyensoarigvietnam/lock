import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/screen/home/view_model/home_state.dart';
import 'package:applock/presentation/screen/home/view_model/home_view_model.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class SettingsTabContent extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      appBar: AppBar(
        backgroundColor: AppColorsPalette.white,
        elevation: 0,
        title: Text(
          'Settings',
          style: AppTypography.bold.copyWith(
            fontSize: 20,
            color: AppColorsPalette.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // Premium banner
            InkWell(
              onTap: onGoToPaywall,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF111827),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.workspace_premium_rounded,
                      color: Color(0xFFFBBF24),
                      size: 28,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AppLock Premium',
                            style: AppTypography.bold.copyWith(
                              fontSize: 16,
                              color: AppColorsPalette.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Unlimited themes, ads free & priority vault',
                            style: AppTypography.regular.copyWith(
                              fontSize: 12,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF9CA3AF),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Security',
              style: AppTypography.bold.copyWith(
                fontSize: 15,
                color: AppColorsPalette.gray600,
              ),
            ),
            const SizedBox(height: 10),
            _buildSettingTile(
              icon: Icons.dialpad_rounded,
              title: 'Change PIN code',
              onTap: onGoToSetPasscode,
            ),
            const SizedBox(height: 10),
            _buildSettingTile(
              icon: Icons.gesture_rounded,
              title: 'Change unlock pattern',
              onTap: onGoToSetPattern,
            ),
            const SizedBox(height: 10),
            _buildSettingTile(
              icon: Icons.visibility_outlined,
              title: 'Preview lock screen',
              onTap: onGoToLockScreen,
            ),
            const SizedBox(height: 24),

            Text(
              'System & Permissions',
              style: AppTypography.bold.copyWith(
                fontSize: 15,
                color: AppColorsPalette.gray600,
              ),
            ),
            const SizedBox(height: 10),
            _buildSettingTile(
              icon: Icons.security_rounded,
              title: 'Set up permissions',
              onTap: onGoToPermissionGuide,
            ),
            const SizedBox(height: 10),
            BlocBuilder<HomeViewModel, HomeState>(
              builder: (context, state) {
                return _buildSettingTile(
                  icon: Icons.power_settings_new_rounded,
                  title: 'Protection service',
                  subtitle: state.isServiceActive ? 'Running' : 'Stopped',
                  onTap: () {
                    context
                        .read<HomeViewModel>()
                        .toggleService(!state.isServiceActive);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColorsPalette.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: AppColorsPalette.black,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.semiBold.copyWith(
                        fontSize: 14.5,
                        color: AppColorsPalette.black,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppTypography.regular.copyWith(
                          fontSize: 12,
                          color: AppColorsPalette.gray500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF9CA3AF),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
