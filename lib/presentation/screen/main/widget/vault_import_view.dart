import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/dialog_utility.dart';

class VaultImportView extends StatefulWidget {
  final int initialTabIndex;
  final VoidCallback onBack;
  final ValueChanged<int> onImportAndDelete;
  final ValueChanged<int> onImportOnly;

  const VaultImportView({
    super.key,
    this.initialTabIndex = 0,
    required this.onBack,
    required this.onImportAndDelete,
    required this.onImportOnly,
  });

  @override
  State<VaultImportView> createState() => _VaultImportViewState();
}

class _VaultImportViewState extends State<VaultImportView> {
  late int _selectedTabIndex;
  final Set<int> _selectedIndices = {0, 2, 3, 7, 11};

  static const int _todayCount = 15;
  static const int _septemberCount = 6;

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = widget.initialTabIndex;
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  void _selectAllRange(int start, int count) {
    setState(() {
      final range = List.generate(count, (i) => start + i);
      final allSelected = range.every(_selectedIndices.contains);
      if (allSelected) {
        _selectedIndices.removeAll(range);
      } else {
        _selectedIndices.addAll(range);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = _selectedIndices.length;
    final totalSizeMb = (selectedCount * 2.84).toStringAsFixed(1);

    return Column(
      children: [
        // Top Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColorsPalette.black,
                  size: 22,
                ),
                onPressed: widget.onBack,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Import to Vault',
                    style: AppTypography.bold.copyWith(
                      fontSize: 17,
                      color: AppColorsPalette.black,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.select_all_rounded,
                  color: AppColorsPalette.black,
                  size: 22,
                ),
                onPressed: () =>
                    _selectAllRange(0, _todayCount + _septemberCount),
              ),
            ],
          ),
        ),

        // Photos / Videos Tab Bar
        Container(
          color: AppColorsPalette.gray50,
          child: Row(
            children: [
              _buildMediaTypeTab(label: 'Photos', index: 0),
              _buildMediaTypeTab(label: 'Videos', index: 1),
            ],
          ),
        ),

        // Scrollable Media Grid
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Today Section Header
                _buildSectionHeader(
                  title: 'Today',
                  onSelectAll: () => _selectAllRange(0, _todayCount),
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _todayCount,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return _buildSelectableMediaTile(index);
                  },
                ),
                const SizedBox(height: 16),

                // September 12 Section Header
                _buildSectionHeader(
                  title: 'September 12',
                  onSelectAll: () =>
                      _selectAllRange(_todayCount, _septemberCount),
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _septemberCount,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return _buildSelectableMediaTile(_todayCount + index);
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),

        // Bottom Selection Action Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: const BoxDecoration(
            color: AppColorsPalette.white,
            border: Border(
              top: BorderSide(
                color: AppColorsPalette.gray200,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$selectedCount selected',
                    style: AppTypography.bold.copyWith(
                      fontSize: 15,
                      color: AppColorsPalette.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$totalSizeMb MB total',
                    style: AppTypography.regular.copyWith(
                      fontSize: 12,
                      color: AppColorsPalette.gray500,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: selectedCount > 0
                    ? () {
                        DialogUtility.showDeleteOriginalsBottomSheet(
                          context: context,
                          onImportAndDelete: () =>
                              widget.onImportAndDelete(selectedCount),
                          onImportOnly: () =>
                              widget.onImportOnly(selectedCount),
                        );
                      }
                    : null,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 46,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: selectedCount > 0
                        ? AppColorsPalette.black
                        : AppColorsPalette.gray300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Move to Vault',
                        style: AppTypography.semiBold.copyWith(
                          fontSize: 14,
                          color: AppColorsPalette.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.lock_outline_rounded,
                        size: 16,
                        color: AppColorsPalette.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMediaTypeTab({required String label, required int index}) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? AppColorsPalette.black
                    : AppColorsPalette.gray200,
                width: isSelected ? 2 : 1,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: (isSelected ? AppTypography.bold : AppTypography.semiBold)
                .copyWith(
              fontSize: 14,
              color: isSelected
                  ? AppColorsPalette.black
                  : AppColorsPalette.gray500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onSelectAll,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColorsPalette.gray50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTypography.bold.copyWith(
              fontSize: 16,
              color: AppColorsPalette.black,
            ),
          ),
          GestureDetector(
            onTap: onSelectAll,
            behavior: HitTestBehavior.opaque,
            child: Text(
              'Select All',
              style: AppTypography.medium.copyWith(
                fontSize: 12,
                color: AppColorsPalette.gray500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectableMediaTile(int index) {
    final isSelected = _selectedIndices.contains(index);
    final isTopFeatured = index < 3;

    return GestureDetector(
      onTap: () => _toggleSelection(index),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isTopFeatured
                ? [
                    const Color(0xFF4B5563),
                    const Color(0xFF9CA3AF),
                    const Color(0xFF374151),
                  ]
                : [
                    const Color(0xFFC8CCD2),
                    const Color(0xFFECEEF1),
                    const Color(0xFFF3F4F6),
                  ],
          ),
          border: Border.all(
            color: AppColorsPalette.gray200,
            width: 0.8,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                _selectedTabIndex == 1
                    ? Icons.play_circle_outline_rounded
                    : (isTopFeatured
                        ? Icons.architecture_rounded
                        : Icons.image_outlined),
                color: isTopFeatured
                    ? AppColorsPalette.white.withValues(alpha: 0.3)
                    : AppColorsPalette.gray300,
                size: 26,
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColorsPalette.black
                      : AppColorsPalette.gray400.withValues(alpha: 0.65),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? AppColorsPalette.white
                        : AppColorsPalette.gray300,
                    width: 1.4,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 13,
                        color: AppColorsPalette.white,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
