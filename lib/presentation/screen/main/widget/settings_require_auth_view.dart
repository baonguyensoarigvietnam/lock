import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
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
        const SizedBox(height: 8),
        // Top-left Back Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: IconButton(
            onPressed: widget.onBack,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColorsPalette.black,
              size: 22,
            ),
          ),
        ),
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
                Container(
                  decoration: BoxDecoration(
                    color: AppColorsPalette.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColorsPalette.gray200,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: List.generate(_delayOptions.length, (index) {
                      final option = _delayOptions[index];
                      final isSelected = option == _selectedDelay;
                      final isLast = index == _delayOptions.length - 1;

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selectedDelay = option;
                              });
                            },
                            borderRadius: BorderRadius.vertical(
                              top: index == 0
                                  ? const Radius.circular(14)
                                  : Radius.zero,
                              bottom: isLast
                                  ? const Radius.circular(14)
                                  : Radius.zero,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 18,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    option,
                                    style: AppTypography.regular.copyWith(
                                      fontSize: 16,
                                      color: AppColorsPalette.black,
                                    ),
                                  ),
                                  _buildRadioCircle(isSelected),
                                ],
                              ),
                            ),
                          ),
                          if (!isLast)
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: AppColorsPalette.gray200,
                            ),
                        ],
                      );
                    }),
                  ),
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

  Widget _buildRadioCircle(bool isSelected) {
    if (isSelected) {
      return Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColorsPalette.black,
          border: Border.all(
            color: AppColorsPalette.blue600,
            width: 2.2,
          ),
        ),
      );
    }

    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColorsPalette.white,
        border: Border.all(
          color: AppColorsPalette.gray500,
          width: 1.2,
        ),
      ),
    );
  }
}
