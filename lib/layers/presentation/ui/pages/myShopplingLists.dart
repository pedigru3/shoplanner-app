import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/presentation/controllers/shopping_list_controller.dart';
import 'package:shoplanner/layers/presentation/ui/components/shoppingLists.dart';
import '../components/header.dart';

class MyShoppinglists extends StatelessWidget {
  const MyShoppinglists({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final shoopingListController = GetIt.I.get<ShoppingListController>();

    final textController = TextEditingController();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Header(
              text1: 'Minhas',
              text2: 'Compras',
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: ShoppingLists(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.65,
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20))),
                        hintText: 'Criar nova lista',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: width * 0.17,
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
                        if (textController.text != '') {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await shoopingListController
                              .createShoppingList(textController.text);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Nome não inserido'),
                                content:
                                    const Text('Por favor, insira um nome.'),
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
            )
          ],
        ),
      ),
    );
  }
}
