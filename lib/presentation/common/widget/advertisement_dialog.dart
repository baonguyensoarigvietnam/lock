import 'package:flutter/material.dart';
import 'package:applock/domain/model/advertisement.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

/// Callback signature for ad interaction events.
typedef OnAdAction = void Function(AdEvent event, Advertisement advertisement);

/// Content widget for the cross-promotion ad dialog.
class AdvertisementDialog extends StatelessWidget {
  const AdvertisementDialog({
    super.key,
    required this.advertisement,
    this.onAction,
  });

  final Advertisement advertisement;
  final OnAdAction? onAction;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 392),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColorsPalette.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColorsPalette.black.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => _handleAction(context, AdEvent.skip),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColorsPalette.gray100,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: AppColorsPalette.gray600,
                  ),
                ),
              ),
            ),
            if (advertisement.headline.isNotEmpty) ...[
              Text(
                advertisement.headline,
                style: AppTypography.bold.copyWith(
                  fontSize: 16,
                  color: AppColorsPalette.slate900,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 14),
            GestureDetector(
              onTap: () => _handleAction(context, AdEvent.click),
              child: _AdPromotionImage(imageUrl: advertisement.imageUrl),
            ),
            const SizedBox(height: 20),
            CommonButton.filled(
              height: 48,
              cornerRadius: 14,
              width: double.infinity,
              backgroundColor: AppColorsPalette.black,
              text: context.l10n.dialogAdvertisementDownload,
              textStyle: AppTypography.semiBold.copyWith(
                fontSize: 15,
                color: AppColorsPalette.white,
              ),
              onPressed: () => _handleAction(context, AdEvent.click),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAction(BuildContext context, AdEvent event) {
    onAction?.call(event, advertisement);
    Navigator.of(context, rootNavigator: true).pop();
  }
}

/// Ad image container with smooth rounded corners, loading progress, and error state.
class _AdPromotionImage extends StatelessWidget {
  const _AdPromotionImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        decoration: BoxDecoration(
          color: AppColorsPalette.gray100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColorsPalette.gray200, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: AppColorsPalette.gray100,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColorsPalette.black,
                    strokeWidth: 2.5,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppColorsPalette.gray100,
              child: const Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 44,
                  color: AppColorsPalette.gray400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
