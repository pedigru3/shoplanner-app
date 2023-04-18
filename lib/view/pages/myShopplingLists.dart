import 'package:flutter/material.dart';
import '../components/header.dart';

class MyShoppinglists extends StatelessWidget {
  const MyShoppinglists({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Header(
              text1: 'Minhas',
              text2: 'Compras',
            ),
          ],
        ),
      ),
    );
  }
}
