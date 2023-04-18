import 'package:shoplanner/layers/domain/entities/entity.dart';

class PriceEntity extends Entity {
  PriceEntity({
    required this.value,
    super.id,
    super.createdAt,
  });

  final double value;
}
