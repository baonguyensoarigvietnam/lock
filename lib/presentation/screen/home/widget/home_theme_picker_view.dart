import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class HomeThemePickerView extends StatefulWidget {
  final VoidCallback onApplyTheme;
  final VoidCallback onOpenPremiumPreview;
  final VoidCallback onBackToDashboard;

  const HomeThemePickerView({
    required this.onApplyTheme,
    required this.onOpenPremiumPreview,
    required this.onBackToDashboard,
    super.key,
  });

  @override
  State<HomeThemePickerView> createState() => _HomeThemePickerViewState();
}

class _HomeThemePickerViewState extends State<HomeThemePickerView> {
  int _selectedIndex = 0;

  static const List<String> _themeTitles = [
    'Minimal',
    'Classic PIN',
    'Pattern',
    'Vault',
    'Focus',
    'Premium Colors',
  ];

  void _onCardTap(int index) {
    if (index == 5) {
      setState(() => _selectedIndex = index);
      widget.onOpenPremiumPreview();
      return;
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Top Title: App Lock (tapping title returns to Home dashboard)
          CommonAppBar.brand(onTitleTap: widget.onBackToDashboard),
          const SizedBox(height: 20),

          // 2-Column Grid of 6 Themes
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _themeTitles.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 16,
              childAspectRatio: 0.66,
            ),
            itemBuilder: (context, index) {
              return _buildThemeGridItem(index);
            },
          ),
          const SizedBox(height: 22),

          // Apply theme Button
          CommonButton.filled(
            text: 'Apply theme',
            height: 48,
            cornerRadius: 10,
            backgroundColor: AppColorsPalette.black,
            textColor: AppColorsPalette.white,
            textStyle: AppTypography.semiBold.copyWith(
              fontSize: 14,
              color: AppColorsPalette.white,
            ),
            onPressed: () {
              if (_selectedIndex == 5) {
                widget.onOpenPremiumPreview();
              } else {
                widget.onApplyTheme();
              }
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildThemeGridItem(int index) {
    final isSelected = _selectedIndex == index;
    final title = _themeTitles[index];

    if (isSelected) {
      return GestureDetector(
        onTap: () => _onCardTap(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(
            color: AppColorsPalette.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColorsPalette.black,
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _cardBackgroundColor(index),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(13),
                      bottom: Radius.circular(10),
                    ),
                    border: const Border(
                      bottom: BorderSide(
                        color: AppColorsPalette.gray200,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(child: _buildThemeArtwork(index)),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            color: AppColorsPalette.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.check_rounded,
                              size: 14,
                              color: AppColorsPalette.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Text(
                  title,
                  style: AppTypography.bold.copyWith(
                    fontSize: 13.5,
                    color: AppColorsPalette.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => _onCardTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: _cardBackgroundColor(index),
                gradient: index == 5
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColorsPalette.gray200,
                          AppColorsPalette.white,
                          AppColorsPalette.gray150,
                        ],
                      )
                    : null,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: index == 4
                      ? AppColorsPalette.black
                      : AppColorsPalette.gray200,
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  Center(child: _buildThemeArtwork(index)),
                  if (index == 5)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColorsPalette.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'PREMIUM',
                          style: AppTypography.bold.copyWith(
                            fontSize: 9,
                            letterSpacing: 0.4,
                            color: AppColorsPalette.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              title,
              style: AppTypography.bold.copyWith(
                fontSize: 13.5,
                color: AppColorsPalette.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _cardBackgroundColor(int index) {
    switch (index) {
      case 4:
        return AppColorsPalette.black;
      case 1:
      case 3:
        return AppColorsPalette.gray50;
      default:
        return AppColorsPalette.white;
    }
  }

  Widget _buildThemeArtwork(int index) {
    switch (index) {
      case 0: // Minimal
        return Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColorsPalette.black,
              width: 1.5,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.lock_rounded,
              size: 20,
              color: AppColorsPalette.black,
            ),
          ),
        );

      case 1: // Classic PIN (3x2 grid of light circles)
        return SizedBox(
          width: 78,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: List.generate(
              6,
              (_) => Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColorsPalette.gray150,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColorsPalette.gray200,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        );

      case 2: // Pattern (3x3 dots with center black dot)
        return SizedBox(
          width: 58,
          height: 58,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
            ),
            itemBuilder: (_, dotIndex) {
              final isCenter = dotIndex == 4;
              return Center(
                child: Container(
                  width: 6.5,
                  height: 6.5,
                  decoration: BoxDecoration(
                    color: isCenter
                        ? AppColorsPalette.black
                        : AppColorsPalette.gray300,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        );

      case 3: // Vault dial
        return SizedBox(
          width: 72,
          height: 72,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColorsPalette.gray550,
                    width: 2.5,
                  ),
                ),
              ),
              Positioned(
                top: 2,
                child: Container(
                  width: 2.5,
                  height: 34,
                  color: AppColorsPalette.gray550,
                ),
              ),
              Container(
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  color: AppColorsPalette.gray550,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        );

      case 4: // Focus (Black card with white visibility_off icon)
        return const Icon(
          Icons.visibility_off_outlined,
          size: 34,
          color: AppColorsPalette.white,
        );

      case 5: // Premium Colors (3 colored dots: black, gray, red)
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildColorDot(AppColorsPalette.black),
            const SizedBox(width: 10),
            _buildColorDot(AppColorsPalette.gray550),
            const SizedBox(width: 10),
            _buildColorDot(AppColorsPalette.red700),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildColorDot(Color color) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
