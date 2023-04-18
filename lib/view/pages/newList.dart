import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/context/userContext.dart';
import '../components/CurvedBackground.dart';
import '../components/addNewItem.dart';
import '../components/categories.dart';
import '../components/header.dart';

class NewList extends StatefulWidget {
  const NewList({super.key});

  @override
  State<NewList> createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  Category activatedCategory = Category.Higiene;

  @override
  Widget build(BuildContext context) {
    final userRepository = context.watch<UserContext>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            const CurvedBG(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Header(
                      text1: 'Olá,',
                      text2: userRepository.name,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    children: [
                      Text(
                        'Essa é sua lista de compras.',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Atualmente no valor de: R\$: 23,00',
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: TextField(
                  style: Theme.of(context).textTheme.headline2,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: -20),
                      border: InputBorder.none,
                      hintText: 'Shoplanner 1',
                      hintStyle: Theme.of(context).textTheme.headline2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                child: CategoriesMenu(
                  onpressed: ((category) {
                    setState(() {
                      activatedCategory = category;
                      print(activatedCategory);
                    });
                  }),
                ),
              ),
              AddNewItem(
                category: activatedCategory,
                onPressed: (value) => print(value),
              )
            ],
          ),
        ),
      ],
    );
  }
}
