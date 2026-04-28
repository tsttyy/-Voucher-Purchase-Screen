import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/payment_method.dart';
import '../../core/theme/premium_theme.dart';

/// Premium Payment Method Tile Component
/// Modern segmented control with icons and smooth transitions
class PremiumPaymentMethodTile extends ConsumerWidget {
  final PaymentMethod selectedMethod;
  final ValueChanged<PaymentMethod> onMethodChanged;

  const PremiumPaymentMethodTile({
    super.key,
    required this.selectedMethod,
    required this.onMethodChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: PremiumTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding: const EdgeInsets.all(PremiumTheme.spacing20),
            child: Text(
              'Payment Method',
              style: PremiumTheme.headingSmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // Payment Methods Grid
          Padding(
            padding: const EdgeInsets.fromLTRB(
              PremiumTheme.spacing20,
              0,
              PremiumTheme.spacing20,
              PremiumTheme.spacing20,
            ),
            child: Column(
              children: [
                // UPI Methods
                _buildPaymentMethodGroup(
                  context,
                  'UPI Methods',
                  [
                    PaymentMethod.upi,
                  ],
                ),
                
                const SizedBox(height: PremiumTheme.spacing16),
                
                // Card Methods
                _buildPaymentMethodGroup(
                  context,
                  'Card Methods',
                  [
                    PaymentMethod.creditCard,
                    PaymentMethod.debitCard,
                  ],
                ),
                
                const SizedBox(height: PremiumTheme.spacing16),
                
                // Net Banking
                _buildPaymentMethodGroup(
                  context,
                  'Other Methods',
                  [
                    PaymentMethod.netBanking,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodGroup(
    BuildContext context,
    String title,
    List<PaymentMethod> methods,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group Title
        Padding(
          padding: const EdgeInsets.only(
            left: PremiumTheme.spacing4,
            bottom: PremiumTheme.spacing12,
          ),
          child: Text(
            title,
            style: PremiumTheme.bodySmall.copyWith(
              color: PremiumTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        
        // Method Tiles
        ...methods.map((method) => _buildPaymentMethodTile(context, method)),
      ],
    );
  }

  Widget _buildPaymentMethodTile(BuildContext context, PaymentMethod method) {
    final isSelected = selectedMethod == method;
    
    return GestureDetector(
      onTap: () => onMethodChanged(method),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: PremiumTheme.spacing8),
        padding: const EdgeInsets.all(PremiumTheme.spacing16),
        decoration: BoxDecoration(
          color: isSelected ? PremiumTheme.primary.withOpacity(0.1) : PremiumTheme.surface,
          borderRadius: BorderRadius.circular(PremiumTheme.radius12),
          border: Border.all(
            color: isSelected ? PremiumTheme.primary : PremiumTheme.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: PremiumTheme.primary.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Payment Method Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected 
                    ? PremiumTheme.primary.withOpacity(0.1)
                    : PremiumTheme.surfaceVariant,
                borderRadius: BorderRadius.circular(PremiumTheme.radius12),
              ),
              child: Icon(
                _getPaymentIcon(method),
                size: 24,
                color: isSelected ? PremiumTheme.primary : PremiumTheme.textSecondary,
              ),
            ),
            
            const SizedBox(width: PremiumTheme.spacing16),
            
            // Payment Method Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.displayName,
                    style: PremiumTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? PremiumTheme.primary : PremiumTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: PremiumTheme.spacing4),
                  Text(
                    _getPaymentDescription(method),
                    style: PremiumTheme.bodySmall.copyWith(
                      color: PremiumTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            
            // Selection Indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? PremiumTheme.primary : PremiumTheme.border,
                borderRadius: BorderRadius.circular(PremiumTheme.radius20),
                border: Border.all(
                  color: isSelected ? PremiumTheme.primary : PremiumTheme.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getPaymentIcon(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.upi:
        return Icons.phone_android;
      case PaymentMethod.creditCard:
        return Icons.credit_card;
      case PaymentMethod.debitCard:
        return Icons.credit_card;
      case PaymentMethod.netBanking:
        return Icons.account_balance;
    }
  }

  String _getPaymentDescription(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.upi:
        return 'Pay using UPI apps';
      case PaymentMethod.creditCard:
        return 'Pay using Credit Card';
      case PaymentMethod.debitCard:
        return 'Pay using Debit Card';
      case PaymentMethod.netBanking:
        return 'Pay using Net Banking';
    }
  }
}
