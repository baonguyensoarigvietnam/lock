import 'package:flutter/material.dart';
import 'package:applock/domain/model/intruder_alert.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_formatting.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_intruder_illustration.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/dialog_utility.dart';
import 'package:applock/utility/extension/build_context.dart';

class AlertsDetailView extends StatelessWidget {
  final IntruderAlert item;
  final bool isCameraGranted;
  final VoidCallback onBack;
  final VoidCallback onDeleteConfirmed;
  final VoidCallback onSaveEvidence;
  final VoidCallback onEnableCameraPermission;

  const AlertsDetailView({
    required this.item,
    required this.isCameraGranted,
    required this.onBack,
    required this.onDeleteConfirmed,
    required this.onSaveEvidence,
    required this.onEnableCameraPermission,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasPhoto = item.hasPhoto;
    return Column(
      children: [
        // Top Header Bar
        CommonAppBar.titledBack(
          title: l10n.alertDetailTitle,
          onBack: onBack,
        ),
        const SizedBox(height: 8),

        // Scrollable Body
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Large Intruder Photo Card / No Photo Captured Card
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 304,
                    child: AlertsIntruderIllustration(
                      photoPath: hasPhoto ? item.photoPath : null,
                      isLarge: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // EVENT SUMMARY + High Alert Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.eventSummaryHeader,
                      style: AppTypography.semiBold.copyWith(
                        fontSize: 11.5,
                        letterSpacing: 0.8,
                        color: AppColorsPalette.gray500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColorsPalette.red50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColorsPalette.red300,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        l10n.highAlertBadge,
                        style: AppTypography.semiBold.copyWith(
                          fontSize: 11,
                          color: AppColorsPalette.red700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Capture Analysis Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.captureAnalysisTitle,
                            style: AppTypography.bold.copyWith(
                              fontSize: 16,
                              color: AppColorsPalette.black,
                            ),
                          ),
                          const Icon(
                            Icons.info_outline_rounded,
                            size: 20,
                            color: AppColorsPalette.gray500,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildAnalysisRow(
                        label: l10n.attemptedContextLabel,
                        value: item.displayTitle(context),
                      ),
                      _buildDivider(),
                      _buildAnalysisRow(
                        label: l10n.failedMethodRowLabel,
                        value: item.methodLabel(context),
                      ),
                      _buildDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.failedCountLabel,
                            style: AppTypography.regular.copyWith(
                              fontSize: 13.5,
                              color: AppColorsPalette.gray500,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColorsPalette.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${item.failedCount}',
                              style: AppTypography.semiBold.copyWith(
                                fontSize: 12,
                                color: AppColorsPalette.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      _buildDivider(),
                      _buildAnalysisRow(
                        label: l10n.dateTimeLabel,
                        value: item.fullDateTimeLabel(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Primary Action Button:
                // - "Save evidence" when photo is captured
                // - "Enable camera permission" when no photo was captured
                //   because the camera permission is missing
                if (hasPhoto || !isCameraGranted) ...[
                  CommonButton.filled(
                    text: hasPhoto
                        ? l10n.saveEvidenceButton
                        : l10n.enableCameraPermissionButton,
                    height: 48,
                    cornerRadius: 10,
                    backgroundColor: AppColorsPalette.black,
                    textColor: AppColorsPalette.white,
                    textStyle: AppTypography.semiBold.copyWith(
                      fontSize: 14,
                      color: AppColorsPalette.white,
                    ),
                    leadingIcon: Icon(
                      hasPhoto ? Icons.save_rounded : Icons.videocam_outlined,
                      size: 18,
                      color: AppColorsPalette.white,
                    ),
                    iconSpacingFromText: 8,
                    onPressed:
                        hasPhoto ? onSaveEvidence : onEnableCameraPermission,
                  ),
                  const SizedBox(height: 10),
                ],

                // Delete alert Button
                CommonButton.outline(
                  text: l10n.deleteAlertButton,
                  height: 48,
                  cornerRadius: 10,
                  backgroundColor: AppColorsPalette.white,
                  borderColor: AppColorsPalette.gray200,
                  borderWidth: 1,
                  textColor: AppColorsPalette.black,
                  textStyle: AppTypography.semiBold.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.black,
                  ),
                  leadingIcon: const Icon(
                    Icons.delete_outline_rounded,
                    size: 18,
                    color: AppColorsPalette.black,
                  ),
                  iconSpacingFromText: 8,
                  onPressed: () {
                    DialogUtility.showDeleteAlertBottomSheet(
                      context: context,
                      onDelete: onDeleteConfirmed,
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalysisRow({
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.regular.copyWith(
            fontSize: 13.5,
            color: AppColorsPalette.gray500,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bold.copyWith(
              fontSize: 14,
              color: AppColorsPalette.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 24,
      thickness: 1,
      color: AppColorsPalette.gray100,
    );
  }
}
