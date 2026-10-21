import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/common/widget/common_option_selector_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class SettingsLanguagesView extends StatefulWidget {
  final String currentLanguage;
  final VoidCallback onBack;
  final ValueChanged<String> onSave;

  const SettingsLanguagesView({
    required this.currentLanguage,
    required this.onBack,
    required this.onSave,
    super.key,
  });

  @override
  State<SettingsLanguagesView> createState() => _SettingsLanguagesViewState();
}

class _SettingsLanguagesViewState extends State<SettingsLanguagesView> {
  static const List<String> _languages = [
    'English',
    'Vietnamese',
    'Spanish',
    'French',
    'German',
    'Japanese',
    'Chinese',
  ];

  late String _selectedLanguage = widget.currentLanguage;

  @override
  Widget build(BuildContext context) {
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
                  'Setting Languages',
                  style: AppTypography.bold.copyWith(
                    fontSize: 22,
                    color: AppColorsPalette.black,
                  ),
                ),
                const SizedBox(height: 10),

                // Subtitle
                Text(
                  'Choose your preferred language for the interface\nand document recognition.',
                  style: AppTypography.regular.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.gray500,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 24),

                // Languages Group Card
                CommonOptionSelectorCard(
                  options: _languages,
                  selectedOption: _selectedLanguage,
                  onSelect: (language) {
                    setState(() {
                      _selectedLanguage = language;
                    });
                  },
                ),
                const SizedBox(height: 24),

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
                    widget.onSave(_selectedLanguage);
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
