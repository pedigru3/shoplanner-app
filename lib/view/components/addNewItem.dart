import 'package:flutter/material.dart';
import 'package:shoplanner/consts/enumCategories.dart';

import 'button.dart';
import 'input.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({
    super.key,
    required this.category,
    this.onPressed,
  });

  final Category category;
  final void Function(Map)? onPressed;

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final priceController = TextEditingController();
  final qunatityController = TextEditingController();
  final nameController = TextEditingController();

  handleClick() {
    final newItem = {
      'name': nameController.text,
      'price': priceController.text,
      'quantity': qunatityController.text,
      'category': widget.category
    };
    if (widget.onPressed != null) {
      widget.onPressed!(newItem);
    }
    return newItem;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Input(
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
            const SizedBox(height: 40),
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
}
