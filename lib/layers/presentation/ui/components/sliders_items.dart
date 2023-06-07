import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_controller.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_item_controller.dart';
import 'package:shoplanner/layers/presentation/ui/components/addNewItem.dart';
import 'package:shoplanner/layers/presentation/ui/components/slider_item.dart';

import '../../controllers/user_controller.dart';

class SlidersItems extends StatefulWidget {
  const SlidersItems({super.key, required this.shoppingList});
  final ShoppingListEntity shoppingList;

  @override
  State<SlidersItems> createState() => _SlidersItemsState();
}

class _SlidersItemsState extends State<SlidersItems> {
  final userController = GetIt.I.get<UserController>();
  final shoppingListController = GetIt.I.get<ShoppingListController>();
  final shoppingListItemsController = GetIt.I.get<ShoppingListItemController>();

  @override
  void initState() {
    super.initState();
    shoppingListItemsController.addListener(_onShoppingListItemsChange);
  }

  void _onShoppingListItemsChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = widget.shoppingList.shoppingListItems
        .where((element) =>
            element.item.category == shoppingListItemsController.category)
        .toList();

    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        physics: const BouncingScrollPhysics(),
        itemCount: filteredList.length + 1,
        itemBuilder: (context, index) {
          return index == filteredList.length
              ? AddNewItem(
                  id: widget.shoppingList.id,
                  category: shoppingListItemsController.category,
                )
              : SliderItem(
                  shoppingListItem: filteredList[index],
                  onDismissed: (item) async {
                    filteredList
                        .removeWhere((element) => element.id == item.id);
                    await shoppingListItemsController.delete(item.id);
                  },
                );
        });
  }

  @override
  void dispose() {
    shoppingListItemsController.removeListener(_onShoppingListItemsChange);
    super.dispose();
  }
}
