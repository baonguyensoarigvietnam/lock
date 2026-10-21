import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

/// Shared app button with 2 visual variants:
/// - [CommonButton.filled]: Solid background (e.g. Black "Enable biometric")
/// - [CommonButton.outline]: Border outline (e.g. White with black border "Skip")
///
/// The button is considered disabled when [onPressed] is `null`.
class CommonButton extends StatelessWidget {
  /// Creates a filled button.
  ///
  /// Example:
  /// `CommonButton.filled(text: 'Enable biometric', onPressed: _onEnable)`
  const CommonButton.filled({
    this.text,
    this.textStyle,
    this.onPressed,
    this.cornerRadius = 120,
    this.backgroundColor = AppColorsPalette.black,
    this.textColor = AppColorsPalette.white,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.leadingIcon,
    this.trailingIcon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.borderColor = AppColorsPalette.transparent,
    this.borderWidth = 0,
    this.height = 56,
    this.width,
    this.iconSpacingFromText,
    this.boxShadow,
    this.isLoading = false,
    this.loadingColor,
    super.key,
  }) : _isFilled = true;

  /// Creates an outlined button.
  ///
  /// Example:
  /// `CommonButton.outline(text: 'Skip', onPressed: _onSkip)`
  const CommonButton.outline({
    this.text,
    this.textStyle,
    this.onPressed,
    this.cornerRadius = 120,
    this.backgroundColor = AppColorsPalette.white,
    this.textColor = AppColorsPalette.black,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.leadingIcon,
    this.trailingIcon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.borderColor = AppColorsPalette.black,
    this.borderWidth = 1.5,
    this.height = 56,
    this.width,
    this.iconSpacingFromText,
    this.boxShadow,
    this.isLoading = false,
    this.loadingColor,
    super.key,
  }) : _isFilled = false;

  /// Corner radius of the button shape.
  final double cornerRadius;

  /// Enabled background color.
  final Color? backgroundColor;

  /// Text color.
  final Color? textColor;

  /// Label text.
  final String? text;

  /// Optional override for label style.
  final TextStyle? textStyle;

  /// Private property indicating filled/outline shape of the button.
  final bool _isFilled;

  /// Disabled background color.
  final Color? disabledBackgroundColor;

  /// Disabled label color.
  final Color? disabledTextColor;

  /// Optional icon shown on the left.
  final Widget? leadingIcon;

  /// Optional icon shown on the right.
  final Widget? trailingIcon;

  /// Tap callback; `null` means disabled.
  final VoidCallback? onPressed;

  /// Inner content padding.
  final EdgeInsetsGeometry padding;

  /// Border color (mainly for outline variant).
  final Color? borderColor;

  /// Border width.
  final double borderWidth;

  /// Fixed button height.
  final double height;

  /// Optional fixed button width.
  final double? width;

  /// Distance between icon and text when icons should sit near label.
  ///
  /// - `null`: icons stay on far edges.
  /// - `non-null`: icons render next to text with this spacing.
  final double? iconSpacingFromText;

  /// Shadow for the button.
  final List<BoxShadow>? boxShadow;

  /// Whether the button is in loading state.
  final bool isLoading;

  /// Optional custom color for the loading spinner.
  final Color? loadingColor;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null && !isLoading;

    final Color resolvedDisabledBackground = isLoading
        ? (backgroundColor ??
            (_isFilled ? AppColorsPalette.black : AppColorsPalette.transparent))
        : (disabledBackgroundColor ??
            (_isFilled
                ? AppColorsPalette.gray400
                : AppColorsPalette.transparent));

    final Color resolvedDisabledText = disabledTextColor ??
        (_isFilled ? AppColorsPalette.white : AppColorsPalette.gray400);

    final Color resolvedBackground = isEnabled
        ? (backgroundColor ??
            (_isFilled ? AppColorsPalette.black : AppColorsPalette.white))
        : resolvedDisabledBackground;

    final Color resolvedTextColor = isEnabled
        ? (textColor ??
            (_isFilled ? AppColorsPalette.white : AppColorsPalette.black))
        : resolvedDisabledText;

    final Color resolvedBorder = isEnabled
        ? (borderColor ?? AppColorsPalette.black)
        : (borderColor != null
            ? borderColor!.withValues(alpha: 0.3)
            : resolvedDisabledText);

    final BorderSide? side = !_isFilled
        ? BorderSide(color: resolvedBorder, width: borderWidth)
        : null;

    final TextStyle resolvedTextStyle = (textStyle ?? AppTypography.bold)
        .copyWith(
          color: textStyle?.color ?? resolvedTextColor,
          fontSize: textStyle?.fontSize ?? 17,
          height: textStyle?.height ?? (22 / 17),
          letterSpacing: textStyle?.letterSpacing ?? 0,
        );

    final Widget? resolvedLabel = text != null
        ? Text(
            text!,
            style: resolvedTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        : null;

    return Material(
      color: AppColorsPalette.transparent,
      borderRadius: BorderRadius.circular(cornerRadius),
      child: InkWell(
        onTap: (isEnabled && !isLoading) ? onPressed : null,
        highlightColor: resolvedTextColor.withValues(alpha: 0.15),
        splashColor: resolvedTextColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(cornerRadius),
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: resolvedBackground,
            borderRadius: BorderRadius.circular(cornerRadius),
            border: side == null ? null : Border.fromBorderSide(side),
            boxShadow: boxShadow,
          ),
          child: Padding(
            padding: padding,
            child: _buildContent(resolvedLabel ?? const SizedBox.shrink()),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Widget resolvedLabel) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: loadingColor ??
                (_isFilled
                    ? (textColor ?? AppColorsPalette.white)
                    : (textColor ?? AppColorsPalette.black)),
          ),
        ),
      );
    }

    if (text == null && leadingIcon != null && trailingIcon == null) {
      return Center(child: leadingIcon!);
    }

    if (text == null && trailingIcon != null && leadingIcon == null) {
      return Center(child: trailingIcon!);
    }

    if (iconSpacingFromText != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            leadingIcon!,
            SizedBox(width: iconSpacingFromText),
          ],
          Flexible(child: resolvedLabel),
          if (trailingIcon != null) ...[
            SizedBox(width: iconSpacingFromText),
            trailingIcon!,
          ],
        ],
      );
    }

    if (leadingIcon == null && trailingIcon == null) {
      return Center(child: resolvedLabel);
    }

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: leadingIcon ?? const SizedBox.shrink(),
          ),
        ),
        Expanded(flex: 6, child: Center(child: resolvedLabel)),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: trailingIcon ?? const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
