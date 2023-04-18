import 'package:shoplanner/layers/data/dtos/shopping_list_dto.dart';
import 'package:shoplanner/layers/domain/entities/user_entity.dart';

class UserDto extends UserEntity {
  String? img;
  List<ShoppingListDto>? shoppingLists;

  UserDto(
      {required super.name,
      super.id,
      super.createdAt,
      this.img,
      this.shoppingLists})
      : super(
          image: img,
          shoppingListsEntity: shoppingLists,
        );
}
