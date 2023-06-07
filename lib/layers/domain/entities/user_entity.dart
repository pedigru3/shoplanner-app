import 'package:shoplanner/layers/domain/entities/entity.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';

class UserEntity extends Entity {
  UserEntity(
      {super.createdAt,
      super.id,
      this.image,
      required this.name,
      this.shoppingLists});
  String name;
  String? image;
  List<ShoppingListEntity>? shoppingLists;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'id': id,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
