import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplanner/context/userContext.dart';
import 'package:shoplanner/view/pages/startPage.dart';

import '../components/button.dart';

class NamePage extends StatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  late UserContext userRepository;
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userRepository = context.watch<UserContext>();

    bool isSettled = nameController.text.length >= 3;

    void _handleButtonPress() {
      userRepository.saveName(nameController.text);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const StartPage(),
      ));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isSettled
                ? Image.asset('assets/Emoji2.png')
                : Image.asset('assets/Emoji.png'),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SizedBox(
                width: 220,
                child: Text(
                  'Como podemos chamar você?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
            SizedBox(
              width: 280,
              child: TextField(
                  controller: nameController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(),
                  onChanged: (value) => {setState(() => {})},
                  decoration:
                      const InputDecoration(hintText: 'Digite um nome')),
            ),
            const SizedBox(
              height: 40,
            ),
            Button(
                label: 'Confirmar',
                onPressed: _handleButtonPress,
                isActivated: isSettled),
          ],
        ),
      ),
    );
  }
}
