import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/presentation/manageres/session_manager.dart';

class NavigatorController extends ChangeNotifier {
  final sessionManager = GetIt.I.get<SessionManager>();

  NavigatorController() {
    pc = PageController(initialPage: selectedIndex);
  }

  int selectedIndex = 1;

  late PageController pc;

  selectIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }
}
