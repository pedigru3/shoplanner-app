import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplanner/context/userContext.dart';
import '../components/button.dart';
import 'homePage.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late UserContext userRepository;

  @override
  Widget build(BuildContext context) {
    userRepository = context.watch<UserContext>();

    _handleButtonPress() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const MyHomePage()));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/Emoji3.png'),
            const SizedBox(height: 64),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SizedBox(
                width: 220,
                child: Text(
                  'Tudo certo!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
            SizedBox(
              width: 250,
              child: Text(
                  'Agora vamos começar a fazer compras mais econômicas.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            const SizedBox(
              height: 40,
            ),
            Button(onPressed: _handleButtonPress, label: 'Começar')
          ],
        ),
      ),
    );
  }
}
