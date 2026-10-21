import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/screen/permission_guide/permission_guide_navigator.dart';
import 'package:applock/presentation/screen/permission_guide/view_model/permission_guide_state.dart';
import 'package:applock/presentation/screen/permission_guide/view_model/permission_guide_view_model.dart';
import 'package:applock/presentation/screen/permission_guide/widget/permission_setup_item_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class PermissionGuideViewContent extends StatefulWidget {
  const PermissionGuideViewContent({super.key});

  @override
  State<PermissionGuideViewContent> createState() =>
      _PermissionGuideViewContentState();
}

class _PermissionGuideViewContentState extends State<PermissionGuideViewContent>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PermissionGuideViewModel>().checkPermissions();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<PermissionGuideViewModel>().checkPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PermissionGuideViewModel, PermissionGuideState>(
      listenWhen: (previous, current) =>
          !previous.isCompleted && current.isCompleted,
      listener: (context, state) {
        context.read<PermissionGuideNavigator>().goToHome();
      },
      child: Scaffold(
        backgroundColor: AppColorsPalette.white,
        body: SafeArea(
          child: Column(
            children: [
              // Top Bar
              CommonAppBar.titledBack(
                title: 'Set up permissions',
                leadingIconSize: 24,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                onBack: () =>
                    context.read<PermissionGuideNavigator>().goBack(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      // Top Shield Icon
                      const Center(
                        child: Icon(
                          Icons.shield_rounded,
                          size: 44,
                          color: AppColorsPalette.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Subtitle
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Enable the permissions needed for App Lock, Vault, and security alerts. You can skip optional features and turn them on later.',
                          textAlign: TextAlign.center,
                          style: AppTypography.regular.copyWith(
                            fontSize: 14,
                            color: AppColorsPalette.gray600,
                            height: 1.35,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Permission Cards
                      BlocBuilder<PermissionGuideViewModel,
                          PermissionGuideState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              PermissionSetupItemCard(
                                icon: Icons.sync_rounded,
                                title: 'Usage Access',
                                badgeText: 'REQUIRED',
                                badgeType: PermissionBadgeType.required,
                                description:
                                    'Detect when selected apps are opened so App Lock can show the unlock screen.',
                                isGranted: state.isUsageAccessGranted,
                                onTap: () => context
                                    .read<PermissionGuideViewModel>()
                                    .requestUsageAccess(),
                              ),
                              const SizedBox(height: 12),
                              PermissionSetupItemCard(
                                icon: Icons.layers_outlined,
                                title: 'Display over other apps',
                                badgeText: 'RECOMMENDED',
                                badgeType: PermissionBadgeType.recommended,
                                description:
                                    'Show the unlock screen over protected apps for better reliability.',
                                isGranted: state.isOverlayGranted,
                                onTap: () => context
                                    .read<PermissionGuideViewModel>()
                                    .requestOverlay(),
                              ),
                              const SizedBox(height: 12),
                              PermissionSetupItemCard(
                                icon: Icons.notifications_none_rounded,
                                title: 'Notifications',
                                badgeText: 'RECOMMENDED',
                                badgeType: PermissionBadgeType.recommended,
                                description:
                                    'Show protection status, security alerts, and permission warnings.',
                                isGranted: state.isNotificationGranted,
                                onTap: () => context
                                    .read<PermissionGuideViewModel>()
                                    .requestNotification(),
                              ),
                              const SizedBox(height: 12),
                              PermissionSetupItemCard(
                                icon: Icons.photo_library_outlined,
                                title: 'Photos and videos',
                                badgeText: 'VAULT',
                                badgeType: PermissionBadgeType.vault,
                                description:
                                    'Select media to import into your encrypted vault.',
                                isGranted: state.isPhotosGranted,
                                onTap: () => context
                                    .read<PermissionGuideViewModel>()
                                    .requestPhotos(),
                              ),
                              const SizedBox(height: 12),
                              PermissionSetupItemCard(
                                icon: Icons.camera_alt_outlined,
                                title: 'Camera',
                                badgeText: 'INTRUDER',
                                badgeType: PermissionBadgeType.intruder,
                                description:
                                    'Capture a front-camera photo after 3 failed unlock attempts.',
                                isGranted: state.isCameraGranted,
                                onTap: () => context
                                    .read<PermissionGuideViewModel>()
                                    .requestCamera(),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // Bottom Continue Button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: CommonButton.filled(
                  text: 'Continue',
                  cornerRadius: 14,
                  height: 52,
                  backgroundColor: AppColorsPalette.black,
                  textColor: AppColorsPalette.white,
                  onPressed: () {
                    context.read<PermissionGuideViewModel>().continueFlow();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
