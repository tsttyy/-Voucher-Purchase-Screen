import '../../domain/entities/payment_method.dart';
import '../../domain/entities/voucher.dart';

class VoucherState {
  final double amount;
  final int quantity;
  final PaymentMethod selectedPaymentMethod;
  final double discountPercent;
  final double youPay;
  final double savings;
  final bool isValidAmount;
  final bool isPurchaseDisabled;
  final Voucher? voucher;
  final bool isLoading;
  final String? error;

  const VoucherState({
    this.amount = 0.0,
    this.quantity = 1,
    this.selectedPaymentMethod = PaymentMethod.creditCard,
    this.discountPercent = 0.0,
    this.youPay = 0.0,
    this.savings = 0.0,
    this.isValidAmount = false,
    this.isPurchaseDisabled = true,
    this.voucher,
    this.isLoading = false,
    this.error,
  });

  VoucherState copyWith({
    double? amount,
    int? quantity,
    PaymentMethod? selectedPaymentMethod,
    double? discountPercent,
    double? youPay,
    double? savings,
    bool? isValidAmount,
    bool? isPurchaseDisabled,
    Voucher? voucher,
    bool? isLoading,
    String? error,
  }) {
    return VoucherState(
      amount: amount ?? this.amount,
      quantity: quantity ?? this.quantity,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      discountPercent: discountPercent ?? this.discountPercent,
      youPay: youPay ?? this.youPay,
      savings: savings ?? this.savings,
      isValidAmount: isValidAmount ?? this.isValidAmount,
      isPurchaseDisabled: isPurchaseDisabled ?? this.isPurchaseDisabled,
      voucher: voucher ?? this.voucher,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VoucherState &&
        other.amount == amount &&
        other.quantity == quantity &&
        other.selectedPaymentMethod == selectedPaymentMethod &&
        other.discountPercent == discountPercent &&
        other.youPay == youPay &&
        other.savings == savings &&
        other.isValidAmount == isValidAmount &&
        other.isPurchaseDisabled == isPurchaseDisabled &&
        other.voucher == voucher &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode {
    return Object.hash(
      amount,
      quantity,
      selectedPaymentMethod,
      discountPercent,
      youPay,
      savings,
      isValidAmount,
      isPurchaseDisabled,
      voucher,
      isLoading,
      error,
    );
  }

  @override
  String toString() {
    return 'VoucherState('
        'amount: $amount, '
        'quantity: $quantity, '
        'selectedPaymentMethod: $selectedPaymentMethod, '
        'discountPercent: $discountPercent, '
        'youPay: $youPay, '
        'savings: $savings, '
        'isValidAmount: $isValidAmount, '
        'isPurchaseDisabled: $isPurchaseDisabled, '
        'voucher: $voucher, '
        'isLoading: $isLoading, '
        'error: $error)';
  }
}
