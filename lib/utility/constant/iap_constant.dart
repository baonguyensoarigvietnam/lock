/// In-app purchase product identifiers.
///
/// IMPORTANT: The app owner MUST create products with exactly the same IDs in
/// Google Play Console (Monetize > Products > Subscriptions) before purchases
/// can work. Each subscription needs at least one active base plan
/// (e.g. a monthly auto-renewing base plan for [premiumMonthly] and a yearly
/// one for [premiumYearly]). The app must also be uploaded to a testing track
/// and the tester account added as a license tester.
abstract final class IapConstant {
  /// Auto-renewing monthly Premium subscription.
  static const String premiumMonthly = 'applock_premium_monthly';

  /// Auto-renewing yearly Premium subscription.
  static const String premiumYearly = 'applock_premium_yearly';

  /// Every product that grants the Premium entitlement.
  static const Set<String> premiumProductIds = {
    premiumMonthly,
    premiumYearly,
  };

  /// SharedPreferences key used to cache the Premium entitlement locally so it
  /// survives restarts and works offline.
  static const String premiumEntitlementKey = 'iap_premium_entitlement';
}
