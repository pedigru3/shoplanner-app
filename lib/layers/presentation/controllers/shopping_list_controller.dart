import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_exception.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_usecase/shopping_list_usecase.dart';

class ShoppingListController extends ChangeNotifier {
  final ShoppingListUseCase shoppingListUsecase;

  ShoppingListController(this.shoppingListUsecase) {
    fetchAllShoppingLists();
  }

  List<ShoppingListEntity> shoppingLists = [];
  ShoppingListException? error;

  Future<void> fetchAllShoppingLists() async {
    return await shoppingListUsecase.fetchAll().fold(
      (success) {
        shoppingLists = success;
        notifyListeners();
      },
      (error) {
        this.error = error;
        notifyListeners();
      },
    );
  }

  updateShoppingList(String id, String name) {
    shoppingListUsecase.update(id, name);
    notifyListeners();
  }

  createShoppingList(String name) async {
    await shoppingListUsecase.create(name);
    notifyListeners();
  }

  deleteShoppingList(String id) async {
    await shoppingListUsecase.delete(id);
    notifyListeners();
  }
}
