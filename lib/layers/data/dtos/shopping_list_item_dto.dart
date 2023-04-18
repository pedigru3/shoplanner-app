import 'package:shoplanner/layers/data/dtos/item_dto.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_item_entity.dart';

class ShoppingListItemDto extends ShoppingListItemEntity {
  ItemDto item;

  ShoppingListItemDto(
      {required this.item,
      required super.quantity,
      required super.currentPrice,
      super.createdAt,
      super.id})
      : super(itemEntity: item);
}
