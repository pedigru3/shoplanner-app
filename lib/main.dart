import 'package:flutter/material.dart';
import 'package:shoplanner/core/inject/inject.dart';
import 'package:shoplanner/layers/presentation/controllers/auth_controller.dart';
import 'myApp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Inject.init();
  AuthController.initialWithMainToTryAuthenticate();
  await dotenv.load(fileName: ".env");
  runApp(
    const MyApp(),
  );
}
