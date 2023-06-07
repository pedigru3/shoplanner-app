import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_exception.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_usecase/shopping_list_usecase.dart';

class ShoppingListController extends ChangeNotifier {
  final ShoppingListUseCase shoppingListItemUsecase;

  ShoppingListController(this.shoppingListItemUsecase);

  AsyncResult<ShoppingListEntity, ShoppingListException> findById(
      String id) async {
    return await shoppingListItemUsecase.fetchById(id);
  }

  AsyncResult<List<ShoppingListEntity>, ShoppingListException> findAll() async {
    return await shoppingListItemUsecase.fetchAll();
  }

  update(String id, String name) {
    shoppingListItemUsecase.update(id, name);
    notifyListeners();
  }

  create(String name) async {
    await shoppingListItemUsecase.create(name);
    notifyListeners();
  }

  delete(String id) async {
    await shoppingListItemUsecase.delete(id);
    notifyListeners();
  }
}
