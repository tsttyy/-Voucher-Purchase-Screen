import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/voucher.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/voucher_repository.dart';
import 'voucher_notifier.dart';
import 'voucher_state.dart';
import 'repositories.dart';

/// Riverpod Providers for Voucher State Management

// Repository provider
final voucherRepositoryProvider = Provider<VoucherRepository>((ref) {
  return voucherRepository;
});

// VoucherNotifier provider
final voucherNotifierProvider =
    StateNotifierProvider<VoucherNotifier, VoucherState>((ref) {
  return VoucherNotifier(ref.watch(voucherRepositoryProvider));
});

// Convenience providers for specific state values
final voucherProvider = Provider<Voucher?>((ref) {
  return ref.watch(voucherNotifierProvider).voucher;
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(voucherNotifierProvider).isLoading;
});

final errorProvider = Provider<String?>((ref) {
  return ref.watch(voucherNotifierProvider).error;
});

final amountProvider = Provider<double>((ref) {
  return ref.watch(voucherNotifierProvider).amount;
});

final quantityProvider = Provider<int>((ref) {
  return ref.watch(voucherNotifierProvider).quantity;
});

final selectedPaymentMethodProvider = Provider<PaymentMethod>((ref) {
  return ref.watch(voucherNotifierProvider).selectedPaymentMethod;
});

final discountPercentProvider = Provider<double>((ref) {
  return ref.watch(voucherNotifierProvider).discountPercent;
});

final youPayProvider = Provider<double>((ref) {
  return ref.watch(voucherNotifierProvider).youPay;
});

final savingsProvider = Provider<double>((ref) {
  return ref.watch(voucherNotifierProvider).savings;
});

final isValidAmountProvider = Provider<bool>((ref) {
  return ref.watch(voucherNotifierProvider).isValidAmount;
});

final isPurchaseDisabledProvider = Provider<bool>((ref) {
  return ref.watch(voucherNotifierProvider).isPurchaseDisabled;
});

// Computed providers for UI
final payButtonLabelProvider = Provider<String>((ref) {
  final youPay = ref.watch(youPayProvider);
  return 'Pay ₹${youPay.toStringAsFixed(0)}';
});

final validationErrorMessageProvider = Provider<String?>((ref) {
  final state = ref.watch(voucherNotifierProvider);
  final voucher = state.voucher;

  if (state.isValidAmount || voucher == null) return null;

  if (state.amount < voucher.minAmount) {
    return 'Minimum amount is ₹${voucher.minAmount.toStringAsFixed(0)}';
  }

  if (state.amount > voucher.maxAmount) {
    return 'Maximum amount is ₹${voucher.maxAmount.toStringAsFixed(0)}';
  }

  return 'Invalid amount';
});
