import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/presentation/manageres/session_manager.dart';
import 'package:shoplanner/layers/presentation/controllers/navigator_controller.dart';
import 'package:shoplanner/layers/presentation/controllers/user_controller.dart';
import 'package:shoplanner/layers/presentation/ui/components/perfil_avatar.dart';
import 'package:shoplanner/layers/presentation/ui/pages/initialPage.dart';

import '../components/customNavigationBar.dart';
import '../components/customNavigationBarItem.dart';
import 'myShopplingLists.dart';
import 'newList.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final userController = GetIt.I.get<UserController>();
  final navigatorController = GetIt.I.get<NavigatorController>();
  final nameController = TextEditingController();
  final sessionManager = GetIt.I.get<SessionManager>();

  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = navigatorController.pc;
    navigatorController.addListener(_onPageChanges);
  }

  _onPageChanges() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      navigatorController.selectIndex(index);
      pc.animateToPage(navigatorController.selectedIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }

    return ScaffoldMessenger(
      key: userController.scaffoldKey,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                  accountEmail: GestureDetector(
                    onTap: () async {
                      sessionManager.logOut().then(
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const InitialPage(),
                              ),
                            ),
                          );
                    },
                    child: const Text('Sair'),
                  ),
                  accountName: Text(sessionManager.token.name),
                  currentAccountPicture: PerfilAvatar(
                    url: sessionManager.token.avatarUrl,
                  )),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pc,
          onPageChanged: (value) => navigatorController.selectIndex(value),
          children: const [
            MyShoppinglists(),
            NewList(),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(
          items: const [
            CustomNavigationBarItem(
              iconData: Icons.list,
              label: 'Minhas compras',
            ),
            CustomNavigationBarItem(
                iconData: Icons.check_circle_outline_outlined,
                label: 'Minha lista'),
          ],
          onItemSelected: _onItemTapped,
          currentIndex: navigatorController.selectedIndex,
        ),
      ),
    );
  }

  @override
  void dispose() {
    navigatorController.removeListener(_onPageChanges);
    super.dispose();
  }
}
