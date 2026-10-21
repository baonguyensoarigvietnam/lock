import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:applock/utility/constant/iap_constant.dart';
import 'package:applock/utility/helper/result.dart';

/// Kind of update coming from the store for a single purchase.
enum PurchaseEventType { pending, purchased, restored, canceled, error }

/// A store purchase update, simplified for the presentation layer.
class PurchaseEvent {
  const PurchaseEvent({
    required this.type,
    this.productId,
    this.errorMessage,
  });

  final PurchaseEventType type;
  final String? productId;
  final String? errorMessage;

  /// True when the event belongs to a product granting Premium.
  bool get isPremiumProduct =>
      productId != null && IapConstant.premiumProductIds.contains(productId);
}

/// Thrown when the billing service is not reachable (no Play Store, not
/// signed in, unsupported device, ...).
class PurchaseUnavailableException implements Exception {
  const PurchaseUnavailableException();

  @override
  String toString() => 'PurchaseUnavailableException';
}

/// Thrown when none of the configured product IDs exist in the store.
class PurchaseProductNotFoundException implements Exception {
  const PurchaseProductNotFoundException();

  @override
  String toString() => 'PurchaseProductNotFoundException';
}

/// Wrapper around [InAppPurchase] (Google Play Billing / StoreKit).
///
/// Responsibilities:
/// - query Premium products,
/// - launch purchase / restore flows,
/// - listen to [InAppPurchase.purchaseStream], acknowledge purchases
///   (`completePurchase`) and persist the Premium entitlement locally so it
///   survives restarts and works offline.
///
/// NOTE: There is no backend, so purchases are only verified locally.
/// Server-side receipt verification (Google Play Developer API
/// `purchases.subscriptionsv2.get`) is strongly recommended for production to
/// prevent tampering and to accurately track renewals/cancellations.
@lazySingleton
class PurchaseService {
  PurchaseService(this._preferences);

  final SharedPreferences _preferences;

  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;
  final StreamController<bool> _premiumController =
      StreamController<bool>.broadcast();
  final StreamController<PurchaseEvent> _eventController =
      StreamController<PurchaseEvent>.broadcast();
  final StreamController<List<PurchaseDetails>> _batchController =
      StreamController<List<PurchaseDetails>>.broadcast();

  InAppPurchase get _iap => InAppPurchase.instance;

  /// Locally cached Premium entitlement.
  bool get isPremium =>
      _preferences.getBool(IapConstant.premiumEntitlementKey) ?? false;

  /// Emits every time the Premium entitlement changes.
  Stream<bool> get premiumStream => _premiumController.stream;

  /// Emits store purchase updates (pending, purchased, error, ...).
  Stream<PurchaseEvent> get purchaseEvents => _eventController.stream;

  /// Starts listening to the store purchase stream. Safe to call many times.
  /// Should be called as early as possible so purchases completed while the
  /// app was closed are delivered and acknowledged.
  void initialize() {
    if (_purchaseSubscription != null) return;
    try {
      _purchaseSubscription = _iap.purchaseStream.listen(
        _onPurchasesUpdated,
        onError: (Object error) {
          _eventController.add(
            PurchaseEvent(
              type: PurchaseEventType.error,
              errorMessage: error.toString(),
            ),
          );
        },
      );
    } catch (_) {
      // Billing plugin unavailable on this platform (e.g. tests/desktop).
      _purchaseSubscription = null;
    }
  }

  /// Whether the store/billing service can be reached.
  Future<bool> isAvailable() async {
    try {
      return await _iap.isAvailable();
    } catch (_) {
      return false;
    }
  }

  /// Loads the Premium products from the store, one [ProductDetails] per
  /// product ID.
  Future<Result<List<ProductDetails>>> queryProducts() async {
    if (!await isAvailable()) {
      return Result.error(const PurchaseUnavailableException());
    }
    try {
      final response =
          await _iap.queryProductDetails(IapConstant.premiumProductIds);
      final byId = <String, ProductDetails>{};
      for (final product in response.productDetails) {
        final existing = byId[product.id];
        // Google Play returns one ProductDetails per subscription offer. The
        // base plan has the full price as first pricing phase, whereas
        // promotional offers (free trial / intro price) are cheaper, so keep
        // the highest one to display/buy the regular base plan.
        if (existing == null || product.rawPrice > existing.rawPrice) {
          byId[product.id] = product;
        }
      }
      if (byId.isEmpty) {
        final error = response.error;
        return Result.error(
          error != null
              ? Exception(error.message)
              : const PurchaseProductNotFoundException(),
        );
      }
      return Result.success(byId.values.toList());
    } catch (e) {
      return Result.error(e);
    }
  }

