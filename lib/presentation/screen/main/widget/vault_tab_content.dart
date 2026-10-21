import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class VaultTabContent extends StatelessWidget {
  const VaultTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      appBar: AppBar(
        backgroundColor: AppColorsPalette.white,
        elevation: 0,
        title: Text(
          'Encrypted Vault',
          style: AppTypography.bold.copyWith(
            fontSize: 20,
            color: AppColorsPalette.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vault summary card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColorsPalette.black,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.lock_rounded,
                        color: AppColorsPalette.white,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '72 Protected Items',
                            style: AppTypography.bold.copyWith(
                              fontSize: 17,
                              color: AppColorsPalette.black,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'AES-256 encrypted & hidden from gallery',
                            style: AppTypography.regular.copyWith(
                              fontSize: 12.5,
                              color: AppColorsPalette.gray600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Categories',
                style: AppTypography.bold.copyWith(
                  fontSize: 17,
                  color: AppColorsPalette.black,
                ),
              ),
              const SizedBox(height: 14),
              _buildCategoryTile(
                icon: Icons.photo_library_outlined,
                title: 'Photos',
                count: '48 items',
              ),
              const SizedBox(height: 12),
              _buildCategoryTile(
                icon: Icons.video_library_outlined,
                title: 'Videos',
                count: '16 items',
              ),
              const SizedBox(height: 12),
              _buildCategoryTile(
                icon: Icons.insert_drive_file_outlined,
                title: 'Files & Documents',
                count: '8 items',
              ),
              const SizedBox(height: 12),
              _buildCategoryTile(
                icon: Icons.note_outlined,
                title: 'Secure Notes',
                count: '0 items',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTile({
    required IconData icon,
    required String title,
    required String count,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColorsPalette.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 22,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bold.copyWith(
                    fontSize: 15,
                    color: AppColorsPalette.black,
                  ),
                ),
                Text(
                  count,
                  style: AppTypography.regular.copyWith(
                    fontSize: 13,
                    color: AppColorsPalette.gray600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF9CA3AF),
            size: 20,
          ),
        ],
      ),
    );
  }
}
