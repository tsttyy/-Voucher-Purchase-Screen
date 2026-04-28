import '../../domain/entities/payment_method.dart';
import '../../domain/entities/voucher.dart';
import '../../domain/repositories/voucher_repository.dart';
import 'voucher_state.dart';

class VoucherController {
  final VoucherRepository _repository;

  VoucherState _state = const VoucherState();
  VoucherState get state => _state;

  VoucherController(this._repository);

  Future<void> loadVoucher() async {
    _state = _state.copyWith(isLoading: true, error: null);

    try {
      final voucher = await _repository.getVoucher();
      _state = _state.copyWith(
        voucher: voucher,
        isLoading: false,
        discountPercent: voucher.discount?.percent ?? 0.0,
      );
      _recalculateValues();
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updateAmount(double amount) {
    _state = _state.copyWith(amount: amount);
    _recalculateValues();
  }

  void updateQuantity(int quantity) {
    _state = _state.copyWith(quantity: quantity);
    _recalculateValues();
  }

  void selectPaymentMethod(String method) {
    final paymentMethod = PaymentMethod.fromString(method);
    _state = _state.copyWith(selectedPaymentMethod: paymentMethod);
  }

  void _recalculateValues() {
    final voucher = _state.voucher;
    if (voucher == null) return;

    // Calculate discount amount
    final discountAmount = _state.amount * _state.discountPercent / 100;

    // Calculate youPay and savings
    final youPay = (_state.amount - discountAmount) * _state.quantity;
    final savings = discountAmount * _state.quantity;

    // Validate amount
    final isValidAmount = _validateAmount(_state.amount, voucher);

    // Check if purchase should be disabled
    final isPurchaseDisabled = _shouldDisablePurchase(voucher, isValidAmount);

    _state = _state.copyWith(
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
    if (_state.amount == 0) return true;

    return false;
  }

  void clearError() {
    _state = _state.copyWith(error: null);
  }

  void reset() {
    _state = const VoucherState();
  }
}
