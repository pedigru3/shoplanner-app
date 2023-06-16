import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_exception.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_usecase/shopping_list_usecase.dart';
import 'package:shoplanner/layers/presentation/manageres/session_manager.dart';

class ShoppingListController extends ChangeNotifier {
  final ShoppingListUseCase shoppingListUsecase;

  ShoppingListController(this.shoppingListUsecase) {
    fetchAllShoppingLists();
  }

  final _sessionManager = GetIt.I.get<SessionManager>();

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
    shoppingListUsecase.create(name);
    notifyListeners();
  }

  deleteShoppingList(String id) async {
    shoppingLists.removeWhere((element) => element.id == id);
    if (_sessionManager.shoppingListId == id) {
      ShoppingListEntity lastItem = shoppingLists.first;
      _sessionManager.setShoppingListId(lastItem.id);
    }
    await shoppingListUsecase.delete(id);
    notifyListeners();
  }
}
