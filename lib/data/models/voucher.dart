import 'discount.dart';

class Voucher {
  final String? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final double minAmount;
  final double maxAmount;
  final double? price;
  final bool? isActive;
  final bool? disablePurchase;
  final Discount? discount;
  final List<String>? paymentMethods;

  const Voucher({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    required this.minAmount,
    required this.maxAmount,
    this.price,
    this.isActive,
    this.disablePurchase,
    this.discount,
    this.paymentMethods,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
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
          ? Discount.fromJson(json['discount'] as Map<String, dynamic>)
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Voucher &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.minAmount == minAmount &&
        other.maxAmount == maxAmount &&
        other.price == price &&
        other.isActive == isActive &&
        other.disablePurchase == disablePurchase &&
        other.discount == discount &&
        other.paymentMethods == paymentMethods;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      description,
      imageUrl,
      minAmount,
      maxAmount,
      price,
      isActive,
      disablePurchase,
      discount,
      paymentMethods,
    );
  }

  @override
  String toString() {
    return 'Voucher(id: $id, name: $name, description: $description, minAmount: $minAmount, maxAmount: $maxAmount, discount: $discount)';
  }
}
