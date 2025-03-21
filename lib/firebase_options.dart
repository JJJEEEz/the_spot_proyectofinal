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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_syk_UOWVtPtAIDdvNvjlmpYmO6g6v1Q',
    appId: '1:67865947995:android:80e71454dfc4dfc9a0b47e',
    messagingSenderId: '67865947995',
    projectId: 'thespot-5e5e7',
    storageBucket: 'thespot-5e5e7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGDtl7i8954_2TlOeiA-gVqB6mykmQr1M',
    appId: '1:67865947995:ios:f70155085f9d2afaa0b47e',
    messagingSenderId: '67865947995',
    projectId: 'thespot-5e5e7',
    storageBucket: 'thespot-5e5e7.firebasestorage.app',
    iosBundleId: 'com.example.theSpotProyectofinal',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCIuNKM2VQlOwRHk3nZ2gf31J1f0z-yr1c',
    appId: '1:67865947995:web:a9249dcae0de4695a0b47e',
    messagingSenderId: '67865947995',
    projectId: 'thespot-5e5e7',
    authDomain: 'thespot-5e5e7.firebaseapp.com',
    storageBucket: 'thespot-5e5e7.firebasestorage.app',
  );

}