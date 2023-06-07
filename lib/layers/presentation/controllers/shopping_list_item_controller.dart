import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_item_entity.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_item_exception.dart';
import 'package:shoplanner/layers/domain/errors/shoppint_lits_item_create_error.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_item_usecase/shopping_list_item_usecase.dart';

class ShoppingListItemController extends ChangeNotifier {
  final ShoppingListItemUseCase shoppingListItemUsecase;

  ShoppingListItemController(this.shoppingListItemUsecase);

  Category category = Category.Alimentos;

  setCategory(Category category) {
    this.category = category;
    notifyListeners();
  }

  delete(String id) async {
    await shoppingListItemUsecase.delete(id);
    notifyListeners();
  }

  AsyncResult<Iterable<ItemEntity>, ShoppingListItemException> search(
      String name) async {
    return await shoppingListItemUsecase.searchByName(name);
  }

  AsyncResult<ShoppingListItemEntity, ShoppingListItemException> create(
      String name,
      String quantity,
      String price,
      Category category,
      String shoppingListId) async {
    if (name.isEmpty) {
      return Failure(ShoppingListItemCreateError('Nome não pode ser vazio'));
    }
    var result = await shoppingListItemUsecase.create(
      name: name,
      quantity: double.tryParse(quantity) ?? 0,
      price: double.tryParse(price) ?? 0,
      category: category,
      shoppingListId: shoppingListId,
    );
    notifyListeners();
    return result;
  }

  AsyncResult<bool, ShoppingListItemException> update({
    required String id,
    String? name,
    String? quantity,
    String? price,
  }) async {
    (String, Category)? item;

    if (name != null) {
      item = (name, category);
    }

    var result = await shoppingListItemUsecase.update(
      id: id,
      item: item,
      quantity: quantity != null ? double.tryParse(quantity) : null,
      price: price != null ? double.parse(price) : null,
    );
    notifyListeners();
    return result;
  }
}
