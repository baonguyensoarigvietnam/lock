import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

/// Shared app bar with named constructors tailored to each screen pattern:
/// - [CommonAppBar.brand]: Centered "App Lock" brand header (main tabs, onboarding, biometric, unlock method).
/// - [CommonAppBar.back]: Left back button with optional trailing actions (PIN/Pattern setup, settings subpages, album details).
/// - [CommonAppBar.titledBack]: Left back button + centered title + optional trailing actions (Permission guide, Vault import/viewer/file info, Alert detail).
/// - [CommonAppBar.close]: Left close (X) button with optional title/actions (Paywall).
/// - [CommonAppBar.custom]: Full customization of leading, title, and trailing widgets.
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Centered brand header (defaults to localized `'App Lock'`).
  ///
  /// Used in Onboarding, Unlock Method, Enable Biometric, and the 5 main tabs.
  const CommonAppBar.brand({
    this.title,
    this.titleStyle,
    this.onTitleTap,
    this.actions,
    this.padding = const EdgeInsets.symmetric(vertical: 4),
    this.backgroundColor = AppColorsPalette.transparent,
    this.height = 48,
    super.key,
  }) : _leadingType = _AppBarLeadingType.none,
       onLeadingPressed = null,
       leading = null,
       leadingIconSize = 22,
       leadingIconColor = AppColorsPalette.black,
       centerTitle = true;

  /// Top bar with a left back button and optional trailing [actions] (no title).
  ///
  /// Used in Set Passcode, Set Pattern, Settings sub-screens, and Vault album details.
  const CommonAppBar.back({
    required VoidCallback onBack,
    this.actions,
    this.leadingIconSize = 22,
    this.leadingIconColor = AppColorsPalette.black,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.backgroundColor = AppColorsPalette.transparent,
    this.height = 52,
    super.key,
  }) : _leadingType = _AppBarLeadingType.back,
       onLeadingPressed = onBack,
       leading = null,
       title = null,
       titleStyle = null,
       onTitleTap = null,
       centerTitle = true;

  /// Top bar with a left back button, centered [title], and optional trailing [actions].
  ///
  /// Used in Permission Guide, Vault Import, Media Viewers, File Info, and Alert Detail.
  const CommonAppBar.titledBack({
    required VoidCallback onBack,
    required String this.title,
    this.titleStyle,
    this.onTitleTap,
    this.actions,
    this.leadingIconSize = 22,
    this.leadingIconColor = AppColorsPalette.black,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.backgroundColor = AppColorsPalette.transparent,
    this.height = 52,
    super.key,
  }) : _leadingType = _AppBarLeadingType.back,
       onLeadingPressed = onBack,
       leading = null,
       centerTitle = true;

  /// Top bar with a left close (`X`) button, optional [title], and optional [actions].
  ///
  /// Used in Paywall / modal screens.
  const CommonAppBar.close({
    required VoidCallback onClose,
    this.title,
    this.titleStyle,
    this.onTitleTap,
    this.actions,
    this.leadingIconSize = 26,
    this.leadingIconColor = AppColorsPalette.black,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.backgroundColor = AppColorsPalette.transparent,
    this.height = 52,
    super.key,
  }) : _leadingType = _AppBarLeadingType.close,
       onLeadingPressed = onClose,
       leading = null,
       centerTitle = true;

  /// Fully customizable app bar constructor.
  const CommonAppBar.custom({
    this.leading,
    this.title,
    this.titleStyle,
    this.onTitleTap,
    this.actions,
    this.centerTitle = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.backgroundColor = AppColorsPalette.transparent,
    this.height = 52,
    super.key,
  }) : _leadingType = _AppBarLeadingType.custom,
       onLeadingPressed = null,
       leadingIconSize = 22,
       leadingIconColor = AppColorsPalette.black;

  final _AppBarLeadingType _leadingType;
  final VoidCallback? onLeadingPressed;
  final Widget? leading;
  final double leadingIconSize;
  final Color leadingIconColor;
  final String? title;
  final TextStyle? titleStyle;
  final VoidCallback? onTitleTap;
  final List<Widget>? actions;
  final bool centerTitle;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    // Pure brand header without leading/actions
    if (_leadingType == _AppBarLeadingType.none &&
        (actions == null || actions!.isEmpty)) {
      final resolvedTitle = title ?? context.l10n.appLockTitle;
      final titleWidget = Center(
        child: Text(
          resolvedTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: titleStyle ??
              AppTypography.bold.copyWith(
                fontSize: 20,
                color: AppColorsPalette.black,
              ),
        ),
      );

      final content = Padding(
        padding: padding,
        child: titleWidget,
      );

      if (onTitleTap == null) {
        return ColoredBox(color: backgroundColor, child: content);
      }

      return ColoredBox(
        color: backgroundColor,
        child: GestureDetector(
          onTap: onTitleTap,
          behavior: HitTestBehavior.opaque,
          child: content,
        ),
      );
    }

    final Widget? resolvedLeading = _buildLeading();
    final bool hasActions = actions != null && actions!.isNotEmpty;

    return ColoredBox(
      color: backgroundColor,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            ?resolvedLeading,
            if (title != null)
              Expanded(
                child: GestureDetector(
                  onTap: onTitleTap,
                  behavior: HitTestBehavior.opaque,
                  child: Align(
                    alignment: centerTitle
                        ? Alignment.center
                        : Alignment.centerLeft,
                    child: Text(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign:
                          centerTitle ? TextAlign.center : TextAlign.start,
                      style: titleStyle ??
                          AppTypography.bold.copyWith(
                            fontSize: 17,
                            color: AppColorsPalette.black,
                          ),
                    ),
                  ),
                ),
              )
            else
              const Spacer(),
            if (hasActions)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              )
            else if (title != null && centerTitle && resolvedLeading != null)
              const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  Widget? _buildLeading() {
    switch (_leadingType) {
      case _AppBarLeadingType.none:
        return null;
      case _AppBarLeadingType.back:
        return IconButton(
          onPressed: onLeadingPressed,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: leadingIconColor,
            size: leadingIconSize,
          ),
        );
      case _AppBarLeadingType.close:
        return IconButton(
          onPressed: onLeadingPressed,
          icon: Icon(
            Icons.close_rounded,
            color: leadingIconColor,
            size: leadingIconSize,
          ),
        );
      case _AppBarLeadingType.custom:
        return leading;
    }
  }
}

enum _AppBarLeadingType {
  none,
  back,
  close,
  custom,
}
