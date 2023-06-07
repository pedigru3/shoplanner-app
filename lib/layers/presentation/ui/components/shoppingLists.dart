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
    return FutureBuilder(
      future: shoppingListController.findAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
                      return SliderShoppingList(
                        onDismissed: (shoppingList) async {
                          await shoppingListController.delete(shoppingList.id);
                        },
                        shoppingList: success[index],
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
