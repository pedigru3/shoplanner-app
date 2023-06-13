import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/data/services/github_auth.dart';
import 'package:shoplanner/layers/data/services/google_auth.dart';
import 'package:shoplanner/layers/presentation/controllers/auth_controller.dart';
import 'package:shoplanner/layers/presentation/ui/components/button.dart';
import 'package:shoplanner/layers/presentation/ui/pages/startPage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class InitialPage2 extends StatefulWidget {
  const InitialPage2({super.key});

  @override
  State<InitialPage2> createState() => _InitialPage2State();
}

class _InitialPage2State extends State<InitialPage2> {
  final auth = GetIt.I.get<AuthController>();

  @override
  void initState() {
    super.initState();
    auth.addListener(onLoginChange);
  }

  onLoginChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 16),
            auth.isLoading
                ? const SizedBox()
                : Button(
                    onPressed: () {
                      auth.login(GoogleAuth()).then((isAuthorized) => {
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
                    label: 'Entrar com o Google',
                    icon: FontAwesome.google,
                  ),
            const SizedBox(height: 10),
            auth.isLoading
                ? const SizedBox(
                    height: 40,
                    child: CircularProgressIndicator(),
                  )
                : Button(
                    onPressed: () {
                      auth.login(GithubAuth()).then((isAuthorized) => {
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
                    icon: Octicons.mark_github,
                    label: 'Entrar com Github',
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    auth.removeListener(onLoginChange);
    super.dispose();
  }
}
