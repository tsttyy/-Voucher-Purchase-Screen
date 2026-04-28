import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/screens/premium_voucher_purchase_screen.dart';
import 'core/theme/premium_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: VoucherApp(),
    ),
  );
}

class VoucherApp extends StatelessWidget {
  const VoucherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premium Voucher Purchase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: PremiumTheme.primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: PremiumTheme.background,
        appBarTheme: AppBarTheme(
          backgroundColor: PremiumTheme.surface,
          elevation: 0,
          titleTextStyle: PremiumTheme.headingMedium.copyWith(
            color: PremiumTheme.textPrimary,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: PremiumTheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(PremiumTheme.radius12),
            ),
          ),
        ),
      ),
      home: const PremiumVoucherPurchaseScreen(),
    );
  }
}
