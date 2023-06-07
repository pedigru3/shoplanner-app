import 'package:flutter/material.dart';
import 'package:shoplanner/layers/presentation/ui/components/sliders_users.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Image.asset('assets/icon.png'),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    'Escolha uma conta\npara entrar',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const Expanded(
                  child: Center(
                      child: SizedBox(width: 250, child: SlidersUsers())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
