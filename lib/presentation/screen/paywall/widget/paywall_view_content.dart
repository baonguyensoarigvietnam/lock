import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:applock/application/view_model/global_view_model.dart';
import 'package:applock/l10n/app_localizations.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/screen/paywall/paywall_navigator.dart';
import 'package:applock/presentation/screen/paywall/view_model/paywall_state.dart';
import 'package:applock/presentation/screen/paywall/view_model/paywall_view_model.dart';
import 'package:applock/presentation/screen/paywall/widget/paywall_feature_tile.dart';
import 'package:applock/presentation/screen/paywall/widget/paywall_plan_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/constant/link_constant.dart';
import 'package:applock/utility/extension/build_context.dart';
import 'package:applock/utility/snack_bar_utility.dart';

class PaywallViewContent extends StatelessWidget {
  const PaywallViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isPremium = context.select<GlobalViewModel?, bool>(
      (vm) => vm?.state.isPremium ?? false,
    );
    return MultiBlocListener(
      listeners: [
        BlocListener<PaywallViewModel, PaywallState>(
          listenWhen: (prev, curr) => !prev.isPurchased && curr.isPurchased,
          listener: (context, state) {
            context.read<PaywallNavigator>().close();
          },
        ),
        BlocListener<PaywallViewModel, PaywallState>(
          listenWhen: (prev, curr) =>
              prev.message != curr.message && curr.message != null,
          listener: (context, state) {
            final message = state.message;
            if (message == null) return;
            SnackBarUtility.show(
              context,
              _messageText(l10n, message),
              duration: const Duration(seconds: 3),
            );
            context.read<PaywallViewModel>().clearMessage();
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColorsPalette.white,
        body: SafeArea(
          child: Column(
            children: [
              // Top Bar with Close button
              CommonAppBar.close(
                onClose: () {
                  final navigator = context.read<PaywallNavigator>();
                  final globalVm = context.read<GlobalViewModel?>();
                  if (globalVm != null) {
                    globalVm.showInterstitialAd(
                      onDismiss: () => navigator.close(),
                    );
                  } else {
                    navigator.close();
                  }
                },
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
                        l10n.upgradeToPremium,
                        style: AppTypography.bold.copyWith(
                          fontSize: 24,
                          color: AppColorsPalette.black,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.paywallSubtitle,
                        style: AppTypography.regular.copyWith(
                          fontSize: 15,
                          color: AppColorsPalette.gray600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // 2x2 Feature Cards Grid
                      Row(
                        children: [
                          Expanded(
                            child: PaywallFeatureTile(
                              icon: Icons.brush_outlined,
                              title: l10n.paywallFeatureThemes,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: PaywallFeatureTile(
                              icon: Icons.folder_outlined,
                              title: l10n.paywallFeatureVault,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: PaywallFeatureTile(
                              icon: Icons.history_rounded,
                              title: l10n.paywallFeatureAlerts,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: PaywallFeatureTile(
                              icon: Icons.block_flipped,
                              title: l10n.paywallFeatureNoAds,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Plan Options
                      BlocBuilder<PaywallViewModel, PaywallState>(
                        builder: (context, state) {
                          final monthly =
                              state.productFor(SubscriptionPlanType.monthly);
                          final yearly =
                              state.productFor(SubscriptionPlanType.yearly);
                          final savingPercent = state.yearlySavingPercent;
                          return Column(
                            children: [
                              if (!state.isStoreAvailable) ...[
                                Text(
                                  l10n.purchaseBillingUnavailable,
                                  textAlign: TextAlign.center,
                                  style: AppTypography.regular.copyWith(
                                    fontSize: 13,
                                    color: AppColorsPalette.red500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                              PaywallPlanCard(
                                title: l10n.monthlyPlanTitle,
                                subtitle: l10n.monthlyPlanSubtitle,
                                price: monthly?.price ??
                                    l10n.purchaseFallbackMonthlyPrice,
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
                                title: l10n.yearlyPlanTitle,
                                subtitle: l10n.yearlyPlanSubtitle,
                                price: yearly?.price ??
                                    l10n.purchaseFallbackYearlyPrice,
                                originalPrice: yearly == null
                                    ? l10n.purchaseFallbackYearlyOriginalPrice
                                    : _formatFullYearlyPrice(state, yearly),
                                badgeText: yearly == null
                                    ? l10n.save40Badge
                                    : (savingPercent != null
                                        ? l10n.purchaseSaveBadge(savingPercent)
                                        : null),
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
                            text: isPremium
                                ? l10n.purchaseAlreadyPremium
                                : l10n.startPremiumButton,
                            isLoading: state.isPurchasing || state.isRestoring,
                            onPressed: isPremium
                                ? null
                                : () {
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
                            text: l10n.restorePurchases,
                            onTap: () {
                              context
                                  .read<PaywallViewModel>()
                                  .restorePurchases();
                            },
                          ),
                          _buildFooterDivider(),
                          _buildFooterLink(
                            text: l10n.termsLink,
                            onTap: () =>
                                _openLink(context, LinkConstants.termOfUse),
                          ),
                          _buildFooterDivider(),
                          _buildFooterLink(
                            text: l10n.privacyPolicyLink,
                            onTap: () =>
                                _openLink(context, LinkConstants.privacyPolicy),
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

  String _messageText(AppLocalizations l10n, PaywallMessage message) {
    return switch (message) {
      PaywallMessage.billingUnavailable => l10n.purchaseBillingUnavailable,
      PaywallMessage.productsNotFound => l10n.purchaseProductsNotFound,
      PaywallMessage.productsLoading => l10n.purchaseProductsLoading,
      PaywallMessage.purchaseFailed => l10n.purchaseFailed,
      PaywallMessage.purchasePending => l10n.purchasePending,
      PaywallMessage.restoreSuccess => l10n.purchaseRestoreSuccess,
      PaywallMessage.restoreNothing => l10n.purchaseRestoreNothing,
      PaywallMessage.restoreFailed => l10n.purchaseRestoreFailed,
    };
  }

  /// "12 x monthly" price in the yearly product's currency, or null when it
  /// can't be computed or isn't higher than the yearly price.
  String? _formatFullYearlyPrice(PaywallState state, ProductDetails yearly) {
    final full = state.yearlyFullRawPrice;
    if (full == null || full <= yearly.rawPrice) return null;
    return NumberFormat.currency(
      name: yearly.currencyCode,
      symbol: yearly.currencySymbol,
    ).format(full);
  }

  Future<void> _openLink(BuildContext context, String url) async {
    final failedText = context.l10n.purchaseOpenLinkFailed;
    final opened = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    ).catchError((_) => false);
    if (!opened && context.mounted) {
      SnackBarUtility.show(context, failedText);
    }
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
