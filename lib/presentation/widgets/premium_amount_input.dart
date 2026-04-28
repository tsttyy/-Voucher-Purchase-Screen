import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/premium_theme.dart';

/// Premium Amount Input Component
/// Modern input field with focus states and validation feedback
class PremiumAmountInput extends ConsumerWidget {
  final double amount;
  final ValueChanged<double> onAmountChanged;
  final String? validationError;
  final bool isLoading;

  const PremiumAmountInput({
    super.key,
    required this.amount,
    required this.onAmountChanged,
    this.validationError,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: PremiumTheme.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(PremiumTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.currency_rupee,
                  color: PremiumTheme.primary,
                  size: 20,
                ),
                const SizedBox(width: PremiumTheme.spacing8),
                Text(
                  'Enter Amount',
                  style: PremiumTheme.headingSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: PremiumTheme.spacing16),
            
            // Amount Input Field
            _buildAmountInput(context),
            
            // Validation Error
            if (validationError != null) ...[
              const SizedBox(height: PremiumTheme.spacing12),
              _buildValidationError(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAmountInput(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PremiumTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(PremiumTheme.radius16),
        border: Border.all(
          color: validationError != null 
              ? PremiumTheme.error 
              : PremiumTheme.border,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          // Rupee Symbol
          Container(
            width: 60,
            height: 56,
            decoration: BoxDecoration(
              color: validationError != null 
                  ? PremiumTheme.error.withOpacity(0.1)
                  : PremiumTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(PremiumTheme.radius14),
                bottomLeft: Radius.circular(PremiumTheme.radius14),
              ),
            ),
            child: Center(
              child: Text(
                '₹',
                style: PremiumTheme.headingMedium.copyWith(
                  color: validationError != null 
                      ? PremiumTheme.error 
                      : PremiumTheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          
          // Input Field
          Expanded(
            child: TextField(
              enabled: !isLoading,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: PremiumTheme.headingMedium.copyWith(
                color: validationError != null 
                    ? PremiumTheme.error 
                    : PremiumTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: '0.00',
                hintStyle: PremiumTheme.headingMedium.copyWith(
                  color: PremiumTheme.textTertiary,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: PremiumTheme.spacing16,
                  vertical: PremiumTheme.spacing16,
                ),
              ),
              onChanged: (value) {
                final parsedAmount = double.tryParse(value) ?? 0.0;
                onAmountChanged(parsedAmount);
              },
            ),
          ),
          
          // Clear Button
          if (amount > 0 && !isLoading)
            GestureDetector(
              onTap: () => onAmountChanged(0.0),
              child: Container(
                width: 48,
                height: 56,
                decoration: BoxDecoration(
                  color: PremiumTheme.surface,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(PremiumTheme.radius14),
                    bottomRight: Radius.circular(PremiumTheme.radius14),
                  ),
                ),
                child: Icon(
                  Icons.clear,
                  color: PremiumTheme.textSecondary,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildValidationError(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PremiumTheme.spacing12),
      decoration: BoxDecoration(
        color: PremiumTheme.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(PremiumTheme.radius8),
        border: Border.all(
          color: PremiumTheme.error.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            size: 16,
            color: PremiumTheme.error,
          ),
          const SizedBox(width: PremiumTheme.spacing8),
          Expanded(
            child: Text(
              validationError!,
              style: PremiumTheme.bodySmall.copyWith(
                color: PremiumTheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
