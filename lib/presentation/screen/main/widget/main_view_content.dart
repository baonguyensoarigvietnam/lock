import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/application/view_model/global_view_model.dart';
import 'package:applock/application/view_model/global_view_model_state.dart';
import 'package:applock/domain/model/advertisement.dart';
import 'package:applock/presentation/common/widget/advertisement_dialog.dart';
import 'package:applock/presentation/screen/alerts/alerts_page.dart';
import 'package:applock/presentation/screen/apps/apps_page.dart';
import 'package:applock/presentation/screen/home/home_page.dart';
import 'package:applock/presentation/screen/main/view_model/main_state.dart';
import 'package:applock/presentation/screen/main/view_model/main_view_model.dart';
import 'package:applock/presentation/screen/main/widget/app_bottom_nav_bar.dart';
import 'package:applock/presentation/screen/settings/settings_page.dart';
import 'package:applock/presentation/screen/vault/vault_page.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/utility/dialog_utility.dart';
import 'package:applock/utility/url_launcher_utility.dart';

class MainViewContent extends StatefulWidget {
  const MainViewContent({super.key});

  @override
  State<MainViewContent> createState() => _MainViewContentState();
}

class _MainViewContentState extends State<MainViewContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<GlobalViewModel>().loadCrossPromotionAd();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GlobalViewModel, GlobalViewModelState>(
      listenWhen: (previous, current) =>
          previous.advertisement != current.advertisement &&
          current.advertisement != null &&
          !current.isPro,
      listener: (context, state) => _showAdDialog(context, state.advertisement!),
      child: BlocBuilder<MainViewModel, MainState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColorsPalette.white,
            body: IndexedStack(
              index: state.currentTabIndex,
              children: [
                HomePage(
                  onSelectTab: (index) {
                    context.read<MainViewModel>().setTab(index);
                  },
                ),
                const AppsPage(),
                const VaultPage(),
                const AlertsPage(),
                const SettingsPage(),
              ],
            ),
            bottomNavigationBar: AppBottomNavBar(
              currentIndex: state.currentTabIndex,
              onTap: (index) {
                context.read<MainViewModel>().setTab(index);
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _showAdDialog(
    BuildContext context,
    Advertisement advertisement,
  ) async {
    await DialogUtility.showGeneralModal(
      context: context,
      isTransparent: true,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 250),
      child: AdvertisementDialog(
        advertisement: advertisement,
        onAction: (event, ad) => _onAdAction(context, event, ad),
      ),
    );
    if (context.mounted) {
      context.read<GlobalViewModel>().clearAdvertisement();
    }
  }

  void _onAdAction(
    BuildContext context,
    AdEvent event,
    Advertisement advertisement,
  ) {
    context.read<GlobalViewModel>().sendAdEvent(
      targetAppId: advertisement.appId,
      event: event,
    );
    if (event == AdEvent.click && advertisement.storeUrl.isNotEmpty) {
      UrlLauncherUtility.openUrl(advertisement.storeUrl);
    }
  }
}
