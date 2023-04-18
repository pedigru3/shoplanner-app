import 'package:flutter/material.dart';

import 'namePage.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 240,
                child: Text(
                  'Planeje suas compras e',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Text(
                'evite imprevistos',
                style: Theme.of(context).textTheme.headline1,
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
                  onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NamePage()))
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
    );
  }
}
