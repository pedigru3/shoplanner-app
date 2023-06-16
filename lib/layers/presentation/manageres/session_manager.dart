import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplanner/layers/data/services/provider_auth.dart';
import 'package:shoplanner/layers/data/services/shared_preferences/get_local_shopping_list_id.dart';
import 'package:shoplanner/layers/data/services/shared_preferences/save_local_shopping_list_id.dart';
import 'package:shoplanner/layers/domain/entities/token_entity.dart';
import 'package:shoplanner/layers/domain/usecases/shopping_list_usecase/shopping_list_usecase.dart';

class SessionManager extends ChangeNotifier {
  SessionManager(this.shoppingListUseCase) {
    authInit();
    getCurrentShoppingListId();
  }

  ShoppingListUseCase shoppingListUseCase;
  final saveLocalShoppingList = SaveLocalShoppingListId();

  bool isAuthenticated = false;
  bool isLoading = false;

  late TokenEntity token;
  late String shoppingListId;

  Future<void> authInit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? salvedToken = prefs.getString('token');

    if (salvedToken != null) {
      //verifica se o token ainda é válido
      final hasExpired = JwtDecoder.isExpired(salvedToken);
      if (hasExpired) {
        await prefs.remove('token');
        return;
      }

      Map<String, dynamic> decodedToken = JwtDecoder.decode(salvedToken);

      token = TokenEntity.fromMap(decodedToken);
      isAuthenticated = !hasExpired;
      notifyListeners();
    }
  }

  Future<void> getCurrentShoppingListId() async {
    final getLocalShoppingListId = GetLocalShoppingListId();
    shoppingListId =
        await getLocalShoppingListId() ?? await getFirstShoppiListId();
    saveLocalShoppingList(shoppingListId);
    notifyListeners();
  }

  Future<String> getFirstShoppiListId() async {
    final shoppingLists = await shoppingListUseCase.fetchAll().getOrThrow();
    return shoppingLists[0].id;
  }

  ///Use this with fecthCurrentList in ShoppingListItem
  void setShoppingListId(String value) {
    saveLocalShoppingList(value);
    shoppingListId = value;
    notifyListeners();
  }

  Future<bool> login(ProviderAuth providerAuth) async {
    isLoading = true;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Verifica se já tem o token antes de prosseguir
    if (isAuthenticated) {
      isLoading = false;
      notifyListeners();
      return isAuthenticated;
    }

    final newToken = await providerAuth.handleSignIn();

    // guardar token com sharedPreference
    await prefs.setString('token', newToken);
    final hasExpired = JwtDecoder.isExpired(newToken);
    Map<String, dynamic> decodedToken = JwtDecoder.decode(newToken);
    token = TokenEntity.fromMap(decodedToken);
    isAuthenticated = !hasExpired;
    isLoading = false;
    notifyListeners();
    return !hasExpired;
  }

  logOut() async {
    isLoading = true;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    isAuthenticated = false;
    isLoading = false;
    notifyListeners();
  }
}
