import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/common/widget/common_option_selector_card.dart';
import 'package:applock/presentation/common/widget/common_subpage_app_bar.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

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
  static const List<String> _delayOptions = [
    'Immediately',
    'After 15 seconds',
    'After 30 seconds',
    'After 1 minute',
    'When screen turns off',
  ];

  late String _selectedDelay = widget.currentDelay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top-left Back Button
        CommonSubpageAppBar(onBack: widget.onBack),
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
                  'Require Authentication',
                  style: AppTypography.bold.copyWith(
                    fontSize: 22,
                    color: AppColorsPalette.black,
                  ),
                ),
                const SizedBox(height: 10),

                // Subtitle
                Text(
                  'Choose how quickly the app locks after you\nleave it. Shorter delays provide stronger privacy\nprotection.',
                  style: AppTypography.regular.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.gray500,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 24),

                // Options Group Card
                CommonOptionSelectorCard(
                  options: _delayOptions,
                  selectedOption: _selectedDelay,
                  onSelect: (option) {
                    setState(() {
                      _selectedDelay = option;
                    });
                  },
                ),
                const SizedBox(height: 28),

                // Save Button
                CommonButton.filled(
                  text: 'Save',
                  height: 48,
                  cornerRadius: 10,
                  backgroundColor: AppColorsPalette.black,
                  textColor: AppColorsPalette.white,
                  textStyle: AppTypography.semiBold.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.white,
                  ),
                  onPressed: () {
                    widget.onSave(_selectedDelay);
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
