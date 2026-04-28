/// Test file to demonstrate the complete voucher purchase implementation
/// This shows how all the components work together

import 'business_logic.dart';
import 'dependency_injection.dart';

void testVoucherImplementation() async {
  print('=== Testing Voucher Purchase Implementation ===\n');

  // Test 1: Initialize and load voucher
  print('1. Testing voucher loading...');
  final service = DependencyInjection.voucherService;
  await service.loadVoucher();

  print('   Voucher loaded: ${service.voucher?.name}');
  print('   Min amount: ${service.voucher?.minAmount}');
  print('   Max amount: ${service.voucher?.maxAmount}');
  print('   Discount: ${service.voucher?.discount?.percent}%');
  print('   Is loading: ${service.isLoading}');
  print('   Error: ${service.error}\n');

  // Test 2: Test amount validation
  print('2. Testing amount validation...');
  service.updateAmount(50.0); // Below min amount
  print('   Amount 50 (below min): Valid = ${service.isValidAmount}');

  service.updateAmount(100.0); // Valid amount
  print('   Amount 100 (valid): Valid = ${service.isValidAmount}');

  service.updateAmount(15000.0); // Above max amount
  print('   Amount 15000 (above max): Valid = ${service.isValidAmount}\n');

  // Test 3: Test calculations
  print('3. Testing business calculations...');
  service.updateAmount(1000.0);
  service.updateQuantity(2);

  final state = service.state;
  final discountAmount = BusinessLogic.getDiscountAmount(state);
  final youPay = BusinessLogic.getPayableAmount(state);
  final savings = BusinessLogic.getSavings(state);

  print('   Amount: ${service.amount}');
  print('   Quantity: ${service.quantity}');
  print('   Discount %: ${service.discountPercent}');
  print('   Discount Amount: ${discountAmount.toStringAsFixed(2)}');
  print('   You Pay: ${youPay.toStringAsFixed(2)}');
  print('   Savings: ${savings.toStringAsFixed(2)}');
  print('   Is Purchase Disabled: ${service.isPurchaseDisabled}\n');

  // Test 4: Test payment method selection
  print('4. Testing payment method selection...');
  service.selectPaymentMethod('upi');
  print('   Selected payment method: ${service.selectedPaymentMethod}');

  service.selectPaymentMethod('credit_card');
  print('   Selected payment method: ${service.selectedPaymentMethod}\n');

  // Test 5: Test business logic utilities
  print('5. Testing business logic utilities...');
  final validation = BusinessLogic.validateAmount(state);
  print('   Validation result: ${validation.isValid}');
  print('   Validation error: ${validation.errorMessage}');

  final isPayEnabled = BusinessLogic.isPayButtonEnabled(state);
  print('   Pay button enabled: ${isPayEnabled}');

  final payLabel = BusinessLogic.getPayButtonLabel(state);
  print('   Pay button label: ${payLabel}\n');

  // Test 6: Test state management
  print('6. Testing state management...');
  final notifier = DependencyInjection.voucherService;
  print('   Notifier state amount: ${notifier.state.amount}');

  notifier.updateAmount(500.0);
  print('   After update to 500: ${notifier.state.amount}');
  print(
    '   Recalculated you pay: ${notifier.state.youPay.toStringAsFixed(2)}\n',
  );

  print('=== All tests completed successfully! ===');
}

/// Example usage for UI integration
void exampleUIUsage() {
  print('\n=== Example UI Usage ===');

  // Get the service
  final service = DependencyInjection.voucherService;

  // In a real UI, you would:
  // 1. Load voucher data
  service.loadVoucher();

  // 2. Listen to state changes (if using reactive framework)
  // service.state would be observed by UI

  // 3. Update values from user input
  service.updateAmount(1000.0);
  service.updateQuantity(1);
  service.selectPaymentMethod('upi');

  // 4. Display calculated values
  print('UI would display:');
  print('  Amount: ₹${service.amount.toStringAsFixed(0)}');
  print('  You Pay: ₹${service.youPay.toStringAsFixed(0)}');
  print('  Savings: ₹${service.savings.toStringAsFixed(0)}');
  print('  Pay Button: ${service.isPurchaseDisabled ? "DISABLED" : "ENABLED"}');
}
