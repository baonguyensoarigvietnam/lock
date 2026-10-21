import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/paywall/view_model/paywall_state.dart';
import 'package:applock/service/purchase/purchase_service.dart';
import 'package:applock/utility/helper/nullable.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class PaywallViewModel extends BaseCubit<PaywallState> {
  PaywallViewModel(this._purchaseService) : super(const PaywallState());

  final PurchaseService _purchaseService;

  StreamSubscription<PurchaseEvent>? _eventSubscription;
  StreamSubscription<bool>? _premiumSubscription;

  /// Subscribes to store updates and loads the Premium products.
  Future<void> init() async {
    _purchaseService.initialize();
    _eventSubscription ??=
        _purchaseService.purchaseEvents.listen(_onPurchaseEvent);
    _premiumSubscription ??= _purchaseService.premiumStream.listen((value) {
      if (value && state.isPurchasing) {
        _safeEmit(state.copyWith(isPurchasing: false, isPurchased: true));
      }
    });
    await loadProducts();
  }

  Future<void> loadProducts() async {
    _safeEmit(state.copyWith(isLoadingProducts: true));
    final result = await _purchaseService.queryProducts();
    switch (result) {
      case Success(data: final products):
        final byPlan = {
          for (final plan in SubscriptionPlanType.values)
            for (final product in products)
              if (product.id == plan.productId) plan: product,
        };
        _safeEmit(state.copyWith(
          products: byPlan,
          isLoadingProducts: false,
          isStoreAvailable: true,
        ));
      case Error(error: final error):
        final isUnavailable = error is PurchaseUnavailableException;
        _safeEmit(state.copyWith(
          isLoadingProducts: false,
          isStoreAvailable: !isUnavailable,
          // Billing unavailable is shown inline on the paywall.
          message: isUnavailable
              ? null
              : const Nullable(PaywallMessage.productsNotFound),
        ));
    }
  }

  void selectPlan(SubscriptionPlanType plan) {
    emit(state.copyWith(selectedPlan: plan));
  }

  Future<void> startPremium() async {
    if (state.isPurchasing || state.isRestoring) return;
    if (!state.isStoreAvailable) {
      _showMessage(PaywallMessage.billingUnavailable);
      return;
    }
    final product = state.productFor(state.selectedPlan);
    if (product == null) {
      _showMessage(
        state.isLoadingProducts
            ? PaywallMessage.productsLoading
            : PaywallMessage.productsNotFound,
      );
      return;
    }

    _safeEmit(state.copyWith(isPurchasing: true));
    final result = await _purchaseService.buy(product);
    switch (result) {
      case Success(data: final started):
        if (!started) {
          _safeEmit(state.copyWith(
            isPurchasing: false,
            message: const Nullable(PaywallMessage.purchaseFailed),
          ));
        }
      // Otherwise the outcome arrives through the purchase stream.
      case Error():
        _safeEmit(state.copyWith(
          isPurchasing: false,
          message: const Nullable(PaywallMessage.purchaseFailed),
        ));
    }
  }

  Future<void> restorePurchases() async {
    if (state.isPurchasing || state.isRestoring) return;
    _safeEmit(state.copyWith(isRestoring: true));
    final result = await _purchaseService.restorePurchases();
    switch (result) {
      case Success(data: final isPremium):
        _safeEmit(state.copyWith(
          isRestoring: false,
          isPurchased: isPremium ? true : null,
          message: Nullable(
            isPremium
                ? PaywallMessage.restoreSuccess
                : PaywallMessage.restoreNothing,
          ),
        ));
      case Error(error: final error):
        _safeEmit(state.copyWith(
          isRestoring: false,
          message: Nullable(
            error is PurchaseUnavailableException
                ? PaywallMessage.billingUnavailable
                : PaywallMessage.restoreFailed,
          ),
        ));
    }
  }

  /// Called by the UI once the current [PaywallState.message] was displayed.
  void clearMessage() {
    _safeEmit(state.copyWith(message: const Nullable(null)));
  }

  void _onPurchaseEvent(PurchaseEvent event) {
    if (!event.isPremiumProduct) return;
    switch (event.type) {
      case PurchaseEventType.purchased:
        _safeEmit(state.copyWith(isPurchasing: false, isPurchased: true));
      case PurchaseEventType.restored:
        // Restores are reported by [restorePurchases]; only finish an
        // ongoing purchase flow here (e.g. "item already owned").
        if (state.isPurchasing) {
          _safeEmit(state.copyWith(isPurchasing: false, isPurchased: true));
        }
      case PurchaseEventType.pending:
        _safeEmit(state.copyWith(
          isPurchasing: false,
          message: const Nullable(PaywallMessage.purchasePending),
        ));
      case PurchaseEventType.error:
        _safeEmit(state.copyWith(
          isPurchasing: false,
          message: const Nullable(PaywallMessage.purchaseFailed),
        ));
      case PurchaseEventType.canceled:
        _safeEmit(state.copyWith(isPurchasing: false));
    }
  }

  void _showMessage(PaywallMessage message) {
    _safeEmit(state.copyWith(message: Nullable(message)));
  }

  void _safeEmit(PaywallState newState) {
    if (isClosed) return;
    emit(newState);
  }

  @override
  Future<void> close() async {
    await _eventSubscription?.cancel();
    await _premiumSubscription?.cancel();
    return super.close();
  }
}
