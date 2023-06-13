import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/presentation/controllers/auth_controller.dart';
import 'package:shoplanner/layers/presentation/ui/pages/homePage.dart';
import 'package:shoplanner/layers/presentation/ui/pages/initialPage2.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = GetIt.I.get<AuthController>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 240,
                  child: Text(
                    'Planeje suas compras e',
                    //'Planeje suas compras e',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Text(
                  'evite imprevistos',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 49),
                Image.asset(
                  'assets/initial-image.png',
                  height: 300,
                ),
                const SizedBox(height: 40),
                Text(
                  'Com o Shoplanner você sabe exatamente o que comprar e qual\n é o supermercado mais em conta.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 56,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => authController.isAuthenticated
                              ? const MyHomePage()
                              : const InitialPage2()))
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
