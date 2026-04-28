import 'dart:convert';
import '../models/voucher_model.dart';

/// Abstract data source interface
abstract class VoucherLocalDataSource {
  Future<VoucherModel> getVoucher(String voucherId);
}

/// Concrete implementation using mock JSON
class VoucherLocalDataSourceImpl implements VoucherLocalDataSource {
  final String mockData;

  VoucherLocalDataSourceImpl({required this.mockData});

  @override
  Future<VoucherModel> getVoucher(String voucherId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final Map<String, dynamic> jsonData = jsonDecode(mockData);
      return VoucherModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to parse voucher data: $e');
    }
  }

  // Mock JSON data for testing
  static const String defaultMockData = '''
  {
    "id": "voucher_001",
    "name": "Amazon Gift Card",
    "description": "Get amazing discounts on Amazon purchases",
    "imageUrl": "https://example.com/amazon.jpg",
    "minAmount": 100.0,
    "maxAmount": 10000.0,
    "price": null,
    "isActive": true,
    "disablePurchase": false,
    "discount": {
      "id": "discount_001",
      "name": "Special Discount",
      "percent": 10.0,
      "description": "10% off on all purchases",
      "isActive": true
    },
    "paymentMethods": ["credit_card", "debit_card", "upi", "net_banking"]
  }
  ''';
}
