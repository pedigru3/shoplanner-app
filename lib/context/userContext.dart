import 'package:flutter/material.dart';

class UserContext extends ChangeNotifier {
  String name = '';
  List shoppingLists = [];

  saveName(String name) {
    if (name != '' && name.length >= 3) {
      this.name = name;
    }
    notifyListeners();
  }

  addList() {}
}
