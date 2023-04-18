import 'package:shoplanner/layers/domain/entities/entity.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_item_entity.dart';

class ShoppingListEntity extends Entity {
  ShoppingListEntity(
      {super.createdAt,
      super.id,
      required this.marketName,
      List<ShoppingListItemEntity>? shoppingListItem}) {
    this.shoppingListItem = shoppingListItem ?? [];
  }

  String marketName;
  late List<ShoppingListItemEntity> shoppingListItem;
}
