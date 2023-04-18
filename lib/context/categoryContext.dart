import 'package:flutter/material.dart';
import 'package:shoplanner/consts/enumCategories.dart';

class CategoryContext extends ChangeNotifier {
  Category currentCategory = Category.Alimentos;

  setCategory(Category category) {
    currentCategory = category;
    notifyListeners();
  }
}
