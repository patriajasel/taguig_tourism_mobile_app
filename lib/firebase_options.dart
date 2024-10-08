// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyB_eB0RoPMb8Qww6uhjJsCwgCr9M0oVfZ8',
    appId: '1:258109280748:web:e17c07720c0a45c47730c9',
    messagingSenderId: '258109280748',
    projectId: 'taguig-tourism-app',
    authDomain: 'taguig-tourism-app.firebaseapp.com',
    storageBucket: 'taguig-tourism-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBg9W765YhN7r4nkrExyyCCL7sQDFDNdVE',
    appId: '1:258109280748:android:874b83b54e30e6cc7730c9',
    messagingSenderId: '258109280748',
    projectId: 'taguig-tourism-app',
    storageBucket: 'taguig-tourism-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUv8482CZZ100MIDlr7thE5zjd8JOpF4c',
    appId: '1:258109280748:ios:7da42c0923e2c7947730c9',
    messagingSenderId: '258109280748',
    projectId: 'taguig-tourism-app',
    storageBucket: 'taguig-tourism-app.appspot.com',
    iosClientId: '258109280748-svc2l8i8q9sqgr3tqhsmtsf1otef4b7t.apps.googleusercontent.com',
    iosBundleId: 'com.example.taguigTourismMobileApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBUv8482CZZ100MIDlr7thE5zjd8JOpF4c',
    appId: '1:258109280748:ios:7da42c0923e2c7947730c9',
    messagingSenderId: '258109280748',
    projectId: 'taguig-tourism-app',
    storageBucket: 'taguig-tourism-app.appspot.com',
    iosClientId: '258109280748-svc2l8i8q9sqgr3tqhsmtsf1otef4b7t.apps.googleusercontent.com',
    iosBundleId: 'com.example.taguigTourismMobileApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB_eB0RoPMb8Qww6uhjJsCwgCr9M0oVfZ8',
    appId: '1:258109280748:web:8d7f7507bfa58ca67730c9',
    messagingSenderId: '258109280748',
    projectId: 'taguig-tourism-app',
    authDomain: 'taguig-tourism-app.firebaseapp.com',
    storageBucket: 'taguig-tourism-app.appspot.com',
  );

}