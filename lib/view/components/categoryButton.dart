import 'package:flutter/material.dart';
import 'package:shoplanner/consts/enumCategories.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton(
      {required this.category,
      Key? key,
      required this.onSendCategory,
      required this.activetedCategory})
      : super(key: key);

  final Category category;
  final Category activetedCategory;
  final void Function(Category) onSendCategory;

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  bool isActivated = false;

  @override
  void initState() {
    super.initState();
    isActivated = widget.category == widget.activetedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: (() {
              widget.onSendCategory(widget.category);
            }),
            style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: isActivated
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceVariant,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                widget.category.name,
                style: TextStyle(
                    color: isActivated
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.primary,
                    fontWeight:
                        isActivated ? FontWeight.bold : FontWeight.normal),
              ),
            ),
          )),
    );
  }

  @override
  void didUpdateWidget(CategoryButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    isActivated = widget.category == widget.activetedCategory;
    setState(() {});
  }
}
