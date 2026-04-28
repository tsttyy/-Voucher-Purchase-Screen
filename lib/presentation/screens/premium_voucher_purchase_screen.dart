import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state_management/voucher_providers.dart';
import '../widgets/premium_voucher_card.dart';
import '../widgets/premium_payment_method_tile.dart';
import '../widgets/premium_quantity_stepper.dart';
import '../widgets/premium_summary_card.dart';
import '../widgets/premium_pay_button.dart';
import '../widgets/premium_amount_input.dart';
import '../../core/theme/premium_theme.dart';

/// Premium Voucher Purchase Screen
/// Modern fintech-inspired UI with premium design elements
class PremiumVoucherPurchaseScreen extends ConsumerStatefulWidget {
  const PremiumVoucherPurchaseScreen({super.key});

  @override
  ConsumerState<PremiumVoucherPurchaseScreen> createState() =>
      _PremiumVoucherPurchaseScreenState();
}

class _PremiumVoucherPurchaseScreenState
    extends ConsumerState<PremiumVoucherPurchaseScreen> {
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
      return Scaffold(
        backgroundColor: PremiumTheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(PremiumTheme.spacing20),
                decoration: BoxDecoration(
                  color: PremiumTheme.surface,
                  borderRadius: BorderRadius.circular(PremiumTheme.radius16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      color: PremiumTheme.primary,
                      strokeWidth: 3,
                    ),
                    const SizedBox(height: PremiumTheme.spacing16),
                    Text(
                      'Loading voucher...',
                      style: PremiumTheme.bodyMedium.copyWith(
                        color: PremiumTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (error != null) {
      return Scaffold(
        backgroundColor: PremiumTheme.background,
        appBar: AppBar(
          title: const Text('Voucher Purchase'),
          backgroundColor: PremiumTheme.surface,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(PremiumTheme.spacing32),
                decoration: BoxDecoration(
                  color: PremiumTheme.surface,
                  borderRadius: BorderRadius.circular(PremiumTheme.radius16),
                  boxShadow: [
                    BoxShadow(
                      color: PremiumTheme.error.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: PremiumTheme.error,
                    ),
                    const SizedBox(height: PremiumTheme.spacing16),
                    Text(
                      'Error loading voucher',
                      style: PremiumTheme.headingMedium.copyWith(
                        color: PremiumTheme.error,
                      ),
                    ),
                    const SizedBox(height: PremiumTheme.spacing8),
                    Text(
                      error,
                      style: PremiumTheme.bodyMedium.copyWith(
                        color: PremiumTheme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: PremiumTheme.spacing24),
                    ElevatedButton(
                      onPressed: () => ref
                          .read(voucherNotifierProvider.notifier)
                          .loadVoucher(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PremiumTheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: PremiumTheme.spacing24,
                          vertical: PremiumTheme.spacing12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(PremiumTheme.radius12),
                        ),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (voucher == null) {
      return Scaffold(
        backgroundColor: PremiumTheme.background,
        appBar: AppBar(
          title: const Text('Voucher Purchase'),
          backgroundColor: PremiumTheme.surface,
          elevation: 0,
        ),
        body: Center(
          child: Text(
            'No voucher data available',
            style: PremiumTheme.bodyMedium.copyWith(
              color: PremiumTheme.textSecondary,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: PremiumTheme.background,
      appBar: AppBar(
        title: Text(voucher.name ?? 'Voucher Purchase'),
        backgroundColor: PremiumTheme.surface,
        elevation: 0,
        foregroundColor: PremiumTheme.textPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main Content
            Padding(
              padding: const EdgeInsets.all(PremiumTheme.spacing20),
              child: Column(
                children: [
                  // Voucher Card
                  PremiumVoucherCard(
                    voucher: voucher,
                    onReferEarn: () {
                      // Handle refer & earn
                    },
                  ),

                  const SizedBox(height: PremiumTheme.spacing24),

                  // Amount Input
                  PremiumAmountInput(
                    amount: ref.watch(amountProvider),
                    onAmountChanged: (amount) {
                      ref
                          .read(voucherNotifierProvider.notifier)
                          .updateAmount(amount);
                    },
                    validationError: ref.watch(validationErrorMessageProvider),
                    isLoading: isLoading,
                  ),

                  const SizedBox(height: PremiumTheme.spacing24),

                  // Quantity Stepper
                  PremiumQuantityStepper(
                    quantity: ref.watch(quantityProvider),
                    onQuantityChanged: (quantity) {
                      ref
                          .read(voucherNotifierProvider.notifier)
                          .updateQuantity(quantity);
                    },
                    minQuantity: 1,
                    maxQuantity: 10,
                  ),

                  const SizedBox(height: PremiumTheme.spacing24),

                  // Payment Method Selector
                  PremiumPaymentMethodTile(
                    selectedMethod: ref.watch(selectedPaymentMethodProvider),
                    onMethodChanged: (method) {
                      ref
                          .read(voucherNotifierProvider.notifier)
                          .selectPaymentMethod(method.value);
                    },
                  ),

                  const SizedBox(height: PremiumTheme.spacing24),

                  // Summary Card
                  PremiumSummaryCard(
                    amount: ref.watch(amountProvider),
                    discountPercent: ref.watch(discountPercentProvider),
                    youPay: ref.watch(youPayProvider),
                    savings: ref.watch(savingsProvider),
                    quantity: ref.watch(quantityProvider),
                  ),

                  const SizedBox(height: PremiumTheme.spacing32),

                  // Redeem Steps (if needed)
                  _buildRedeemSteps(context),

                  const SizedBox(height: PremiumTheme.spacing32),
                ],
              ),
            ),
          ],
        ),
      ),
      // Sticky Pay Button
      bottomNavigationBar: PremiumPayButton(
        amount: ref.watch(youPayProvider),
        isDisabled: ref.watch(isPurchaseDisabledProvider),
        isLoading: isLoading,
        onPressed: () => _handlePayment(context, ref),
      ),
    );
  }

  Widget _buildRedeemSteps(BuildContext context) {
    return Container(
      decoration: PremiumTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(PremiumTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: PremiumTheme.primary,
                  size: 20,
                ),
                const SizedBox(width: PremiumTheme.spacing8),
                Text(
                  'How to Redeem',
                  style: PremiumTheme.headingSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PremiumTheme.spacing16),
            _buildStepItem(
                context, 1, 'Complete payment using your preferred method'),
            _buildStepItem(
                context, 2, 'Voucher will be credited to your account'),
            _buildStepItem(context, 3, 'Use voucher during next purchase'),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(
      BuildContext context, int stepNumber, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PremiumTheme.spacing12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: PremiumTheme.primary,
              borderRadius: BorderRadius.circular(PremiumTheme.radius12),
            ),
            child: Center(
              child: Text(
                stepNumber.toString(),
                style: PremiumTheme.bodySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: PremiumTheme.spacing12),
          Expanded(
            child: Text(
              description,
              style: PremiumTheme.bodyMedium.copyWith(
                color: PremiumTheme.textSecondary,
              ),
            ),
          ),
        ],
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
            Text(
              'Amount: ₹${youPay.toStringAsFixed(0)}',
              style: PremiumTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: PremiumTheme.spacing8),
            Text(
              'Payment Method: ${paymentMethod.displayName}',
              style: PremiumTheme.bodyMedium,
            ),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: PremiumTheme.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Pay Now'),
          ),
        ],
      ),
    );
  }

  void _showPaymentSuccess(BuildContext context, double amount) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: PremiumTheme.spacing8),
            Text('Payment of ₹${amount.toStringAsFixed(0)} successful!'),
          ],
        ),
        backgroundColor: PremiumTheme.success,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
