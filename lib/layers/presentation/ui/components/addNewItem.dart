import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/data/services/currency_ptbr_input_formatter.dart';

import '../../controllers/shopping_list_item_controller.dart';
import '../../controllers/user_controller.dart';
import 'button.dart';
import 'input.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({
    super.key,
    required this.category,
    required this.id,
  });

  final Category category;
  final String id;

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final shoppingListItemsController = GetIt.I.get<ShoppingListItemController>();
  final userController = GetIt.I.get<UserController>();

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  final priceController = TextEditingController();
  final qunatityController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    shoppingListItemsController.addListener(_onItemChange);
  }

  _onItemChange() {
    setState(() {});
  }

  handleClick() async {
    var result = await shoppingListItemsController.create(
      nameController.text,
      qunatityController.text,
      priceController.text,
      widget.category,
      widget.id,
    );
    // snackbar with result in async
    userController.scaffoldKey.currentState?.clearSnackBars();
    userController.scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(result.fold(
          (success) => success.item.comparePrices(),
          (failure) => failure.message,
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _scaffoldKey,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 20, 32, 0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Input(
                    hintText: 'Nome do item',
                    controller: nameController,
                    hasSuggestions: true,
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Flexible(
                  flex: 1,
                  child: Input(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyPtBrInputFormatter(),
                    ],
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
                    hintText: 'Qnt.',
                    controller: qunatityController,
                  ),
                ),
              ],
            ),
            shoppingListItemsController.isLoading
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                    ),
                  )
                : const SizedBox(
                    height: 20,
                  ),
            Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: Button(
                  onPressed: handleClick,
                  label: '+',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    shoppingListItemsController.removeListener(_onItemChange);
    super.dispose();
  }
}
