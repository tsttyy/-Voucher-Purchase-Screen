/// Models and utilities for managing purchase state
/// State follows immutable pattern for predictable updates
/// This file provides a simplified interface for basic purchase operations

class PurchaseState {
  final double amount;
  final String paymentMethod;
  final int quantity;

  const PurchaseState({
    required this.amount,
    required this.paymentMethod,
    required this.quantity,
  });

  PurchaseState copyWith({
    double? amount,
    String? paymentMethod,
    int? quantity,
  }) {
    return PurchaseState(
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  String toString() =>
      'PurchaseState(amount: $amount, method: $paymentMethod, qty: $quantity)';
}

/// Simple controller for managing purchase state changes
/// This provides basic functionality without external dependencies
class PurchaseNotifier {
  PurchaseState _state = const PurchaseState(
    amount: 0,
    paymentMethod: 'UPI',
    quantity: 1,
  );

  PurchaseState get state => _state;

  void setAmount(double amount) {
    _state = _state.copyWith(amount: amount);
  }

  void setPaymentMethod(String method) {
    _state = _state.copyWith(paymentMethod: method);
  }

  void incrementQuantity() {
    _state = _state.copyWith(quantity: _state.quantity + 1);
  }

  void decrementQuantity() {
    if (_state.quantity > 1) {
      _state = _state.copyWith(quantity: _state.quantity - 1);
    }
  }

  void setQuantity(int quantity) {
    if (quantity >= 1) {
      _state = _state.copyWith(quantity: quantity);
    }
  }

  void reset() {
    _state = const PurchaseState(amount: 0, paymentMethod: 'UPI', quantity: 1);
  }
}

/// Factory for purchase state management
class PurchaseStateFactory {
  static PurchaseNotifier? _notifier;

  static PurchaseNotifier getNotifier() {
    _notifier ??= PurchaseNotifier();
    return _notifier!;
  }

  static PurchaseState getState() {
    return getNotifier().state;
  }

  static void reset() {
    _notifier = null;
  }
}

/// Convenience getters for purchase state
PurchaseNotifier get purchaseNotifier => PurchaseStateFactory.getNotifier();
PurchaseState get purchaseState => PurchaseStateFactory.getState();
