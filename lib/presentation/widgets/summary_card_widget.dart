import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state_management/voucher_providers.dart';

/// Reusable Summary Card Widget
/// Displays YOU PAY and SAVINGS with automatic updates
class SummaryCardWidget extends ConsumerWidget {
  const SummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final youPay = ref.watch(youPayProvider);
    final savings = ref.watch(savingsProvider);
    final amount = ref.watch(amountProvider);
    final discountPercent = ref.watch(discountPercentProvider);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Amount row
            _buildSummaryRow(
              context,
              'Amount',
              '₹${amount.toStringAsFixed(0)}',
              isSubtotal: true,
            ),
            const SizedBox(height: 12),

            // Discount row (only show if there's a discount)
            if (discountPercent > 0) ...[
              _buildSummaryRow(
                context,
                'Discount (${discountPercent.toStringAsFixed(0)}%)',
                '-₹${(amount * discountPercent / 100).toStringAsFixed(0)}',
                isDiscount: true,
              ),
              const SizedBox(height: 12),
            ],

            const Divider(height: 1),
            const SizedBox(height: 12),

            // You Pay row
            _buildSummaryRow(
              context,
              'YOU PAY',
              '₹${youPay.toStringAsFixed(0)}',
              isTotal: true,
            ),
            const SizedBox(height: 8),

            // Savings row (only show if there are savings)
            if (savings > 0) ...[
              const SizedBox(height: 4),
              _buildSummaryRow(
                context,
                'You Save',
                '₹${savings.toStringAsFixed(0)}',
                isSavings: true,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
    bool isDiscount = false,
    bool isSavings = false,
    bool isSubtotal = false,
  }) {
    TextStyle labelStyle;
    TextStyle valueStyle;
    Color valueColor = Theme.of(context).colorScheme.onSurface;

    if (isTotal) {
      labelStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ) ??
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
      valueStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ) ??
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    } else if (isSavings) {
      labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ) ??
          const TextStyle(color: Colors.green, fontWeight: FontWeight.w500);
      valueStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ) ??
          const TextStyle(color: Colors.green, fontWeight: FontWeight.w600);
      valueColor = Colors.green;
    } else if (isDiscount) {
      labelStyle = Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
      valueStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.red,
              ) ??
          const TextStyle(color: Colors.red);
      valueColor = Colors.red;
    } else {
      labelStyle = Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
      valueStyle = Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
      if (isSubtotal) {
        valueStyle = valueStyle.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        );
        valueColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.7);
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: labelStyle,
        ),
        Text(
          value,
          style: valueStyle.copyWith(color: valueColor),
        ),
      ],
    );
  }
}
