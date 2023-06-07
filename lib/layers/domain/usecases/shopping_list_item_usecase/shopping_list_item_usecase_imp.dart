import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_item_exception.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_item_entity.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_item_usecase/shopping_list_item_usecase.dart';
import '../../repositories/shopping_list_item_repository.dart';

class ShoppingListItemUseCaseImp extends ShoppingListItemUseCase {
  final ShoppingListItemRepository shoppingListItemRepository;

  ShoppingListItemUseCaseImp(
    this.shoppingListItemRepository,
  );

  @override
  AsyncResult<ShoppingListItemEntity, ShoppingListItemException> create(
      {required String name,
      required double quantity,
      required double price,
      required Category category,
      required String shoppingListId}) async {
    return await shoppingListItemRepository.create(
        name: name,
        quantity: quantity,
        price: price,
        category: category,
        shoppingListId: shoppingListId);
  }

  @override
  AsyncResult<bool, ShoppingListItemException> delete(String id) {
    return shoppingListItemRepository.delete(id);
  }

  @override
  AsyncResult<bool, ShoppingListItemException> update(
      {required String id,
      (String name, Category category)? item,
      double? quantity,
      double? price}) async {
    return shoppingListItemRepository.update(
        id: id, item: item, quantity: quantity, price: price);
  }

  @override
  AsyncResult<Iterable<ItemEntity>, ShoppingListItemException> searchByName(
      String name) {
    return shoppingListItemRepository.searchByName(name);
  }
}
