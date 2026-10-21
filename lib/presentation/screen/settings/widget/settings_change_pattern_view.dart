import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/pattern_lock_grid.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

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
  List<int> _displayDots = const [];
  bool _hasError = false;

  @override
  void didUpdateWidget(covariant SettingsChangePatternView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isConfirmStep != widget.isConfirmStep) {
      _displayDots = const [];
      _hasError = false;
    }
  }

  void _handlePatternComplete(List<int> pattern) {
    if (pattern.length < 4) {
      setState(() {
        _displayDots = const [];
        _hasError = !widget.isConfirmStep;
      });
      return;
    }
    setState(() {
      _displayDots = pattern;
      _hasError = false;
    });

    Future.delayed(const Duration(milliseconds: 220), () {
      if (!mounted) return;
      if (!widget.isConfirmStep) {
        widget.onFirstPatternEntered(pattern);
      } else {
        if (listEquals(pattern, widget.firstPattern)) {
          widget.onPatternConfirmed();
        } else {
          setState(() {
            _displayDots = const [];
            _hasError = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final title = widget.isConfirmStep
        ? l10n.confirmYourPatternTitle
        : l10n.changePasscodeTitle;
    final subtitle = widget.isConfirmStep
        ? (_hasError
            ? l10n.patternDoesNotMatchError
            : l10n.drawPatternAgainConfirm)
        : l10n.connectAtLeast4Dots;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top-left Back Button
        CommonAppBar.back(onBack: widget.onBack),
        const SizedBox(height: 24),

        // Title & Subtitle
        Center(
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

        const Spacer(),

        // 3x3 Pattern Lock Grid
        Center(
          child: SizedBox(
            width: 280,
            height: 280,
            child: PatternLockGrid(
              selectedDots: _displayDots,
              isError: _hasError,
              onPatternStart: () {
                if (_hasError) setState(() => _hasError = false);
              },
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
                l10n.usePinInstead,
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
