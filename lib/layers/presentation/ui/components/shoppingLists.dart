import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/presentation/controllers/navigator_controller.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_controller.dart';
import 'package:shoplanner/layers/presentation/ui/components/slider_shopping_list.dart';
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
    if (shoppingListController.shoppingLists.isEmpty) {
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                  height: 100, borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                  height: 100, borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                  height: 100, borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                  height: 100, borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: shoppingListController.shoppingLists.length,
        itemBuilder: (context, index) {
          return SliderShoppingList(
            onDismissed: (shoppingList) async {
              await shoppingListController.deleteShoppingList(shoppingList.id);
            },
            shoppingList: shoppingListController.shoppingLists[index],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    shoppingListController.removeListener(_onShoppingListChange);
    super.dispose();
  }
}
