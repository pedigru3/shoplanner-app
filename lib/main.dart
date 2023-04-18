import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplanner/context/categoryContext.dart';
import 'package:shoplanner/context/userContext.dart';
import 'myApp.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserContext(),
      ),
      ChangeNotifierProvider(
        create: (_) => CategoryContext(),
      )
    ],
    child: const MyApp(),
  ));
}
