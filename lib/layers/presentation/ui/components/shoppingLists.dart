import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/presentation/controllers/navigator_controller.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_controller.dart';
import 'package:skeletons/skeletons.dart';

class ShoppingLists extends StatefulWidget {
  const ShoppingLists({super.key});

  @override
  State<ShoppingLists> createState() => _ShoppingListsState();
}

class _ShoppingListsState extends State<ShoppingLists> {
  final shoppingListController = GetIt.I.get<ShoppingListController>();
  final navigatorController = GetIt.I.get<NavigatorController>();

  @override
  void initState() {
    super.initState();
    shoppingListController.addListener(_onShoppingListChange);
  }

  _onShoppingListChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: shoppingListController.findAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView(
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 100, borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ));
        }
        if (snapshot.hasData) {
          final shoppingLists = snapshot.data!;
          return shoppingLists.fold(
              (success) => ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: success.length,
                    itemBuilder: (context, index) {
                      final item = success[index];
                      return GestureDetector(
                        onTap: () {
                          navigatorController.selectIndex(1);
                          navigatorController.pc.animateToPage(
                              navigatorController.selectedIndex,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                          navigatorController
                              .setShoppingListId(success[index].id);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: 200,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.shopping_cart,
                                  size: 50,
                                  color: Colors.red[700],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff8B0100),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${item.createdAt.day}/${item.createdAt.month}/${item.createdAt.year} às ${item.createdAt.hour}h${item.createdAt.minute}',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              (failure) => const Text('erro'));
        }
        return const Text('erro');
      },
    );
  }

  @override
  void dispose() {
    shoppingListController.removeListener(_onShoppingListChange);
    super.dispose();
  }
}
