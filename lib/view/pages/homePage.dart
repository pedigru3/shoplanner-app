import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shoplanner/context/userContext.dart';

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
  late UserContext userRepository;
  final nameController = TextEditingController();
  int _selectedIndex = 1;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    userRepository = context.watch<UserContext>();

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
      pc.animateToPage(_selectedIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }

    return Scaffold(
        body: PageView(
          controller: pc,
          onPageChanged: (value) => setState(() {
            _selectedIndex = value;
          }),
          children: [
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
                iconData: Icons.add_circle_outline, label: 'Nova lista'),
          ],
          onItemSelected: _onItemTapped,
          currentIndex: _selectedIndex,
        ));
  }
}
