import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/screen/vault/widget/vault_format_helper.dart';
import 'package:applock/presentation/screen/vault/widget/vault_viewer_bottom_bar.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class VaultVideoViewerView extends StatelessWidget {
  final String fileName;

  /// Path of the temporary decrypted copy, or `null` while decrypting.
  final String? videoPath;
  final bool isLoading;
  final VoidCallback onBack;
  final VoidCallback onDeleteConfirmed;
  final VoidCallback onInfo;

  /// Called when the player is disposed so the temporary file is deleted.
  final ValueChanged<String> onReleaseTempFile;

  const VaultVideoViewerView({
    super.key,
    required this.fileName,
    required this.videoPath,
    required this.isLoading,
    required this.onBack,
    required this.onDeleteConfirmed,
    required this.onInfo,
    required this.onReleaseTempFile,
  });

  @override
  Widget build(BuildContext context) {
    final path = videoPath;
    return Column(
      children: [
        CommonAppBar.titledBack(
          onBack: onBack,
          title: fileName,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Center(
              child: path != null
                  ? _VaultVideoPlayer(
                      key: ValueKey(path),
                      path: path,
                      onDispose: onReleaseTempFile,
                    )
                  : _buildPlaceholder(context),
            ),
          ),
        ),

        // Bottom Action Toolbar (Delete | Info)
        VaultViewerBottomBar(
          onDeleteConfirmed: onDeleteConfirmed,
          onInfo: onInfo,
        ),
      ],
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 215,
      decoration: BoxDecoration(
        color: AppColorsPalette.gray800,
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: isLoading
          ? const CircularProgressIndicator(color: AppColorsPalette.white)
          : Text(
              context.l10n.vaultPreviewUnavailable,
              style: AppTypography.medium.copyWith(
                fontSize: 13,
                color: AppColorsPalette.gray300,
              ),
            ),
    );
  }
}

class _VaultVideoPlayer extends StatefulWidget {
  final String path;
  final ValueChanged<String> onDispose;

  const _VaultVideoPlayer({
    super.key,
    required this.path,
    required this.onDispose,
  });

  @override
  State<_VaultVideoPlayer> createState() => _VaultVideoPlayerState();
}

class _VaultVideoPlayerState extends State<_VaultVideoPlayer> {
  late final VideoPlayerController _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path));
    _controller.initialize().then((_) {
      if (mounted) setState(() {});
    }).catchError((Object _) {
      if (mounted) setState(() => _hasError = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.onDispose(widget.path);
    super.dispose();
  }

  void _togglePlay() {
    final value = _controller.value;
    if (!value.isInitialized) return;
    if (value.isPlaying) {
      _controller.pause();
    } else {
      if (value.position >= value.duration) {
        _controller.seekTo(Duration.zero);
      }
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        if (_hasError || value.hasError) {
          return _buildFrame(
            child: Text(
              context.l10n.vaultPreviewUnavailable,
              style: AppTypography.medium.copyWith(
                fontSize: 13,
                color: AppColorsPalette.gray300,
              ),
            ),
          );
        }
        if (!value.isInitialized) {
          return _buildFrame(
            child: const CircularProgressIndicator(
              color: AppColorsPalette.white,
            ),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: value.aspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(color: AppColorsPalette.black),
                      VideoPlayer(_controller),
                      GestureDetector(
                        onTap: _togglePlay,
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: AnimatedOpacity(
                            opacity: value.isPlaying ? 0 : 1,
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              width: 68,
                              height: 68,
                              decoration: const BoxDecoration(
                                color: AppColorsPalette.gray200,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                value.isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                size: 38,
                                color: AppColorsPalette.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            // Scrubber & Timestamps
            Row(
              children: [
                GestureDetector(
                  onTap: _togglePlay,
                  child: Icon(
                    value.isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    size: 26,
                    color: AppColorsPalette.black,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColorsPalette.gray200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    VaultFormatHelper.duration(value.position),
                    style: AppTypography.semiBold.copyWith(
                      fontSize: 11.5,
                      color: AppColorsPalette.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      colors: const VideoProgressColors(
                        playedColor: AppColorsPalette.black,
                        bufferedColor: AppColorsPalette.gray300,
                        backgroundColor: AppColorsPalette.gray200,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  VaultFormatHelper.duration(value.duration),
                  style: AppTypography.medium.copyWith(
                    fontSize: 11.5,
                    color: AppColorsPalette.gray500,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildFrame({required Widget child}) {
    return Container(
      width: double.infinity,
      height: 215,
      decoration: BoxDecoration(
        color: AppColorsPalette.gray800,
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
