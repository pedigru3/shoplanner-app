import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/presentation/controllers/auth_controller.dart';
import 'package:shoplanner/layers/presentation/ui/components/perfil_avatar.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    const double height = 80;
    final authController = GetIt.I.get<AuthController>();

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
          PerfilAvatar(url: authController.token.avatarUrl)
        ],
      ),
    );
  }
}
