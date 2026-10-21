import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/common/widget/common_option_selector_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class SettingsRequireAuthView extends StatefulWidget {
  final String currentDelay;
  final VoidCallback onBack;
  final ValueChanged<String> onSave;

  const SettingsRequireAuthView({
    required this.currentDelay,
    required this.onBack,
    required this.onSave,
    super.key,
  });

  @override
  State<SettingsRequireAuthView> createState() =>
      _SettingsRequireAuthViewState();
}

class _SettingsRequireAuthViewState extends State<SettingsRequireAuthView> {
  static const List<String> _delayKeys = [
    'Immediately',
    'After 15 seconds',
    'After 30 seconds',
    'After 1 minute',
    'When screen turns off',
  ];

  late int _selectedIndex = _delayKeys
      .indexOf(widget.currentDelay)
      .clamp(0, _delayKeys.length - 1);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final localizedOptions = [
      l10n.delayImmediately,
      l10n.delay15Seconds,
      l10n.delay30Seconds,
      l10n.delay1Minute,
      l10n.delayScreenOff,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top-left Back Button
        CommonAppBar.back(onBack: widget.onBack),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                // Title
                Text(
                  l10n.requireAuthenticationTitle,
                  style: AppTypography.bold.copyWith(
                    fontSize: 22,
                    color: AppColorsPalette.black,
                  ),
                ),
                const SizedBox(height: 10),

                // Subtitle
                Text(
                  l10n.requireAuthenticationSubtitle,
                  style: AppTypography.regular.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.gray500,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 24),

                // Options Group Card
                CommonOptionSelectorCard(
                  options: localizedOptions,
                  selectedOption: localizedOptions[_selectedIndex],
                  onSelect: (option) {
                    final idx = localizedOptions.indexOf(option);
                    if (idx != -1) {
                      setState(() {
                        _selectedIndex = idx;
                      });
                    }
                  },
                ),
                const SizedBox(height: 28),

                // Save Button
                CommonButton.filled(
                  text: l10n.saveButton,
                  height: 48,
                  cornerRadius: 10,
                  backgroundColor: AppColorsPalette.black,
                  textColor: AppColorsPalette.white,
                  textStyle: AppTypography.semiBold.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.white,
                  ),
                  onPressed: () {
                    widget.onSave(_delayKeys[_selectedIndex]);
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
}
