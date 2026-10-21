import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

enum SubscriptionPlanType { monthly, yearly }

class PaywallState extends BaseState {
  final SubscriptionPlanType selectedPlan;
  final bool isPurchased;

  const PaywallState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.selectedPlan = SubscriptionPlanType.yearly,
    this.isPurchased = false,
  });

  @override
  PaywallState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    SubscriptionPlanType? selectedPlan,
    bool? isPurchased,
  }) {
    return PaywallState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
      selectedPlan: selectedPlan ?? this.selectedPlan,
      isPurchased: isPurchased ?? this.isPurchased,
    );
  }
}
