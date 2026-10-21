import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_pin_dots.dart';
import 'package:applock/presentation/common/widget/common_pin_keypad.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class SettingsChangePinView extends StatefulWidget {
  final bool isConfirmStep;
  final String firstPin;
  final VoidCallback onBack;
  final ValueChanged<String> onFirstPinEntered;
  final VoidCallback onPinConfirmed;
  final VoidCallback onUsePatternInstead;

  const SettingsChangePinView({
    required this.isConfirmStep,
    required this.firstPin,
    required this.onBack,
    required this.onFirstPinEntered,
    required this.onPinConfirmed,
    required this.onUsePatternInstead,
    super.key,
  });

  @override
  State<SettingsChangePinView> createState() => _SettingsChangePinViewState();
}

class _SettingsChangePinViewState extends State<SettingsChangePinView> {
  String _enteredPin = '';
  bool _hasMismatch = true;

  @override
  void didUpdateWidget(covariant SettingsChangePinView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isConfirmStep != widget.isConfirmStep) {
      _enteredPin = '';
      _hasMismatch = true;
    }
  }

  void _onDigitTap(String digit) {
    if (_enteredPin.length >= 6) return;
    final nextPin = '$_enteredPin$digit';
    setState(() {
      _enteredPin = nextPin;
    });

    if (nextPin.length == 6) {
      Future.delayed(const Duration(milliseconds: 180), () {
        if (!mounted) return;
        if (!widget.isConfirmStep) {
          widget.onFirstPinEntered(nextPin);
        } else {
          if (widget.firstPin.isEmpty || nextPin == widget.firstPin) {
            widget.onPinConfirmed();
          } else {
            setState(() {
              _enteredPin = '';
              _hasMismatch = true;
            });
          }
        }
      });
    }
  }

  void _onBackspaceTap() {
    if (_enteredPin.isEmpty) return;
    setState(() {
      _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isConfirmStep
        ? 'Confirm your Passcode'
        : 'Change Passcode';
    final subtitle = widget.isConfirmStep
        ? (_hasMismatch ? 'PIN does not match.' : 'Re-enter your PIN.')
        : 'Use this PIN to access your protected content.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top-left Back Button
        CommonAppBar.back(onBack: widget.onBack),
        const SizedBox(height: 24),

        // Title & Subtitle (tapping header allows quick preview toggle between Change & Confirm)
        GestureDetector(
          onTap: () {
            if (!widget.isConfirmStep) {
              widget.onFirstPinEntered('123456');
            } else {
              widget.onPinConfirmed();
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
        const SizedBox(height: 22),

        // 6 PIN Dots
        CommonPinDots(
          pinLength: 6,
          filledCount: _enteredPin.length,
        ),

        const Spacer(),

        // PIN Keypad
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CommonPinKeypad(
            onDigitTap: _onDigitTap,
            onBackspaceTap: _onBackspaceTap,
          ),
        ),

        const Spacer(),

        // Bottom "Use pattern instead" link
        Center(
          child: GestureDetector(
            onTap: widget.onUsePatternInstead,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Text(
                'Use pattern instead',
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
