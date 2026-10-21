import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/common/widget/common_subpage_app_bar.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_intruder_illustration.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_list_view.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/dialog_utility.dart';

class AlertsDetailView extends StatefulWidget {
  final AlertEventItem item;
  final VoidCallback onBack;
  final VoidCallback onDeleteConfirmed;
  final VoidCallback? onEnableCameraPermission;

  const AlertsDetailView({
    required this.item,
    required this.onBack,
    required this.onDeleteConfirmed,
    this.onEnableCameraPermission,
    super.key,
  });

  @override
  State<AlertsDetailView> createState() => _AlertsDetailViewState();
}

class _AlertsDetailViewState extends State<AlertsDetailView> {
  late bool _hasPhoto = widget.item.hasPhoto;

  @override
  void didUpdateWidget(covariant AlertsDetailView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item != widget.item) {
      _hasPhoto = widget.item.hasPhoto;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Header Bar
        CommonSubpageAppBar(
          title: 'Alert detail',
          onBack: widget.onBack,
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
                // (Tapping toggles between photo captured and no photo captured variants)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _hasPhoto = !_hasPhoto;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 304,
                      child: AlertsIntruderIllustration(
                        hasPhoto: _hasPhoto,
                        isLarge: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // EVENT SUMMARY + High Alert Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'EVENT SUMMARY',
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
                        'High Alert',
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
                            'Capture Analysis',
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
                        label: 'Attempted context',
                        value: widget.item.attemptedContext,
                      ),
                      _buildDivider(),
                      _buildAnalysisRow(
                        label: 'Failed method',
                        value: widget.item.detailedMethod,
                      ),
                      _buildDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Failed count',
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
                              '${widget.item.failedCount}',
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
                        label: 'Date/time',
                        value: widget.item.detailedDateTime,
                      ),
                      _buildDivider(),
                      _buildAnalysisRow(
                        label: 'Platform',
                        value: 'Android 14',
                      ),
                      _buildDivider(),
                      _buildAnalysisRow(
                        label: 'Device model',
                        value: 'Pixel 8 Pro',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Primary Action Button:
                // - "Save evidence" when photo is captured
                // - "Enable camera permission" when no photo was captured
                CommonButton.filled(
                  text: _hasPhoto
                      ? 'Save evidence'
                      : 'Enable camera permission',
                  height: 48,
                  cornerRadius: 10,
                  backgroundColor: AppColorsPalette.black,
                  textColor: AppColorsPalette.white,
                  textStyle: AppTypography.semiBold.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.white,
                  ),
                  leadingIcon: Icon(
                    _hasPhoto
                        ? Icons.save_rounded
                        : Icons.videocam_outlined,
                    size: 18,
                    color: AppColorsPalette.white,
                  ),
                  iconSpacingFromText: 8,
                  onPressed: () {
                    if (_hasPhoto) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Evidence saved to device'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else if (widget.onEnableCameraPermission != null) {
                      widget.onEnableCameraPermission!();
                    } else {
                      setState(() {
                        _hasPhoto = true;
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),

                // Delete alert Button
                CommonButton.outline(
                  text: 'Delete alert',
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
                      onDelete: widget.onDeleteConfirmed,
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
        Text(
          value,
          style: AppTypography.bold.copyWith(
            fontSize: 14,
            color: AppColorsPalette.black,
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
