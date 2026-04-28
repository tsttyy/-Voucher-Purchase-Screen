import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/premium_theme.dart';

/// Premium Pay Button Component
/// Gradient background with pill style and dynamic elevation
class PremiumPayButton extends ConsumerWidget {
  final double amount;
  final bool isDisabled;
  final VoidCallback onPressed;
  final bool isLoading;

  const PremiumPayButton({
    super.key,
    required this.amount,
    required this.isDisabled,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(PremiumTheme.spacing20),
      decoration: BoxDecoration(
        color: PremiumTheme.surface,
        borderRadius: BorderRadius.circular(PremiumTheme.radius16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 56,
        decoration: _buildButtonDecoration(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isDisabled || isLoading ? null : onPressed,
            borderRadius: BorderRadius.circular(PremiumTheme.radius32),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: PremiumTheme.spacing24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Loading Indicator
                  if (isLoading) ...[
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    const SizedBox(width: PremiumTheme.spacing12),
                  ],
                  
                  // Lock Icon (if disabled)
                  if (isDisabled && !isLoading) ...[
                    Icon(
                      Icons.lock,
                      size: 20,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    const SizedBox(width: PremiumTheme.spacing12),
                  ],
                  
                  // Button Text
                  Text(
                    _getButtonText(),
                    style: PremiumTheme.bodyLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  
                  const SizedBox(width: PremiumTheme.spacing8),
                  
                  // Arrow Icon
                  Icon(
                    isLoading ? null : (isDisabled ? Icons.info : Icons.arrow_forward),
                    size: 20,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildButtonDecoration() {
    if (isDisabled) {
      return BoxDecoration(
        color: PremiumTheme.border,
        borderRadius: BorderRadius.circular(PremiumTheme.radius32),
        border: Border.all(color: PremiumTheme.borderLight),
      );
    }
    
    return BoxDecoration(
      gradient: PremiumTheme.primaryGradient,
      borderRadius: BorderRadius.circular(PremiumTheme.radius32),
      boxShadow: [
        BoxShadow(
          color: PremiumTheme.primary.withOpacity(0.3),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
        BoxShadow(
          color: PremiumTheme.primary.withOpacity(0.2),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
    );
  }

  String _getButtonText() {
    if (isLoading) return 'Processing...';
    if (isDisabled) return 'Enter Valid Amount';
    return 'Pay ₹${amount.toStringAsFixed(0)}';
  }
}
