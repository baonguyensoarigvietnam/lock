import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/application/view_model/global_view_model.dart';
import 'package:applock/domain/model/intruder_alert.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_formatting.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_intruder_illustration.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class AlertsListView extends StatelessWidget {
  /// Number of alerts visible to free users.
  static const int freeVisibleAlerts = 2;

  final List<IntruderAlert> alerts;
  final int todayFailedCount;
  final VoidCallback onUpgradeTap;
  final ValueChanged<IntruderAlert> onSelectAlert;
  final Future<void> Function() onRefresh;

  const AlertsListView({
    required this.alerts,
    required this.todayFailedCount,
    required this.onUpgradeTap,
    required this.onSelectAlert,
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isPremium =
        context.select<GlobalViewModel, bool>((vm) => vm.state.isPremium);
    final visibleItems =
        isPremium ? alerts : alerts.take(freeVisibleAlerts).toList();
    final savedSummaryText = isPremium || alerts.length <= freeVisibleAlerts
        ? l10n.intruderAlertsSaved(alerts.length)
        : l10n.intruderAlertsShownOfTotal(visibleItems.length, alerts.length);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            // Top Title: App Lock
            const CommonAppBar.brand(),
            const SizedBox(height: 18),

            // Status Summary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              decoration: BoxDecoration(
                color: AppColorsPalette.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColorsPalette.gray200,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.statusSummaryTitle,
                    style: AppTypography.bold.copyWith(
                      fontSize: 17,
                      color: AppColorsPalette.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSummaryRow(
                    icon: Icons.report_gmailerrorred_rounded,
                    text: l10n.intruderFailedAttemptsToday(todayFailedCount),
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    icon: Icons.dns_outlined,
                    text: savedSummaryText,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            if (alerts.isEmpty) _buildEmptyCard(context),

            // Alert Event Cards
            ...List.generate(visibleItems.length, (index) {
              final item = visibleItems[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _buildAlertCard(context, item),
              );
            }),

            // Free User Promo Card: Keep full alert history
            if (!isPremium) ...[
              const SizedBox(height: 4),
              _buildKeepHistoryCard(context),
            ],

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColorsPalette.gray500,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTypography.regular.copyWith(
              fontSize: 13.5,
              color: AppColorsPalette.gray500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyCard(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
      decoration: BoxDecoration(
        color: AppColorsPalette.gray50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColorsPalette.gray200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.verified_user_outlined,
            size: 36,
            color: AppColorsPalette.gray500,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.intruderNoAlertsTitle,
            textAlign: TextAlign.center,
            style: AppTypography.bold.copyWith(
              fontSize: 16,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.intruderNoAlertsSubtitle,
            textAlign: TextAlign.center,
            style: AppTypography.regular.copyWith(
              fontSize: 13.5,
              color: AppColorsPalette.gray500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard(BuildContext context, IntruderAlert item) {
    final l10n = context.l10n;
    return GestureDetector(
      onTap: () => onSelectAlert(item),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 108,
        decoration: BoxDecoration(
          color: AppColorsPalette.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColorsPalette.gray200,
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Row(
            children: [
              // Left Intruder Photo / Placeholder
              SizedBox(
                width: 112,
                height: double.infinity,
                child: AlertsIntruderIllustration(
                  photoPath: item.hasPhoto ? item.photoPath : null,
                  isLarge: false,
                ),
              ),

              // Right Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  item.displayTitle(context),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.bold.copyWith(
                                    fontSize: 16,
                                    color: AppColorsPalette.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item.shortTimeLabel(context),
                                style: AppTypography.regular.copyWith(
                                  fontSize: 12,
                                  color: AppColorsPalette.gray400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.failedMethodLabel(item.methodLabel(context)),
                            style: AppTypography.regular.copyWith(
                              fontSize: 13.5,
                              color: AppColorsPalette.gray500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            l10n.viewDetailsAction,
                            style: AppTypography.semiBold.copyWith(
                              fontSize: 13.5,
                              color: AppColorsPalette.black,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 15,
                            color: AppColorsPalette.black,
                          ),
                        ],
                      ),
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

  Widget _buildKeepHistoryCard(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColorsPalette.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColorsPalette.gray800,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Icons.history_rounded,
                    size: 20,
                    color: AppColorsPalette.white,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.keepFullAlertHistoryTitle,
                      style: AppTypography.bold.copyWith(
                        fontSize: 15.5,
                        color: AppColorsPalette.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.keepFullAlertHistoryDesc,
                      style: AppTypography.regular.copyWith(
                        fontSize: 13,
                        color: AppColorsPalette.gray400,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          CommonButton.filled(
            text: l10n.upgradeToPremium,
            height: 44,
            cornerRadius: 10,
            backgroundColor: AppColorsPalette.white,
            textColor: AppColorsPalette.black,
            textStyle: AppTypography.semiBold.copyWith(
              fontSize: 14,
              color: AppColorsPalette.black,
            ),
            onPressed: onUpgradeTap,
          ),
        ],
      ),
    );
  }
}
