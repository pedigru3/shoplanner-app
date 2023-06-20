import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/data/services/currency_ptbr_input_formatter.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_item_entity.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_item_exception.dart';
import 'package:shoplanner/layers/domain/errors/shoppint_lits_item_create_error.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_item_usecase/shopping_list_item_usecase.dart';
import 'package:shoplanner/layers/presentation/manageres/session_manager.dart';
import '../../domain/usecases/shopping_list_usecase/shopping_list_usecase.dart';

class ShoppingListItemController extends ChangeNotifier {
  final ShoppingListItemUseCase shoppingListItemUsecase;
  final ShoppingListUseCase shoppingListUsecase;

  final _sessionManager = GetIt.I.get<SessionManager>();

  ShoppingListItemController(
      this.shoppingListItemUsecase, this.shoppingListUsecase) {
    fetchCurrentShoppingList();
  }

  ShoppingListItemException? shoppingListItemException;
  bool isLoading = false;

  ShoppingListEntity? currentShoppingList;
  Exception? error;

  Category category = Category.Alimentos;

  setCategory(Category category) {
    this.category = category;
    notifyListeners();
  }

  Future<void> fetchCurrentShoppingList() async {
    if (currentShoppingList != null) {
      currentShoppingList = null;
      notifyListeners();
    }
    return await shoppingListUsecase
        .fetchById(_sessionManager.shoppingListId)
        .fold(
      (success) {
        currentShoppingList = success;
        notifyListeners();
      },
      (exception) {
        error = exception;
        notifyListeners();
      },
    );
  }

  Future<void> delete(String id) async {
    currentShoppingList?.shoppingListItems
        .removeWhere((element) => (element.id == id));
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
    String shoppingListId,
  ) async {
    isLoading = true;
    notifyListeners();

    if (name.isEmpty) {
      return Failure(ShoppingListItemCreateError('Nome não pode ser vazio'));
    }
    var result = await shoppingListItemUsecase.create(
      name: name,
      quantity: TextFormatter.cleanText(quantity),
      price: TextFormatter.cleanText(price),
      category: category,
      shoppingListId: shoppingListId,
    );
    currentShoppingList?.shoppingListItems.add(result.getOrThrow());
    isLoading = false;
    notifyListeners();
    return result;
  }

  AsyncResult<ShoppingListItemEntity, ShoppingListItemException> update({
    required String id,
    String? name,
    String? quantity,
    String? price,
  }) async {
    (String, Category)? item;

    if (name != null) {
      item = (name, category);
    }

    var shoppingListItemResult = await shoppingListItemUsecase.update(
      id: id,
      item: item,
      quantity: quantity != null ? TextFormatter.cleanText(quantity) : null,
      price: price != null ? TextFormatter.cleanText(price) : null,
    );

    ShoppingListItemEntity? shoppingListItem =
        shoppingListItemResult.getOrNull();

    if (shoppingListItem != null) {
      int index = currentShoppingList!.shoppingListItems
          .indexWhere((element) => element.id == id);
      currentShoppingList?.shoppingListItems
          .replaceRange(index, index + 1, [shoppingListItem]);
    }

    notifyListeners();
    return shoppingListItemResult;
  }
}
