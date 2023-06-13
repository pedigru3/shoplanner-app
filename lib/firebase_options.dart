// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCS_mdALeqOLi-21Hu5vj4kHozGi_sSpqQ',
    appId: '1:590619170189:web:a64a4aeb9676f6fb0e59c4',
    messagingSenderId: '590619170189',
    projectId: 'shoplanner-14829',
    authDomain: 'shoplanner-14829.firebaseapp.com',
    storageBucket: 'shoplanner-14829.appspot.com',
    measurementId: 'G-VKN7550VNS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvb566TcVbjobf31b2s6WxsRvDFRzVgFI',
    appId: '1:590619170189:android:ae929f2ec332e8230e59c4',
    messagingSenderId: '590619170189',
    projectId: 'shoplanner-14829',
    storageBucket: 'shoplanner-14829.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbZKwH_fcPR026gSYBtah53nd_hrsyfOU',
    appId: '1:590619170189:ios:8540ad73424091620e59c4',
    messagingSenderId: '590619170189',
    projectId: 'shoplanner-14829',
    storageBucket: 'shoplanner-14829.appspot.com',
    iosClientId: '590619170189-a15ksf0a8ntlq4rjm0mjp3n2965apm1i.apps.googleusercontent.com',
    iosBundleId: 'br.felipe.shoplanner',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbZKwH_fcPR026gSYBtah53nd_hrsyfOU',
    appId: '1:590619170189:ios:8540ad73424091620e59c4',
    messagingSenderId: '590619170189',
    projectId: 'shoplanner-14829',
    storageBucket: 'shoplanner-14829.appspot.com',
    iosClientId: '590619170189-a15ksf0a8ntlq4rjm0mjp3n2965apm1i.apps.googleusercontent.com',
    iosBundleId: 'br.felipe.shoplanner',
  );
}
