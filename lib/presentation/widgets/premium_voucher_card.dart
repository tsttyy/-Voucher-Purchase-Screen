import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/voucher.dart';
import '../../core/theme/premium_theme.dart';

/// Premium Voucher Card Component
/// Modern card-based layout with gradient background and elevation
class PremiumVoucherCard extends ConsumerWidget {
  final Voucher voucher;
  final VoidCallback? onReferEarn;

  const PremiumVoucherCard({
    super.key,
    required this.voucher,
    this.onReferEarn,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: PremiumTheme.elevatedCardDecoration,
      child: Column(
        children: [
          // Header with Refer & Earn
          _buildHeader(context),
          
          // Voucher Banner Section
          _buildVoucherBanner(context),
          
          // Voucher Details
          _buildVoucherDetails(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PremiumTheme.spacing20,
        vertical: PremiumTheme.spacing12,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: PremiumTheme.border, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Refer & Earn',
            style: PremiumTheme.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: PremiumTheme.primary,
            ),
          ),
          GestureDetector(
            onTap: onReferEarn,
            child: Container(
              padding: const EdgeInsets.all(PremiumTheme.spacing4),
              decoration: BoxDecoration(
                color: PremiumTheme.borderLight,
                borderRadius: BorderRadius.circular(PremiumTheme.radius8),
              ),
              child: Icon(
                Icons.close,
                size: 16,
                color: PremiumTheme.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherBanner(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.all(PremiumTheme.spacing20),
      decoration: BoxDecoration(
        gradient: PremiumTheme.primaryGradient,
        borderRadius: BorderRadius.circular(PremiumTheme.radius16),
        boxShadow: [
          BoxShadow(
            color: PremiumTheme.primary.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Pattern
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(PremiumTheme.radius16),
              child: CustomPaint(
                painter: VoucherPatternPainter(),
              ),
            ),
          ),
          
          // Voucher Content
          Padding(
            padding: const EdgeInsets.all(PremiumTheme.spacing20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Discount Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PremiumTheme.spacing12,
                    vertical: PremiumTheme.spacing6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(PremiumTheme.radius20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_offer,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: PremiumTheme.spacing4),
                      Text(
                        '${(voucher.discount?.percent ?? 0).toStringAsFixed(0)}% OFF',
                        style: PremiumTheme.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Voucher Name
                Text(
                  voucher.name ?? 'Premium Voucher',
                  style: PremiumTheme.headingMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                
                const SizedBox(height: PremiumTheme.spacing8),
                
                // Voucher Description
                if (voucher.description != null)
                  Text(
                    voucher.description!,
                    style: PremiumTheme.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          
          // Corner Decoration
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(PremiumTheme.radius20),
              ),
              child: Icon(
                Icons.card_giftcard,
                color: Colors.white.withOpacity(0.8),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PremiumTheme.spacing20),
      child: Column(
        children: [
          // Amount Range
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: PremiumTheme.textSecondary,
              ),
              const SizedBox(width: PremiumTheme.spacing8),
              Text(
                'Min: ₹${voucher.minAmount.toStringAsFixed(0)} | Max: ₹${voucher.maxAmount.toStringAsFixed(0)}',
                style: PremiumTheme.bodySmall.copyWith(
                  color: PremiumTheme.textSecondary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: PremiumTheme.spacing12),
          
          // Validity Info (if available)
          if (voucher.isActive != null)
            Row(
              children: [
                Icon(
                  voucher.isActive == true ? Icons.check_circle : Icons.error,
                  size: 16,
                  color: voucher.isActive == true ? PremiumTheme.success : PremiumTheme.error,
                ),
                const SizedBox(width: PremiumTheme.spacing8),
                Text(
                  voucher.isActive == true ? 'Available' : 'Unavailable',
                  style: PremiumTheme.bodySmall.copyWith(
                    color: voucher.isActive == true ? PremiumTheme.success : PremiumTheme.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// Custom painter for voucher background pattern
class VoucherPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Draw decorative circles
    final circles = [
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width * 0.9, size.height * 0.7),
      Offset(size.width * 0.1, size.height * 0.8),
    ];

    for (final center in circles) {
      canvas.drawCircle(center, 30, paint);
      canvas.drawCircle(center, 20, paint);
      canvas.drawCircle(center, 10, paint);
    }

    // Draw decorative lines
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..strokeWidth = 1;

    for (int i = 0; i < 5; i++) {
      final y = (size.height / 5) * i;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
