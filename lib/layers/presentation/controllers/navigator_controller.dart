import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_controller.dart';

class NavigatorController extends ChangeNotifier {
  NavigatorController() {
    pc = PageController(initialPage: selectedIndex);
    initial();
  }

  int selectedIndex = 1;
  String shoppingListId = '';

  late PageController pc;

  initial() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedId = prefs.getString('shoppingListId');
    if (savedId != null) {
      shoppingListId = savedId;
      notifyListeners();
    } else {
      final shoopingListController = GetIt.I.get<ShoppingListController>();
      final allList = await shoopingListController.findAll().getOrThrow();
      setShoppingListId(allList[0].id);
    }
  }

  setShoppingListId(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    shoppingListId = id;
    await prefs.setString('shoppingListId', id);
    notifyListeners();
  }

  selectIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }
}
