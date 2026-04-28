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

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Discount &&
        other.id == id &&
        other.name == name &&
        other.percent == percent &&
        other.description == description &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return Object.hash(id, name, percent, description, isActive);
  }

  @override
  String toString() {
    return 'Discount(id: $id, name: $name, percent: $percent, description: $description, isActive: $isActive)';
  }
}
