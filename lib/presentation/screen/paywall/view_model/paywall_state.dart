import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/constant/iap_constant.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

enum SubscriptionPlanType {
  monthly(IapConstant.premiumMonthly),
  yearly(IapConstant.premiumYearly);

  const SubscriptionPlanType(this.productId);

  /// Store product ID backing this plan.
  final String productId;
}

/// One-shot messages shown to the user (mapped to l10n strings in the UI).
enum PaywallMessage {
  billingUnavailable,
  productsNotFound,
  productsLoading,
  purchaseFailed,
  purchasePending,
  restoreSuccess,
  restoreNothing,
  restoreFailed,
}

class PaywallState extends BaseState {
  final SubscriptionPlanType selectedPlan;
  final bool isPurchased;

  /// Store products keyed by plan. Empty while loading or when unavailable.
  final Map<SubscriptionPlanType, ProductDetails> products;
  final bool isLoadingProducts;
  final bool isStoreAvailable;
  final bool isPurchasing;
  final bool isRestoring;
  final PaywallMessage? message;

  const PaywallState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.selectedPlan = SubscriptionPlanType.yearly,
    this.isPurchased = false,
    this.products = const {},
    this.isLoadingProducts = false,
    this.isStoreAvailable = true,
    this.isPurchasing = false,
    this.isRestoring = false,
    this.message,
  });

  ProductDetails? productFor(SubscriptionPlanType plan) => products[plan];

  /// Yearly price if paid monthly for 12 months (null if unknown).
  double? get yearlyFullRawPrice {
    final monthly = products[SubscriptionPlanType.monthly];
    if (monthly == null) return null;
    return monthly.rawPrice * 12;
  }

  /// Savings in percent of yearly vs. 12 x monthly (null if unknown/none).
  int? get yearlySavingPercent {
    final full = yearlyFullRawPrice;
    final yearly = products[SubscriptionPlanType.yearly];
    if (full == null || yearly == null || full <= 0) return null;
    final percent = ((1 - yearly.rawPrice / full) * 100).round();
    return percent > 0 ? percent : null;
  }

  @override
  PaywallState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    SubscriptionPlanType? selectedPlan,
    bool? isPurchased,
    Map<SubscriptionPlanType, ProductDetails>? products,
    bool? isLoadingProducts,
    bool? isStoreAvailable,
    bool? isPurchasing,
    bool? isRestoring,
    Nullable<PaywallMessage>? message,
  }) {
    return PaywallState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
      selectedPlan: selectedPlan ?? this.selectedPlan,
      isPurchased: isPurchased ?? this.isPurchased,
      products: products ?? this.products,
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
      isStoreAvailable: isStoreAvailable ?? this.isStoreAvailable,
      isPurchasing: isPurchasing ?? this.isPurchasing,
      isRestoring: isRestoring ?? this.isRestoring,
      message: message != null ? message.value : this.message,
    );
  }
}
