import 'package:shoplanner/layers/data/dtos/price_dto.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';

class ItemDto extends ItemEntity {
  List<PriceDto>? prices;

  ItemDto({
    required super.name,
    required super.category,
    this.prices,
    super.createdAt,
    super.id,
  }) : super(pricesEntity: prices);
}
