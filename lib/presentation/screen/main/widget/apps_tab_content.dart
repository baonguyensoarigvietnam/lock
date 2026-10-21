import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/screen/home/view_model/home_state.dart';
import 'package:applock/presentation/screen/home/view_model/home_view_model.dart';
import 'package:applock/presentation/screen/home/widget/home_app_item_tile.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class AppsTabContent extends StatefulWidget {
  const AppsTabContent({super.key});

  @override
  State<AppsTabContent> createState() => _AppsTabContentState();
}

class _AppsTabContentState extends State<AppsTabContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      appBar: AppBar(
        backgroundColor: AppColorsPalette.white,
        elevation: 0,
        title: Text(
          'Lock Apps',
          style: AppTypography.bold.copyWith(
            fontSize: 20,
            color: AppColorsPalette.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<HomeViewModel, HomeState>(
          builder: (context, state) {
            return Column(
              children: [
                // Search & Filter Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (val) {
                              context.read<HomeViewModel>().search(val);
                            },
                            style: AppTypography.regular.copyWith(
                              fontSize: 14,
                              color: AppColorsPalette.black,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search apps...',
                              hintStyle: AppTypography.regular.copyWith(
                                color: AppColorsPalette.gray400,
                                fontSize: 14,
                              ),
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: AppColorsPalette.gray400,
                                size: 20,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          context
                              .read<HomeViewModel>()
                              .toggleOnlyLockedFilter();
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 46,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: state.onlyLockedFilter
                                ? AppColorsPalette.black
                                : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock_rounded,
                                size: 16,
                                color: state.onlyLockedFilter
                                    ? AppColorsPalette.white
                                    : AppColorsPalette.black,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${state.lockedCount}',
                                style: AppTypography.bold.copyWith(
                                  fontSize: 13,
                                  color: state.onlyLockedFilter
                                      ? AppColorsPalette.white
                                      : AppColorsPalette.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // App List
                Expanded(
                  child: state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColorsPalette.black,
                          ),
                        )
                      : state.filteredApps.isEmpty
                          ? Center(
                              child: Text(
                                'No apps found',
                                style: AppTypography.regular.copyWith(
                                  color: AppColorsPalette.gray500,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              itemCount: state.filteredApps.length,
                              itemBuilder: (context, index) {
                                final item = state.filteredApps[index];
                                return HomeAppItemTile(
                                  item: item,
                                  onToggle: (_) {
                                    context
                                        .read<HomeViewModel>()
                                        .toggleLock(item.packageName);
                                  },
                                );
                              },
                            ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
