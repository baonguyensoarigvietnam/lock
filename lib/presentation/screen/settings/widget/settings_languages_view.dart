import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/application/view_model/global_view_model.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/common/widget/common_option_selector_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/enumeration/app_language.dart';
import 'package:applock/utility/extension/build_context.dart';

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
  late AppLanguage _selectedLanguage =
      AppLanguage.fromNameOrCode(widget.currentLanguage);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final localizedNames = AppLanguage.values
        .map((lang) => lang.localizedName(l10n))
        .toList();
    final selectedLabel = _selectedLanguage.localizedName(l10n);

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
                  l10n.settingLanguagesTitle,
                  style: AppTypography.bold.copyWith(
                    fontSize: 22,
                    color: AppColorsPalette.black,
                  ),
                ),
                const SizedBox(height: 10),

                // Subtitle
                Text(
                  l10n.settingLanguagesSubtitle,
                  style: AppTypography.regular.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.gray500,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 24),

                // Languages Group Card
                CommonOptionSelectorCard(
                  options: localizedNames,
                  selectedOption: selectedLabel,
                  onSelect: (label) {
                    final idx = localizedNames.indexOf(label);
                    if (idx != -1) {
                      setState(() {
                        _selectedLanguage = AppLanguage.values[idx];
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),

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
                    try {
                      context
                          .read<GlobalViewModel>()
                          .setLanguage(_selectedLanguage);
                    } catch (_) {}
                    widget.onSave(_selectedLanguage.englishName);
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
