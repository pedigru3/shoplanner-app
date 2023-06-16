import 'package:flutter/material.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_controller.dart';

class AddNewShoppingList extends StatefulWidget {
  const AddNewShoppingList({
    super.key,
    required this.width,
    required this.textController,
    required this.shoopingListController,
  });

  final double width;
  final TextEditingController textController;
  final ShoppingListController shoopingListController;

  @override
  State<AddNewShoppingList> createState() => _AddNewShoppingListState();
}

class _AddNewShoppingListState extends State<AddNewShoppingList> {
  @override
  void initState() {
    super.initState();
    widget.shoopingListController.addListener(_onChange);
  }

  _onChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: widget.width * 0.65,
              child: TextField(
                controller: widget.textController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(20))),
                  hintText: 'Criar nova lista',
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: widget.width * 0.17,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (widget.textController.text != '') {
                    FocusManager.instance.primaryFocus?.unfocus();
                    await widget.shoopingListController
                        .createShoppingList(widget.textController.text);
                    widget.textController.text = '';
                    setState(() {});
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Nome não inserido'),
                          content: const Text('Por favor, insira um nome.'),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('+'),
              ),
            )
          ],
        ),
        widget.shoopingListController.isLoading
            ? const Padding(
                padding: EdgeInsets.only(top: 5.0, right: 10, left: 10),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                ),
              )
            : const SizedBox()
      ],
    );
  }

  @override
  void dispose() {
    widget.shoopingListController.removeListener(_onChange);
    super.dispose();
  }
}
