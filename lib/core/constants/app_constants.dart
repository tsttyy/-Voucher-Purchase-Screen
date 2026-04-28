class AppConstants {
  // Mock data
  static const String mockVoucherJson = '''
  {
    "id": "zepto-100",
    "title": "Zepto Instant Voucher",
    "minAmount": 50,
    "maxAmount": 10000,
    "disablePurchase": false,
    "discounts": [
      { "method": "UPI", "percent": 4 },
      { "method": "CARD", "percent": 4 }
    ],
    "redeemSteps": [
      "Login to Zepto Platform",
      "Click on My profile / Settings",
      "Go to Zepto Cash & Gift Card",
      "Click on Add Card option"
    ]
  }
  ''';

  // Validation messages
  static const String amountRequiredMessage = 'Amount is required';
  static const String minAmountMessage = 'Minimum amount is ₹';
  static const String maxAmountMessage = 'Maximum amount is ₹';
  static const String invalidAmountMessage = 'Please enter a valid amount';

  // UI strings
  static const String referAndEarn = 'Refer & Earn';
  static const String youPay = 'YOU PAY';
  static const String savings = 'SAVINGS';
  static const String paymentMethod = 'Payment Method';
  static const String quantity = 'Quantity';
  static const String redeemSteps = 'Redeem Steps';
  static const String payButton = 'Pay ';
  static const String close = 'Close';
}
