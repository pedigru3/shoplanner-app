import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_item_controller.dart';
import '../../controllers/user_controller.dart';
import 'categoryButton.dart';

class CategoriesMenu extends StatefulWidget {
  const CategoriesMenu({super.key, required this.onpressed});
  final Function(Category) onpressed;

  @override
  State<CategoriesMenu> createState() => _CategoriesMenuState();
}

class _CategoriesMenuState extends State<CategoriesMenu> {
  final shoppingListItemController = GetIt.I.get<ShoppingListItemController>();

  final List<Category> categories = [
    Category.Alimentos,
    Category.Higiene,
    Category.Limpeza,
    Category.Utilidades,
    Category.Feira,
    Category.Carnes,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryButton(
                category: categories[index],
                activetedCategory: shoppingListItemController.category,
                onSendCategory: (Category value) {
                  shoppingListItemController.setCategory(value);
                  setState(() {
                    widget.onpressed(value);
                  });
                },
              );
            }),
      ),
    );
  }
}
