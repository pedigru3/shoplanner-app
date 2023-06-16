import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_controller.dart';
import 'package:shoplanner/layers/presentation/ui/components/addNewShoppingList.dart';
import 'package:shoplanner/layers/presentation/ui/components/shoppingLists.dart';
import '../components/header.dart';

class MyShoppinglists extends StatelessWidget {
  const MyShoppinglists({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final shoopingListController = GetIt.I.get<ShoppingListController>();

    final textController = TextEditingController();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Header(
              text1: 'Minhas',
              text2: 'Compras',
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: ShoppingLists(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AddNewShoppingList(
                width: width,
                textController: textController,
                shoopingListController: shoopingListController,
              ),
            )
          ],
        ),
      ),
    );
  }
}
