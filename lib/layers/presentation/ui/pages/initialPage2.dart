import 'package:flutter/material.dart';
import 'package:shoplanner/layers/presentation/controllers/auth_controller.dart';
import 'package:shoplanner/layers/presentation/ui/components/button.dart';
import 'package:shoplanner/layers/presentation/ui/pages/namePage.dart';
import 'package:shoplanner/layers/presentation/ui/pages/startPage.dart';

class InitialPage2 extends StatelessWidget {
  const InitialPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon.png'),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'Como gostaria\nde começar?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Button(
                onPressed: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NamePage(),
                        ),
                      ),
                    },
                label: 'Criar uma nova conta'),
            const SizedBox(height: 16),
            Button(
                /*onPressed: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      ),
                    },*/
                onPressed: () {
                  auth.login().then((isAuthorized) => {
                        if (isAuthorized)
                          {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const StartPage(),
                              ),
                            )
                          }
                      });
                },
                label: 'Entrar com Github'),
          ],
        ),
      ),
    );
  }
}
