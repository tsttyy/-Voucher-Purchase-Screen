import '../../domain/entities/voucher.dart';

class VoucherModel extends Voucher {
  VoucherModel({
    super.id,
    super.name,
    super.description,
    super.imageUrl,
    required super.minAmount,
    required super.maxAmount,
    super.price,
    super.isActive,
    super.disablePurchase,
    super.discount,
    super.paymentMethods,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      minAmount: (json['minAmount'] as num).toDouble(),
      maxAmount: (json['maxAmount'] as num).toDouble(),
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      isActive: json['isActive'] as bool?,
      disablePurchase: json['disablePurchase'] as bool?,
      discount: json['discount'] != null
          ? DiscountModel.fromJson(json['discount'] as Map<String, dynamic>)
          : null,
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'minAmount': minAmount,
      'maxAmount': maxAmount,
      'price': price,
      'isActive': isActive,
      'disablePurchase': disablePurchase,
      'discount': discount?.toJson(),
      'paymentMethods': paymentMethods,
    };
  }
}

class DiscountModel extends Discount {
  const DiscountModel({
    super.id,
    super.name,
    required super.percent,
    super.description,
    super.isActive,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      percent: (json['percent'] as num).toDouble(),
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'percent': percent,
      'description': description,
      'isActive': isActive,
    };
  }
}
