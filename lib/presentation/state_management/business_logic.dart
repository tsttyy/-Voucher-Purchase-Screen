import 'voucher_state.dart';

/// Business Logic Utilities
/// These compute derived values from the voucher state and voucher data
/// Following the formula: discountAmount = amount * percent / 100

class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  const ValidationResult({required this.isValid, this.errorMessage});
}

class BusinessLogic {
  /// Gets the current discount percentage based on voucher data
  static double getCurrentDiscountPercent(VoucherState state) {
    return state.discountPercent;
  }

  /// Calculates discount amount based on amount and discount percent
  static double getDiscountAmount(VoucherState state) {
    if (state.amount <= 0) return 0;
    return (state.amount * state.discountPercent) / 100;
  }

  /// Calculates final payable amount: (amount - discount) * quantity
  static double getPayableAmount(VoucherState state) {
    if (state.amount <= 0) return 0;
    final discountAmount = getDiscountAmount(state);
    final amountAfterDiscount = state.amount - discountAmount;
    return amountAfterDiscount * state.quantity;
  }

  /// Calculates total savings: discountAmount * quantity
  static double getSavings(VoucherState state) {
    final discountAmount = getDiscountAmount(state);
    return discountAmount * state.quantity;
  }

  /// Validates the amount field
  static ValidationResult validateAmount(VoucherState state) {
    if (state.amount == 0) {
      return const ValidationResult(isValid: false);
    }

    if (state.voucher != null) {
      final voucher = state.voucher!;
      if (state.amount < voucher.minAmount) {
        return ValidationResult(
          isValid: false,
          errorMessage: 'Min: ₹${voucher.minAmount.toStringAsFixed(0)}',
        );
      }

      if (state.amount > voucher.maxAmount) {
        return ValidationResult(
          isValid: false,
          errorMessage: 'Max: ₹${voucher.maxAmount.toStringAsFixed(0)}',
        );
      }
    }

    return const ValidationResult(isValid: true);
  }

  /// Determines if the pay button should be enabled
  static bool isPayButtonEnabled(VoucherState state) {
    final validation = validateAmount(state);

    // Disable if voucher purchase is disabled
    if (state.voucher?.disablePurchase == true) return false;

    // Disable if amount is invalid
    if (!validation.isValid) return false;

    // Disable if amount is zero
    if (state.amount == 0) return false;

    return true;
  }

  /// Provides formatted display string for pay button
  static String getPayButtonLabel(VoucherState state) {
    final payableAmount = getPayableAmount(state);
    return 'Pay ₹${payableAmount.toStringAsFixed(0)}';
  }
}
