// Voucher Purchase Screen Widget Tests
// Tests for the premium voucher purchase UI components

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:voucher_purchase_screen/presentation/widgets/premium_voucher_card.dart';
import 'package:voucher_purchase_screen/presentation/widgets/premium_amount_input.dart';
import 'package:voucher_purchase_screen/presentation/widgets/premium_pay_button.dart';
import 'package:voucher_purchase_screen/domain/entities/voucher.dart';

void main() {
  testWidgets('PremiumVoucherCard renders correctly', (WidgetTester tester) async {
    // Create a test voucher
    final testVoucher = Voucher(
      name: 'Test Voucher',
      description: 'Test Description',
      minAmount: 100.0,
      maxAmount: 10000.0,
      discount: Discount(percent: 10.0),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PremiumVoucherCard(
            voucher: testVoucher,
          ),
        ),
      ),
    );

    // Verify the voucher card renders
    expect(find.byType(PremiumVoucherCard), findsOneWidget);
    expect(find.text('Test Voucher'), findsOneWidget);
    expect(find.text('10% OFF'), findsOneWidget);
  });

  testWidgets('PremiumAmountInput renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PremiumAmountInput(
            amount: 1000.0,
            onAmountChanged: (amount) {},
          ),
        ),
      ),
    );

    // Verify the amount input renders
    expect(find.byType(PremiumAmountInput), findsOneWidget);
    expect(find.text('Enter Amount'), findsOneWidget);
  });

  testWidgets('PremiumPayButton renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PremiumPayButton(
            amount: 1800.0,
            isDisabled: false,
            onPressed: () {},
          ),
        ),
      ),
    );

    // Verify the pay button renders
    expect(find.byType(PremiumPayButton), findsOneWidget);
    expect(find.text('Pay ₹1800'), findsOneWidget);
  });

  testWidgets('PremiumPayButton shows disabled state', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PremiumPayButton(
            amount: 0.0,
            isDisabled: true,
            onPressed: () {},
          ),
        ),
      ),
    );

    // Verify the pay button shows disabled state
    expect(find.byType(PremiumPayButton), findsOneWidget);
    expect(find.text('Enter Valid Amount'), findsOneWidget);
  });

  testWidgets('PremiumPayButton shows loading state', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PremiumPayButton(
            amount: 1800.0,
            isDisabled: false,
            isLoading: true,
            onPressed: () {},
          ),
        ),
      ),
    );

    // Verify the pay button shows loading state
    expect(find.byType(PremiumPayButton), findsOneWidget);
    expect(find.text('Processing...'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
