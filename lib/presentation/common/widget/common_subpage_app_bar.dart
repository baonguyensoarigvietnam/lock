import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

/// Shared top navigation bar with a back button, optional centered title, and optional trailing actions.
class CommonSubpageAppBar extends StatelessWidget {
  final VoidCallback onBack;
  final String? title;
  final List<Widget>? actions;
  final EdgeInsetsGeometry padding;

  const CommonSubpageAppBar({
    super.key,
    required this.onBack,
    this.title,
    this.actions,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColorsPalette.black,
              size: 22,
            ),
            onPressed: onBack,
          ),
          if (title != null)
            Expanded(
              child: Center(
                child: Text(
                  title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bold.copyWith(
                    fontSize: 17,
                    color: AppColorsPalette.black,
                  ),
                ),
              ),
            )
          else
            const Spacer(),
          if (actions != null && actions!.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            )
          else if (title != null)
            const SizedBox(width: 48),
        ],
      ),
    );
  }
}
