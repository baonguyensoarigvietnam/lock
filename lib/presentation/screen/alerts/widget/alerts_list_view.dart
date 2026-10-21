import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_intruder_illustration.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class AlertEventItem {
  final String title;
  final String timeLabel;
  final String failedMethod;
  final String attemptedContext;
  final String detailedMethod;
  final int failedCount;
  final String detailedDateTime;
  final bool hasPhoto;

  const AlertEventItem({
    required this.title,
    required this.timeLabel,
    required this.failedMethod,
    required this.attemptedContext,
    required this.detailedMethod,
    this.failedCount = 3,
    this.detailedDateTime = 'Oct 24, 02:14 AM',
    this.hasPhoto = true,
  });
}

class AlertsListView extends StatelessWidget {
  final bool isPremium;
  final List<AlertEventItem> items;
  final VoidCallback onToggleMode;
  final VoidCallback onUpgradeTap;
  final ValueChanged<AlertEventItem> onSelectAlert;

  const AlertsListView({
    required this.isPremium,
    required this.items,
    required this.onToggleMode,
    required this.onUpgradeTap,
    required this.onSelectAlert,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final visibleItems = isPremium ? items : items.take(2).toList();
    final savedSummaryText =
        isPremium ? l10n.alertsSavedPremium : l10n.alertsSavedFree;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          // Top Title: App Lock
          const CommonAppBar.brand(),
          const SizedBox(height: 18),

          // Status Summary Card (tapping toggles between Free and Premium list view)
          GestureDetector(
            onTap: onToggleMode,
            behavior: HitTestBehavior.opaque,
            child: Container(
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
                  Row(
                    children: [
                      const Icon(
                        Icons.report_gmailerrorred_rounded,
                        size: 16,
                        color: AppColorsPalette.gray500,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.failedUnlockAttemptsToday,
                        style: AppTypography.regular.copyWith(
                          fontSize: 13.5,
                          color: AppColorsPalette.gray500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.dns_outlined,
                        size: 16,
                        color: AppColorsPalette.gray500,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        savedSummaryText,
                        style: AppTypography.regular.copyWith(
                          fontSize: 13.5,
                          color: AppColorsPalette.gray500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

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
    );
  }

  Widget _buildAlertCard(BuildContext context, AlertEventItem item) {
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
                  hasPhoto: item.hasPhoto,
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
                                  item.title,
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
                                item.timeLabel,
                                style: AppTypography.regular.copyWith(
                                  fontSize: 12,
                                  color: AppColorsPalette.gray400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.failedMethodLabel(item.failedMethod),
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
