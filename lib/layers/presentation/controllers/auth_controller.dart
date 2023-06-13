import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplanner/layers/data/services/provider_auth.dart';
import 'package:shoplanner/layers/domain/entities/token_entity.dart';
import 'package:shoplanner/layers/domain/entities/user_entity.dart';

class AuthController extends ChangeNotifier {
  UserEntity? _user;
  bool isAuthenticated = false;
  late TokenEntity token;
  bool isLoading = false;

  AuthController() {
    initialWithMainToTryAuthenticate();
  }

  Future<void> initialWithMainToTryAuthenticate() async {
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

  UserEntity? get user => _user;

  String get userId => _user?.id ?? '';

  void setUser(UserEntity user) {
    _user = user;
  }
}
