import 'package:shoplanner/layers/domain/entities/entity.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';

class ShoppingListItemEntity extends Entity {
  ShoppingListItemEntity(
      {super.createdAt,
      super.id,
      required this.itemEntity,
      required this.quantity,
      required this.currentPrice}) {
    itemEntity.setPrice = currentPrice;
  }

  late ItemEntity itemEntity;
  double currentPrice;
  double quantity;

  get total => currentPrice * quantity;
}
