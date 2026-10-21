import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/screen/paywall/paywall_navigator.dart';
import 'package:applock/presentation/screen/paywall/view_model/paywall_state.dart';
import 'package:applock/presentation/screen/paywall/view_model/paywall_view_model.dart';
import 'package:applock/presentation/screen/paywall/widget/paywall_feature_tile.dart';
import 'package:applock/presentation/screen/paywall/widget/paywall_plan_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class PaywallViewContent extends StatelessWidget {
  const PaywallViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaywallViewModel, PaywallState>(
      listenWhen: (prev, curr) => !prev.isPurchased && curr.isPurchased,
      listener: (context, state) {
        context.read<PaywallNavigator>().close();
      },
      child: Scaffold(
        backgroundColor: AppColorsPalette.white,
        body: SafeArea(
          child: Column(
            children: [
              // Top Bar with Close button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColorsPalette.black,
                    size: 26,
                  ),
                  onPressed: () => context.read<PaywallNavigator>().close(),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 6),
                      // Medal Ribbon Star Icon Badge
                      _buildMedalBadge(),
                      const SizedBox(height: 18),
                      // Title & Subtitle
                      Text(
                        'Upgrade to Premium',
                        style: AppTypography.bold.copyWith(
                          fontSize: 24,
                          color: AppColorsPalette.black,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Unlock more themes and remove ads.',
                        style: AppTypography.regular.copyWith(
                          fontSize: 15,
                          color: AppColorsPalette.gray600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // 2x2 Feature Cards Grid
                      Row(
                        children: const [
                          Expanded(
                            child: PaywallFeatureTile(
                              icon: Icons.brush_outlined,
                              title: 'Premium themes in future',
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: PaywallFeatureTile(
                              icon: Icons.folder_outlined,
                              title: 'Unlimited vault',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: const [
                          Expanded(
                            child: PaywallFeatureTile(
                              icon: Icons.history_rounded,
                              title: 'Full intruder alert history',
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: PaywallFeatureTile(
                              icon: Icons.block_flipped,
                              title: 'No ads',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Plan Options
                      BlocBuilder<PaywallViewModel, PaywallState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              PaywallPlanCard(
                                title: 'Monthly',
                                subtitle: 'Billed every month',
                                price: '\$2.99',
                                isSelected: state.selectedPlan ==
                                    SubscriptionPlanType.monthly,
                                onTap: () {
                                  context
                                      .read<PaywallViewModel>()
                                      .selectPlan(SubscriptionPlanType.monthly);
                                },
                              ),
                              const SizedBox(height: 12),
                              PaywallPlanCard(
                                title: 'Yearly',
                                subtitle: 'Billed annually',
                                price: '\$25.99',
                                originalPrice: '\$35.99',
                                badgeText: 'SAVE 40%',
                                isSelected: state.selectedPlan ==
                                    SubscriptionPlanType.yearly,
                                onTap: () {
                                  context
                                      .read<PaywallViewModel>()
                                      .selectPlan(SubscriptionPlanType.yearly);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      // Bottom Start Premium Button
                      BlocBuilder<PaywallViewModel, PaywallState>(
                        builder: (context, state) {
                          return CommonButton.filled(
                            text: 'Start Premium',
                            isLoading: state.isLoading,
                            onPressed: () {
                              context
                                  .read<PaywallViewModel>()
                                  .startPremium();
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      // Footer links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildFooterLink(
                            text: 'Restore purchases',
                            onTap: () {
                              context
                                  .read<PaywallViewModel>()
                                  .restorePurchases();
                            },
                          ),
                          _buildFooterDivider(),
                          _buildFooterLink(
                            text: 'Terms',
                            onTap: () {},
                          ),
                          _buildFooterDivider(),
                          _buildFooterLink(
                            text: 'Privacy Policy',
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedalBadge() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColorsPalette.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColorsPalette.black,
          width: 1.8,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.star_rounded,
          color: AppColorsPalette.black,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildFooterLink({
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: AppTypography.regular.copyWith(
          fontSize: 12,
          color: AppColorsPalette.gray500,
        ),
      ),
    );
  }

  Widget _buildFooterDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 1,
        height: 12,
        color: AppColorsPalette.gray300,
      ),
    );
  }
}
