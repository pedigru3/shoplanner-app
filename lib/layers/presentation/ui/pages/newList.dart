import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/data/services/currency_ptbr_input_formatter.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:shoplanner/layers/presentation/manageres/session_manager.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_controller.dart';
import 'package:shoplanner/layers/presentation/ui/components/itemsLoading.dart';
import 'package:shoplanner/layers/presentation/ui/components/sliders_items.dart';
import 'package:skeletons/skeletons.dart';
import '../../controllers/shopping_list_item_controller.dart';
import '../components/CurvedBackground.dart';
import '../components/categories.dart';
import '../components/header.dart';

class NewList extends StatefulWidget {
  const NewList({super.key});

  @override
  State<NewList> createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  final shoppingListItemController = GetIt.I.get<ShoppingListItemController>();
  final shoppingListController = GetIt.I.get<ShoppingListController>();
  final authController = GetIt.I.get<SessionManager>();

  final nameOfListController = TextEditingController();

  @override
  void initState() {
    super.initState();
    shoppingListController.addListener(_onShoppingListChange);
    shoppingListItemController.addListener(_onShoppingListChange);
  }

  void _onShoppingListChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (shoppingListItemController.currentShoppingList != null) {
          nameOfListController.text =
              shoppingListItemController.currentShoppingList!.name;
          return shopScreen(
              context: context,
              mylist: shoppingListItemController.currentShoppingList,
              isKeyboardVisible: isKeyboardVisible);
        }
        if (shoppingListItemController.error != null) {
          return shopScreen(
              context: context, isKeyboardVisible: isKeyboardVisible);
        }
        return Center(
          child: shopScreen(
              context: context, isKeyboardVisible: isKeyboardVisible),
        );
      },
    );
  }

  Column shopScreen({
    required BuildContext context,
    required bool isKeyboardVisible,
    ShoppingListEntity? mylist,
  }) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !isKeyboardVisible
            ? Stack(
                children: [
                  const CurvedBG(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SafeArea(
                          child: Header(
                              text1: 'Olá,', text2: authController.token.name),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          children: [
                            mylist != null
                                ? Text('Essa é sua lista de compras.',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge)
                                : const SkeletonLine(
                                    style: SkeletonLineStyle(width: 220),
                                  ),
                            mylist != null
                                ? RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: 'Atualmente no valor de: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      // com bold
                                      TextSpan(
                                        text:
                                            'R\$: ${TextFormatter.priceFormat(mylist.getTotal())}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                  )
                                : const SkeletonLine(
                                    style: SkeletonLineStyle(
                                        padding: EdgeInsets.only(top: 4),
                                        width: 280),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            : SafeArea(
                child: Container(),
              ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: mylist != null
                    ? TextField(
                        onEditingComplete: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await shoppingListController.updateShoppingList(
                              mylist.id, nameOfListController.text);
                        },
                        controller: nameOfListController,
                        style: Theme.of(context).textTheme.headlineMedium,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: -20),
                            border: InputBorder.none,
                            hintText: 'Nome da sua lista',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.grey)),
                      )
                    : const SkeletonItem(
                        child: SkeletonLine(
                          style: SkeletonLineStyle(width: 200, height: 30),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                child: CategoriesMenu(
                  onpressed: ((category) {
                    shoppingListItemController.setCategory(category);
                  }),
                ),
              ),
              mylist != null
                  ? Expanded(
                      child: SlidersItems(
                      shoppingList: mylist,
                    ))
                  : ItemsLoading(width: width)
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    shoppingListController.removeListener(_onShoppingListChange);
    shoppingListItemController.removeListener(_onShoppingListChange);
    super.dispose();
  }
}
