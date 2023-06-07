import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_item_entity.dart';
import 'package:shoplanner/layers/presentation/ui/components/itemAdded.dart';

class SliderItem extends StatelessWidget {
  const SliderItem({
    Key? key,
    required this.onDismissed,
    required this.shoppingListItem,
  }) : super(key: key);

  final ShoppingListItemEntity shoppingListItem;
  final Function(ShoppingListItemEntity) onDismissed;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(shoppingListItem.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onDismissed(shoppingListItem);
            },
            backgroundColor: Colors.transparent,
            foregroundColor: const Color(0xFFFE4A49),
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ItemAdded(
          category: Category.Alimentos, shoppingListItem: shoppingListItem),
    );
  }
}
