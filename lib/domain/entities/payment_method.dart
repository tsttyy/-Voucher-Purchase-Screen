enum PaymentMethod {
  creditCard('credit_card', 'Credit Card'),
  debitCard('debit_card', 'Debit Card'),
  upi('upi', 'UPI'),
  netBanking('net_banking', 'Net Banking');

  const PaymentMethod(this.value, this.displayName);

  final String value;
  final String displayName;

  static PaymentMethod fromString(String value) {
    return PaymentMethod.values.firstWhere(
      (method) => method.value == value,
      orElse: () => PaymentMethod.creditCard,
    );
  }
}
