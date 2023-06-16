import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:shoplanner/layers/presentation/controllers/navigator_controller.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_controller.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_item_controller.dart';
import 'package:shoplanner/layers/presentation/manageres/session_manager.dart';

class SliderShoppingList extends StatelessWidget {
  const SliderShoppingList({
    Key? key,
    required this.onDismissed,
    required this.shoppingList,
  }) : super(key: key);

  final ShoppingListEntity shoppingList;
  final Function(ShoppingListEntity) onDismissed;

  @override
  Widget build(BuildContext context) {
    final navigatorController = GetIt.I.get<NavigatorController>();
    final shoppingListItemController =
        GetIt.I.get<ShoppingListItemController>();
    final sessionManager = GetIt.I.get<SessionManager>();

    return Slidable(
      key: ValueKey(shoppingList.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onDismissed(shoppingList);
            },
            backgroundColor: Colors.transparent,
            foregroundColor: const Color(0xFFFE4A49),
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () async {
          navigatorController.selectIndex(1);
          navigatorController.pc.animateToPage(
              navigatorController.selectedIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
          sessionManager.setShoppingListId(shoppingList.id);
          await shoppingListItemController.fetchCurrentShoppingList();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
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
                    shoppingList.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8B0100),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${shoppingList.createdAt.day}/${shoppingList.createdAt.month}/${shoppingList.createdAt.year} às ${shoppingList.createdAt.hour}h${shoppingList.createdAt.minute}',
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
      ),
    );
  }
}
