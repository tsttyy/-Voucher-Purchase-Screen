import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/premium_theme.dart';

/// Premium Summary Card Component
/// Split layout design with YOU PAY vs SAVINGS sections
class PremiumSummaryCard extends ConsumerWidget {
  final double amount;
  final double discountPercent;
  final double youPay;
  final double savings;
  final int quantity;

  const PremiumSummaryCard({
    super.key,
    required this.amount,
    required this.discountPercent,
    required this.youPay,
    required this.savings,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: PremiumTheme.elevatedCardDecoration,
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(PremiumTheme.spacing20),
            child: Row(
              children: [
                Icon(
                  Icons.receipt_long,
                  color: PremiumTheme.primary,
                  size: 20,
                ),
                const SizedBox(width: PremiumTheme.spacing8),
                Text(
                  'Order Summary',
                  style: PremiumTheme.headingSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          // Split Layout Content
          Padding(
            padding: const EdgeInsets.fromLTRB(
              PremiumTheme.spacing20,
              0,
              PremiumTheme.spacing20,
              PremiumTheme.spacing20,
            ),
            child: Column(
              children: [
                // Amount Details
                _buildAmountDetails(context),
                
                const SizedBox(height: PremiumTheme.spacing16),
                
                // Divider
                Container(
                  height: 1,
                  color: PremiumTheme.border,
                ),
                
                const SizedBox(height: PremiumTheme.spacing16),
                
                // Split Summary
                _buildSplitSummary(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountDetails(BuildContext context) {
    return Column(
      children: [
        // Amount Row
        _buildDetailRow(
          context,
          'Amount',
          '₹${amount.toStringAsFixed(0)}',
          isMain: false,
        ),
        
        const SizedBox(height: PremiumTheme.spacing12),
        
        // Quantity Row
        _buildDetailRow(
          context,
          'Quantity',
          quantity.toString(),
          isMain: false,
        ),
        
        const SizedBox(height: PremiumTheme.spacing12),
        
        // Discount Row (only show if there's a discount)
        if (discountPercent > 0) ...[
          _buildDetailRow(
            context,
            'Discount (${discountPercent.toStringAsFixed(0)}%)',
            '-₹${(amount * discountPercent / 100).toStringAsFixed(0)}',
            isMain: false,
            isDiscount: true,
          ),
          const SizedBox(height: PremiumTheme.spacing12),
        ],
      ],
    );
  }

  Widget _buildSplitSummary(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PremiumTheme.radius12),
        border: Border.all(color: PremiumTheme.borderLight),
      ),
      child: Column(
        children: [
          // YOU PAY Section
          _buildSummarySection(
            context,
            'YOU PAY',
            '₹${youPay.toStringAsFixed(0)}',
            PremiumTheme.primary,
            isMain: true,
          ),
          
          // Divider
          Container(
            height: 1,
            color: PremiumTheme.border,
          ),
          
          // SAVINGS Section
          if (savings > 0)
            _buildSummarySection(
              context,
              'YOU SAVE',
              '₹${savings.toStringAsFixed(0)}',
              PremiumTheme.success,
              isMain: false,
            ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(
    BuildContext context,
    String label,
    String value,
    Color color, {
    bool isMain = true,
  }) {
    return Container(
      padding: const EdgeInsets.all(PremiumTheme.spacing16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label
          Row(
            children: [
              Icon(
                isMain ? Icons.account_balance_wallet : Icons.savings,
                size: 20,
                color: color,
              ),
              const SizedBox(width: PremiumTheme.spacing8),
              Text(
                label,
                style: PremiumTheme.bodyMedium.copyWith(
                  fontWeight: isMain ? FontWeight.w600 : FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
          
          // Value
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PremiumTheme.spacing12,
              vertical: PremiumTheme.spacing6,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(PremiumTheme.radius20),
            ),
            child: Text(
              value,
              style: PremiumTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isMain = false,
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: PremiumTheme.bodyMedium.copyWith(
            color: isDiscount ? PremiumTheme.error : PremiumTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: PremiumTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: isDiscount ? PremiumTheme.error : PremiumTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
