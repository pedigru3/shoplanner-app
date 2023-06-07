import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_item_entity.dart';

import '../../controllers/shopping_list_item_controller.dart';
import 'input.dart';

class ItemAdded extends StatefulWidget {
  const ItemAdded({
    super.key,
    required this.category,
    this.onPressed,
    required this.shoppingListItem,
  });

  final ShoppingListItemEntity shoppingListItem;
  final Category category;
  final void Function(Map)? onPressed;

  @override
  State<ItemAdded> createState() => _ItemAddedState();
}

class _ItemAddedState extends State<ItemAdded> {
  final shoppingListItemController = GetIt.I.get<ShoppingListItemController>();

  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.shoppingListItem.item.name;
    priceController.text =
        widget.shoppingListItem.currentPrice.value.toStringAsFixed(2);
    quantityController.text = widget.shoppingListItem.quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Input(
                hasSuggestions: true,
                onChanged: () async {
                  await shoppingListItemController.update(
                      id: widget.shoppingListItem.id,
                      name: nameController.text);
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                hintText: 'Nome do item',
                controller: nameController,
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Flexible(
              flex: 1,
              child: Input(
                onChanged: () async {
                  await shoppingListItemController.update(
                      id: widget.shoppingListItem.id,
                      price: priceController.text);
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                hintText: 'Preço',
                controller: priceController,
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Flexible(
              flex: 1,
              child: Input(
                onChanged: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await shoppingListItemController.update(
                      id: widget.shoppingListItem.id,
                      quantity: quantityController.text);
                },
                hintText: 'Qnt.',
                controller: quantityController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
