import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shoplanner/layers/presentation/controllers/user_controller.dart';
import 'package:shoplanner/layers/presentation/ui/pages/startPage.dart';

import '../components/button.dart';

/* class NamePage extends StatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final nameController = TextEditingController();
  var userController = GetIt.I.get<UserController>();

  @override
  Widget build(BuildContext context) {
    bool isSettled = nameController.text.length >= 3;

    void handleButtonPress() async {
      var result = await userController.createUser(nameController.text);
      result.fold((success) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const StartPage(),
        ));
      },
          (failure) => {
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
                    content: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        failure.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                )
              });
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
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            SizedBox(
              width: 280,
              child: TextFormField(
                  validator: userController.nameValidation,
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
                onPressed: handleButtonPress,
                isActivated: isSettled),
          ],
        ),
      ),
    );
  }
}
*/