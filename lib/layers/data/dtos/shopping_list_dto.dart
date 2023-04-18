import 'package:shoplanner/layers/data/dtos/shopping_list_item_dto.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';

class ShoppingListDto extends ShoppingListEntity {
  String name;
  List<ShoppingListItemDto>? shoppingListItems;

  ShoppingListDto(
      {required this.name, this.shoppingListItems, super.createdAt, super.id})
      : super(marketName: name, shoppingListItem: shoppingListItems);
}
