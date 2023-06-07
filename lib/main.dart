import 'package:flutter/material.dart';
import 'package:shoplanner/core/inject/inject.dart';
import 'myApp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Inject.init();
  await dotenv.load(fileName: ".env");
  runApp(
    const MyApp(),
  );
}
