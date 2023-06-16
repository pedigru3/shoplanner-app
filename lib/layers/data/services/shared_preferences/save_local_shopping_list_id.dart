import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplanner/layers/presentation/manageres/session_manager.dart';

class SaveLocalShoppingListId {
  Future<void> call(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final authController = GetIt.I.get<SessionManager>();
    prefs.setString('shoppingListId_${authController.token.sub}', value);
  }
}
