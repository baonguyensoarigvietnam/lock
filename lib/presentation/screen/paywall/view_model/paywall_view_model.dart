import 'package:injectable/injectable.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/paywall/view_model/paywall_state.dart';
import 'package:applock/utility/enumeration/view_status.dart';

@injectable
class PaywallViewModel extends BaseCubit<PaywallState> {
  PaywallViewModel() : super(const PaywallState());

  void selectPlan(SubscriptionPlanType plan) {
    emit(state.copyWith(selectedPlan: plan));
  }

  Future<void> startPremium() async {
    emit(state.copyWith(status: ViewStatus.loading));
    await Future.delayed(const Duration(milliseconds: 1200));
    emit(state.copyWith(
      status: ViewStatus.success,
      isPurchased: true,
    ));
  }

  Future<void> restorePurchases() async {
    emit(state.copyWith(status: ViewStatus.loading));
    await Future.delayed(const Duration(milliseconds: 1000));
    emit(state.copyWith(
      status: ViewStatus.success,
    ));
  }
}
