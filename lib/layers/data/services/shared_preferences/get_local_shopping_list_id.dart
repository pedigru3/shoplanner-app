import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplanner/layers/presentation/manageres/session_manager.dart';

class GetLocalShoppingListId {
  Future<String?> call() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final authController = GetIt.I.get<SessionManager>();

    final String? savedId =
        prefs.getString('shoppingListId_${authController.token.sub}');
    if (savedId != null) {
      return savedId;
    } else {
      return null;
    }
  }
}
