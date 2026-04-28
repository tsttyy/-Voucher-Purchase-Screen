import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/premium_theme.dart';

/// Premium Quantity Stepper Component
/// Modern stepper with smooth animations and visual feedback
class PremiumQuantityStepper extends ConsumerWidget {
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final int? minQuantity;
  final int? maxQuantity;

  const PremiumQuantityStepper({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
    this.minQuantity = 1,
    this.maxQuantity = 99,
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
                  Icons.inventory_2,
                  color: PremiumTheme.primary,
                  size: 20,
                ),
                const SizedBox(width: PremiumTheme.spacing8),
                Text(
                  'Quantity',
                  style: PremiumTheme.headingSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: PremiumTheme.spacing16),
            
            // Quantity Stepper
            _buildQuantityStepper(context),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityStepper(BuildContext context) {
    final canDecrement = quantity > (minQuantity ?? 1);
    final canIncrement = quantity < (maxQuantity ?? 99);
    
    return Container(
      decoration: BoxDecoration(
        color: PremiumTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(PremiumTheme.radius16),
        border: Border.all(color: PremiumTheme.border),
      ),
      child: Row(
        children: [
          // Decrement Button
          Expanded(
            child: GestureDetector(
              onTap: canDecrement ? () => onQuantityChanged(quantity - 1) : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(PremiumTheme.spacing4),
                decoration: BoxDecoration(
                  color: canDecrement 
                      ? PremiumTheme.primary.withOpacity(0.1)
                      : PremiumTheme.surface,
                  borderRadius: BorderRadius.circular(PremiumTheme.radius12),
                ),
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.remove,
                    size: 24,
                    color: canDecrement 
                        ? PremiumTheme.primary
                        : PremiumTheme.textTertiary,
                  ),
                ),
              ),
            ),
          ),
          
          // Quantity Display
          Container(
            width: 80,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: PremiumTheme.surface,
              border: Border.symmetric(
                vertical: BorderSide(
                  color: PremiumTheme.border,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  quantity.toString(),
                  style: PremiumTheme.headingMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: PremiumTheme.primary,
                  ),
                ),
                Text(
                  'items',
                  style: PremiumTheme.caption.copyWith(
                    color: PremiumTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Increment Button
          Expanded(
            child: GestureDetector(
              onTap: canIncrement ? () => onQuantityChanged(quantity + 1) : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(PremiumTheme.spacing4),
                decoration: BoxDecoration(
                  color: canIncrement 
                      ? PremiumTheme.primary.withOpacity(0.1)
                      : PremiumTheme.surface,
                  borderRadius: BorderRadius.circular(PremiumTheme.radius12),
                ),
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.add,
                    size: 24,
                    color: canIncrement 
                        ? PremiumTheme.primary
                        : PremiumTheme.textTertiary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
