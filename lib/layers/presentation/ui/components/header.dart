import 'package:flutter/material.dart';
import 'package:shoplanner/layers/presentation/controllers/auth_controller.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    const double height = 80;

    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: TextStyle(
                    fontSize: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  text2,
                  style: Theme.of(context).textTheme.headlineLarge,
                )
              ],
            ),
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(AuthController.token.avatarUrl),
            radius: 32,
            backgroundColor: Colors.red,
          )
        ],
      ),
    );
  }
}