  /// Launches the store purchase flow. Subscriptions and lifetime products are
  /// both bought as non-consumables. The final outcome is delivered through
  /// [purchaseEvents] / [premiumStream]. Returns whether the flow started.
  Future<Result<bool>> buy(ProductDetails product) async {
    initialize();
    try {
      final started = await _iap.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: product),
      );
      return Result.success(started);
    } catch (e) {
      return Result.error(e);
    }
  }

  /// Asks the store for previously bought products and re-syncs the local
  /// entitlement. Returns the Premium entitlement after restoring.
  ///
  /// If the store answers with a restore batch that contains no Premium
  /// product (e.g. subscription expired or refunded), the local entitlement
  /// is revoked.
  Future<Result<bool>> restorePurchases({
    Duration timeout = const Duration(seconds: 10),
  }) async {
    initialize();
    if (!await isAvailable()) {
      return Result.error(const PurchaseUnavailableException());
    }
    try {
      final batchFuture = _batchController.stream.first
          .then<List<PurchaseDetails>?>((batch) => batch)
          .timeout(timeout, onTimeout: () => null);
      await _iap.restorePurchases();
      final batch = await batchFuture;
      if (batch != null) {
        final isRestoreBatch =
            batch.every((p) => p.status == PurchaseStatus.restored);
        final hasPremium = batch.any(
          (p) =>
              IapConstant.premiumProductIds.contains(p.productID) &&
              (p.status == PurchaseStatus.restored ||
                  p.status == PurchaseStatus.purchased),
        );
        if (isRestoreBatch && !hasPremium) {
          await _setPremium(false);
        }
      }
      return Result.success(isPremium);
    } catch (e) {
      return Result.error(e);
    }
  }

  /// Silently re-syncs the entitlement with the store. Keeps the cached value
  /// when the store is unreachable (offline).
  Future<bool> refreshEntitlement() async {
    final result = await restorePurchases();
    return switch (result) {
      Success(data: final data) => data,
      Error() => isPremium,
    };
  }

  Future<void> _onPurchasesUpdated(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          _emitEvent(PurchaseEventType.pending, purchase);
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          if (_verifyPurchaseLocally(purchase)) {
            await _setPremium(true);
          }
          _emitEvent(
            purchase.status == PurchaseStatus.purchased
                ? PurchaseEventType.purchased
                : PurchaseEventType.restored,
            purchase,
          );
        case PurchaseStatus.error:
          _emitEvent(
            PurchaseEventType.error,
            purchase,
            errorMessage: purchase.error?.message,
          );
        case PurchaseStatus.canceled:
          _emitEvent(PurchaseEventType.canceled, purchase);
      }

      // Always acknowledge, otherwise Google Play refunds the purchase after
      // 3 days.
      if (purchase.pendingCompletePurchase) {
        try {
          await _iap.completePurchase(purchase);
        } catch (_) {
          // Will be retried the next time the purchase is delivered.
        }
      }
    }
    _batchController.add(purchases);
  }

  /// Local-only verification. Replace with a server-side check when a backend
  /// is available.
  bool _verifyPurchaseLocally(PurchaseDetails purchase) {
    return IapConstant.premiumProductIds.contains(purchase.productID) &&
        purchase.verificationData.serverVerificationData.isNotEmpty;
  }

  Future<void> _setPremium(bool value) async {
    final changed = isPremium != value;
    await _preferences.setBool(IapConstant.premiumEntitlementKey, value);
    if (changed) {
      _premiumController.add(value);
    }
  }

  void _emitEvent(
    PurchaseEventType type,
    PurchaseDetails purchase, {
    String? errorMessage,
  }) {
    _eventController.add(
      PurchaseEvent(
        type: type,
        productId: purchase.productID,
        errorMessage: errorMessage,
      ),
    );
  }

  @disposeMethod
  Future<void> dispose() async {
    await _purchaseSubscription?.cancel();
    _purchaseSubscription = null;
    await _premiumController.close();
    await _eventController.close();
    await _batchController.close();
  }
}
