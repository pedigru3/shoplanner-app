import 'package:flutter/material.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'categoryButton.dart';

class CategoriesMenu extends StatefulWidget {
  const CategoriesMenu({super.key, required this.onpressed});
  final Function(Category) onpressed;

  @override
  State<CategoriesMenu> createState() => _CategoriesMenuState();
}

class _CategoriesMenuState extends State<CategoriesMenu> {
  final List<Category> categories = [
    Category.Alimentos,
    Category.Higiene,
    Category.Limpeza,
    Category.Utilidades,
    Category.Feira,
    Category.Carnes,
  ];

  Category activetedCategory = Category.Alimentos;

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
                activetedCategory: activetedCategory,
                onSendCategory: (Category value) {
                  setState(() {
                    activetedCategory = value;
                    widget.onpressed(value);
                  });
                },
              );
            }),
      ),
    );
  }
}
