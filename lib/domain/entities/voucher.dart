class Discount {
  final String? id;
  final String? name;
  final double percent;
  final String? description;
  final bool? isActive;

  const Discount({
    this.id,
    this.name,
    required this.percent,
    this.description,
    this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'percent': percent,
      'description': description,
      'isActive': isActive,
    };
  }

  @override
  String toString() => 'Discount(id: $id, name: $name, percent: $percent)';
}

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

  @override
  String toString() =>
      'Voucher(id: $id, name: $name, minAmount: $minAmount, maxAmount: $maxAmount)';
}
