import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/entities/voucher.dart';
import '../../domain/repositories/voucher_repository.dart';
import 'voucher_state.dart';

class VoucherNotifier extends StateNotifier<VoucherState> {
  final VoucherRepository _repository;

  VoucherNotifier(this._repository) : super(const VoucherState());

  Future<void> loadVoucher() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final voucher = await _repository.getVoucher();
      state = state.copyWith(
        voucher: voucher,
        isLoading: false,
        discountPercent: voucher.discount?.percent ?? 0.0,
      );
      _recalculateValues();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updateAmount(double amount) {
    state = state.copyWith(amount: amount);
    _recalculateValues();
  }

  void updateQuantity(int quantity) {
    state = state.copyWith(quantity: quantity);
    _recalculateValues();
  }

  void selectPaymentMethod(String method) {
    final paymentMethod = PaymentMethod.fromString(method);
    state = state.copyWith(selectedPaymentMethod: paymentMethod);
  }

  void _recalculateValues() {
    final voucher = state.voucher;
    if (voucher == null) return;

    // Calculate discount amount
    final discountAmount = state.amount * state.discountPercent / 100;

    // Calculate youPay and savings
    final youPay = (state.amount - discountAmount) * state.quantity;
    final savings = discountAmount * state.quantity;

    // Validate amount
    final isValidAmount = _validateAmount(state.amount, voucher);

    // Check if purchase should be disabled
    final isPurchaseDisabled = _shouldDisablePurchase(voucher, isValidAmount);

    state = state.copyWith(
      youPay: youPay,
      savings: savings,
      isValidAmount: isValidAmount,
      isPurchaseDisabled: isPurchaseDisabled,
    );
  }

  bool _validateAmount(double amount, Voucher voucher) {
    // Amount cannot be empty or zero
    if (amount <= 0) return false;

    // Amount must be between minAmount and maxAmount
    if (amount < voucher.minAmount || amount > voucher.maxAmount) return false;

    return true;
  }

  bool _shouldDisablePurchase(Voucher voucher, bool isValidAmount) {
    // Disable if disablePurchase is true
    if (voucher.disablePurchase == true) return true;

    // Disable if amount is invalid
    if (!isValidAmount) return true;

    // Disable if amount is zero
    if (state.amount == 0) return true;

    return false;
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void reset() {
    state = const VoucherState();
  }
}
