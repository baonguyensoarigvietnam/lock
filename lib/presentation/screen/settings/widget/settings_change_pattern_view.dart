import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_subpage_app_bar.dart';
import 'package:applock/presentation/common/widget/pattern_lock_grid.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class SettingsChangePatternView extends StatefulWidget {
  final bool isConfirmStep;
  final List<int> firstPattern;
  final VoidCallback onBack;
  final ValueChanged<List<int>> onFirstPatternEntered;
  final VoidCallback onPatternConfirmed;
  final VoidCallback onUsePinInstead;

  const SettingsChangePatternView({
    required this.isConfirmStep,
    required this.firstPattern,
    required this.onBack,
    required this.onFirstPatternEntered,
    required this.onPatternConfirmed,
    required this.onUsePinInstead,
    super.key,
  });

  @override
  State<SettingsChangePatternView> createState() =>
      _SettingsChangePatternViewState();
}

class _SettingsChangePatternViewState extends State<SettingsChangePatternView> {
  static const List<int> _initialChangePreviewDots = [0, 1, 5, 7];
  static const List<int> _initialConfirmPreviewDots = [1, 3, 7, 8];

  late List<int> _displayDots = widget.isConfirmStep
      ? _initialConfirmPreviewDots
      : _initialChangePreviewDots;

  @override
  void didUpdateWidget(covariant SettingsChangePatternView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isConfirmStep != widget.isConfirmStep) {
      _displayDots = widget.isConfirmStep
          ? _initialConfirmPreviewDots
          : _initialChangePreviewDots;
    }
  }

  void _handlePatternComplete(List<int> pattern) {
    if (pattern.length < 4) return;
    setState(() {
      _displayDots = pattern;
    });

    Future.delayed(const Duration(milliseconds: 220), () {
      if (!mounted) return;
      if (!widget.isConfirmStep) {
        widget.onFirstPatternEntered(pattern);
      } else {
        if (widget.firstPattern.isEmpty ||
            listEquals(pattern, widget.firstPattern)) {
          widget.onPatternConfirmed();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isConfirmStep
        ? 'Confirm your Passcode'
        : 'Change Passcode';
    final subtitle = widget.isConfirmStep
        ? 'Pattern does not match'
        : 'Connect at least 4 dots.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top-left Back Button
        CommonSubpageAppBar(onBack: widget.onBack),
        const SizedBox(height: 24),

        // Title & Subtitle (tapping header allows quick preview toggle between Change & Confirm)
        GestureDetector(
          onTap: () {
            if (!widget.isConfirmStep) {
              widget.onFirstPatternEntered(_initialChangePreviewDots);
            } else {
              widget.onPatternConfirmed();
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTypography.bold.copyWith(
                      fontSize: 24,
                      color: AppColorsPalette.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: AppTypography.regular.copyWith(
                      fontSize: 14,
                      color: AppColorsPalette.gray500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const Spacer(),

        // 3x3 Pattern Lock Grid
        Center(
          child: SizedBox(
            width: 280,
            height: 280,
            child: PatternLockGrid(
              selectedDots: _displayDots,
              onPatternComplete: _handlePatternComplete,
            ),
          ),
        ),

        const Spacer(),

        // Bottom "Use PIN instead" link
        Center(
          child: GestureDetector(
            onTap: widget.onUsePinInstead,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Text(
                'Use PIN instead',
                style: AppTypography.bold.copyWith(
                  fontSize: 14,
                  color: AppColorsPalette.black,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColorsPalette.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
