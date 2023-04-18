import 'package:shoplanner/layers/domain/entities/entity.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';

class UserEntity extends Entity {
  UserEntity(
      {super.createdAt,
      super.id,
      this.image,
      required this.name,
      this.shoppingListsEntity});

  String name;
  String? image;
  List<ShoppingListEntity>? shoppingListsEntity;
}
