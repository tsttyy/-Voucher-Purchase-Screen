import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state_management/voucher_providers.dart';
import '../widgets/amount_input_widget.dart';
import '../widgets/payment_method_selector_widget.dart';
import '../widgets/quantity_stepper_widget.dart';
import '../widgets/summary_card_widget.dart';

/// Complete Voucher Purchase Screen with Flutter UI
/// Uses ConsumerWidget to watch Riverpod state and update UI reactively
class VoucherPurchaseScreen extends ConsumerStatefulWidget {
  const VoucherPurchaseScreen({super.key});

  @override
  ConsumerState<VoucherPurchaseScreen> createState() =>
      _VoucherPurchaseScreenState();
}

class _VoucherPurchaseScreenState extends ConsumerState<VoucherPurchaseScreen> {
  @override
  void initState() {
    super.initState();
    // Load voucher data when screen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(voucherNotifierProvider.notifier).loadVoucher();
    });
  }

  @override
  Widget build(BuildContext context) {
    final voucher = ref.watch(voucherProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final error = ref.watch(errorProvider);

    if (isLoading && voucher == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Voucher Purchase')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(voucherNotifierProvider.notifier).loadVoucher(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (voucher == null) {
      return const Scaffold(
        body: Center(
          child: Text('No voucher data available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(voucher.name ?? 'Voucher Purchase'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Voucher Info Card
            _buildVoucherInfoCard(context, voucher),
            const SizedBox(height: 24),

            // Amount Input
            const AmountInputWidget(),
            const SizedBox(height: 24),

            // Quantity Stepper
            const QuantityStepperWidget(),
            const SizedBox(height: 24),

            // Payment Method Selector
            const PaymentMethodSelectorWidget(),
            const SizedBox(height: 24),

            // Summary Card
            const SummaryCardWidget(),
            const SizedBox(height: 24),

            // Pay Button
            _buildPayButton(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherInfoCard(BuildContext context, voucher) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              voucher.name ?? 'Voucher',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            if (voucher.description != null && voucher.description!.isNotEmpty)
              Text(
                voucher.description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
              ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${voucher.discount?.percent ?? 0}% OFF',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  'Min: ₹${voucher.minAmount.toStringAsFixed(0)} | Max: ₹${voucher.maxAmount.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton(BuildContext context, WidgetRef ref) {
    final isPurchaseDisabled = ref.watch(isPurchaseDisabledProvider);
    final payButtonLabel = ref.watch(payButtonLabelProvider);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed:
            isPurchaseDisabled ? null : () => _handlePayment(context, ref),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPurchaseDisabled
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.primary,
          foregroundColor: isPurchaseDisabled
              ? Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
              : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isPurchaseDisabled
                ? BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  )
                : BorderSide.none,
          ),
          elevation: isPurchaseDisabled ? 0 : 2,
        ),
        child: Text(
          payButtonLabel,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _handlePayment(BuildContext context, WidgetRef ref) {
    final youPay = ref.read(youPayProvider);
    final paymentMethod = ref.read(selectedPaymentMethodProvider);
    final notifier = ref.read(voucherNotifierProvider.notifier);

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: ₹${youPay.toStringAsFixed(0)}'),
            const SizedBox(height: 8),
            Text('Payment Method: ${paymentMethod.displayName}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showPaymentSuccess(context, youPay);
              // Reset form after successful payment
              notifier.reset();
            },
            child: const Text('Pay Now'),
          ),
        ],
      ),
    );
  }

  void _showPaymentSuccess(BuildContext context, double amount) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment of ₹${amount.toStringAsFixed(0)} successful!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
