import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

/// Shared grouped list card for selecting a single string option with a radio indicator.
class CommonOptionSelectorCard extends StatelessWidget {
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onSelect;

  const CommonOptionSelectorCard({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorsPalette.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColorsPalette.gray200,
          width: 1,
        ),
      ),
      child: Column(
        children: List.generate(options.length, (index) {
          final option = options[index];
          final isSelected = option == selectedOption;
          final isLast = index == options.length - 1;

          return Column(
            children: [
              InkWell(
                onTap: () => onSelect(option),
                borderRadius: BorderRadius.vertical(
                  top: index == 0 ? const Radius.circular(14) : Radius.zero,
                  bottom: isLast ? const Radius.circular(14) : Radius.zero,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
