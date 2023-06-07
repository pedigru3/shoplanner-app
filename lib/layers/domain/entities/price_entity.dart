import 'package:shoplanner/layers/domain/entities/entity.dart';

class PriceEntity extends Entity {
  PriceEntity({
    required this.value,
    super.id,
    super.createdAt,
  });

  final double value;

  factory PriceEntity.fromMap(Map<String, dynamic> json) {
    if (json['id'] == null) {
      throw Exception("The 'id' field is missing in the JSON.");
    }
    if (json['value'] == null) {
      throw Exception("The 'value' field is missing in the JSON.");
    }
    if (json['createdAt'] == null) {
      throw Exception("The 'createdAt' field is missing in the JSON.");
    }

    return PriceEntity(
      id: json['id'],
      value: double.parse(json['value']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
