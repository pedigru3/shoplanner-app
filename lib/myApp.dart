import 'package:flutter/material.dart';
import 'package:shoplanner/layers/presentation/ui/pages/initialPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final secondary = 0xffB41817;
  final primary = 0xffD22727;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoplanner',
      theme: ThemeData(
        textTheme: TextTheme(
          headlineLarge: TextStyle(
              fontSize: 32, color: Color(primary), fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(
            color: Color(primary),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 17,
            height: 1.3,
            fontWeight: FontWeight.w400,
            color: Color(secondary),
          ),
        ),
        primarySwatch: Colors.red,
        colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Color(primary), surfaceVariant: const Color(0xFFF0F0F0)),
      ),
      home: const InitialPage(),
    );
  }
}
