import 'dart:async';
import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class VaultEncryptingView extends StatefulWidget {
  final int totalFiles;
  final VoidCallback onComplete;

  const VaultEncryptingView({
    super.key,
    this.totalFiles = 5,
    required this.onComplete,
  });

  @override
  State<VaultEncryptingView> createState() => _VaultEncryptingViewState();
}

class _VaultEncryptingViewState extends State<VaultEncryptingView> {
  late int _processedCount;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _processedCount = (widget.totalFiles * 0.6).round().clamp(1, widget.totalFiles);
    _timer = Timer(const Duration(milliseconds: 1600), () {
      if (mounted) {
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        widget.totalFiles > 0 ? (_processedCount / widget.totalFiles) : 0.6;

    return GestureDetector(
      onTap: widget.onComplete,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Encrypting selected items...',
                textAlign: TextAlign.center,
                style: AppTypography.bold.copyWith(
                  fontSize: 19,
                  color: AppColorsPalette.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$_processedCount of ${widget.totalFiles} files processed',
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
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColorsPalette.gray100,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColorsPalette.black,
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
                        'Keep App Lock open until import finishes.',
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
