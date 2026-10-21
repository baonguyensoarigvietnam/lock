import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class DialogUtility {
  static Future<T?> _showDialog<T>({
    required BuildContext context,
    required Widget Function(BuildContext, Animation<double>) builder,
    bool barrierDismissible = true,
    Color? barrierColor,
  }) {
    return showGeneralDialog<T>(
      barrierColor:
          barrierColor ?? AppColorsPalette.black.withValues(alpha: 0.6),
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder:
          (context, unusedPrimaryAnimation, unusedSecondaryAnimation) =>
              const SizedBox(),
      useRootNavigator: true,
      transitionBuilder: (context, animation, secondaryAnimation, _) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curvedAnimation,
          child: ScaleTransition(
            scale: curvedAnimation,
            child: builder(context, curvedAnimation),
          ),
        );
      },
    );
  }

  /// Show a general modal.
  static Future<T?> showGeneralModal<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
    bool isTransparent = false,
    double cornerRadius = 10,
    Color? barrierColor,
    bool removeBottom = true,
    Duration transitionDuration = const Duration(milliseconds: 300),
  }) {
    return _showDialog<T>(
      barrierColor: barrierColor,
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext, animation) => MediaQuery.removeViewInsets(
        context: dialogContext,
        removeBottom: removeBottom,
        child: SafeArea(
          left: true,
          right: true,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
            ),
            backgroundColor:
                isTransparent ? AppColorsPalette.transparent : null,
            insetPadding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 392),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  /// Show a bottom sheet modal.
  static Future<T?> showBottomSheetModal<T>({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    bool removeBottom = false,
  }) {
    final content = removeBottom
        ? MediaQuery.removeViewInsets(
            context: context,
            removeBottom: true,
            child: child,
          )
        : child;

    return showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      isDismissible: isDismissible,
      enableDrag: true,
      useSafeArea: useSafeArea,
      isScrollControlled: true,
      barrierColor:
          barrierColor ?? AppColorsPalette.black.withValues(alpha: 0.45),
      backgroundColor: AppColorsPalette.transparent,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      builder: (_) => content,
    );
  }

  /// Show a standard App Lock confirmation bottom sheet with icon, title,
  /// description, primary filled button, and secondary outlined button.
  static Future<void> showConfirmBottomSheet({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required String primaryButtonText,
    required String secondaryButtonText,
    required VoidCallback onPrimaryTap,
    VoidCallback? onSecondaryTap,
  }) {
    return showBottomSheetModal<void>(
      context: context,
      useSafeArea: false,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColorsPalette.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top drag handle
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColorsPalette.gray200,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Icon + Title Row
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColorsPalette.gray100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          color: AppColorsPalette.black,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: AppTypography.bold.copyWith(
                          fontSize: 20,
                          color: AppColorsPalette.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  description,
                  style: AppTypography.regular.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.gray500,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 24),
                Builder(
                  builder: (sheetContext) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonButton.filled(
                        text: primaryButtonText,
                        height: 48,
                        cornerRadius: 10,
                        backgroundColor: AppColorsPalette.black,
                        textColor: AppColorsPalette.white,
                        textStyle: AppTypography.semiBold.copyWith(
                          fontSize: 14,
                          color: AppColorsPalette.white,
                        ),
                        onPressed: () {
                          Navigator.of(sheetContext).pop();
                          onPrimaryTap();
                        },
                      ),
                      const SizedBox(height: 10),
                      CommonButton.outline(
                        text: secondaryButtonText,
                        height: 48,
                        cornerRadius: 10,
                        backgroundColor: AppColorsPalette.white,
                        borderColor: AppColorsPalette.gray200,
                        borderWidth: 1,
                        textColor: AppColorsPalette.black,
                        textStyle: AppTypography.semiBold.copyWith(
                          fontSize: 14,
                          color: AppColorsPalette.black,
                        ),
                        onPressed: () {
                          Navigator.of(sheetContext).pop();
                          onSecondaryTap?.call();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// "Delete originals?" bottom sheet during Vault Import
  static Future<void> showDeleteOriginalsBottomSheet({
    required BuildContext context,
    required VoidCallback onImportAndDelete,
    required VoidCallback onImportOnly,
  }) {
    final l10n = context.l10n;
    return showConfirmBottomSheet(
      context: context,
      icon: Icons.delete_outline_rounded,
      title: l10n.deleteOriginalsDialogTitle,
      description: l10n.deleteOriginalsDialogDesc,
      primaryButtonText: l10n.importAndDeleteOriginalsButton,
      secondaryButtonText: l10n.importOnlyButton,
      onPrimaryTap: onImportAndDelete,
      onSecondaryTap: onImportOnly,
    );
  }

  /// "Restore to gallery?" bottom sheet in Vault Media Viewer
  static Future<void> showRestoreToGalleryBottomSheet({
    required BuildContext context,
    required VoidCallback onRestore,
  }) {
    final l10n = context.l10n;
    return showConfirmBottomSheet(
      context: context,
      icon: Icons.restore_rounded,
      title: l10n.restoreToGalleryDialogTitle,
      description: l10n.restoreToGalleryDialogDesc,
      primaryButtonText: l10n.restoreAction,
      secondaryButtonText: l10n.cancelButton,
      onPrimaryTap: onRestore,
    );
  }

  /// "Delete from Vault?" bottom sheet in Vault Media Viewer
  static Future<void> showDeleteFromVaultBottomSheet({
    required BuildContext context,
    required VoidCallback onDelete,
  }) {
    final l10n = context.l10n;
    return showConfirmBottomSheet(
      context: context,
      icon: Icons.delete_outline_rounded,
      title: l10n.deleteFromVaultDialogTitle,
      description: l10n.deleteFromVaultDialogDesc,
      primaryButtonText: l10n.deletePermanentlyButton,
      secondaryButtonText: l10n.cancelButton,
      onPrimaryTap: onDelete,
    );
  }

  /// "Delete alert?" bottom sheet in Intruder Alert Detail
  static Future<void> showDeleteAlertBottomSheet({
    required BuildContext context,
    required VoidCallback onDelete,
  }) {
    final l10n = context.l10n;
    return showConfirmBottomSheet(
      context: context,
      icon: Icons.delete_outline_rounded,
      title: l10n.deleteAlertDialogTitle,
      description: l10n.deleteAlertDialogDesc,
      primaryButtonText: l10n.deleteAlertButton,
      secondaryButtonText: l10n.cancelButton,
      onPrimaryTap: onDelete,
    );
  }
}
