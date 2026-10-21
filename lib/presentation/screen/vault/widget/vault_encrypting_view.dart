import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

/// Shows real progress while picked files are being encrypted.
class VaultEncryptingView extends StatelessWidget {
  final int totalFiles;
  final int processedFiles;

  const VaultEncryptingView({
    super.key,
    required this.totalFiles,
    required this.processedFiles,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final progress = totalFiles > 0 ? (processedFiles / totalFiles) : 0.0;

    return PopScope(
      canPop: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.encryptingItemsTitle,
                textAlign: TextAlign.center,
                style: AppTypography.bold.copyWith(
                  fontSize: 19,
                  color: AppColorsPalette.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.filesProcessedProgress(processedFiles, totalFiles),
                textAlign: TextAlign.center,
                style: AppTypography.regular.copyWith(
                  fontSize: 14,
                  color: AppColorsPalette.gray500,
                ),
              ),
              const SizedBox(height: 22),
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SizedBox(
                  height: 6,
                  width: double.infinity,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(end: progress),
                    duration: const Duration(milliseconds: 250),
                    builder: (context, value, _) => LinearProgressIndicator(
                      value: value,
                      backgroundColor: AppColorsPalette.gray100,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColorsPalette.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              // Info Pill Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColorsPalette.gray50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColorsPalette.gray200,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                      color: AppColorsPalette.black,
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        l10n.keepAppOpenWarning,
                        style: AppTypography.regular.copyWith(
                          fontSize: 13,
                          color: AppColorsPalette.gray600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
