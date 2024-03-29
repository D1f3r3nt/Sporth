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
    apiKey: 'AIzaSyDSPafJx8jmGFhdFhPNlSPeYmuzJXX5IJo',
    appId: '1:989862851610:web:3309dca046ae3e4a288da3',
    messagingSenderId: '989862851610',
    projectId: 'sporth-c3c47',
    authDomain: 'sporth-c3c47.firebaseapp.com',
    storageBucket: 'sporth-c3c47.appspot.com',
    measurementId: 'G-145Q766XKQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCx3eN_UUoEc2mS6m7chHAo_QfAM3GkyWA',
    appId: '1:989862851610:android:b1c989397f843aea288da3',
    messagingSenderId: '989862851610',
    projectId: 'sporth-c3c47',
    storageBucket: 'sporth-c3c47.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBy4Vx26UA6jSCRBzhl02fhHLU0YN89xDI',
    appId: '1:989862851610:ios:ec05c8a7947c3b87288da3',
    messagingSenderId: '989862851610',
    projectId: 'sporth-c3c47',
    storageBucket: 'sporth-c3c47.appspot.com',
    iosClientId: '989862851610-bj0mptnvo0cj5355h6q7o945sk5i1dg1.apps.googleusercontent.com',
    iosBundleId: 'com.example.sporth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBy4Vx26UA6jSCRBzhl02fhHLU0YN89xDI',
    appId: '1:989862851610:ios:ec05c8a7947c3b87288da3',
    messagingSenderId: '989862851610',
    projectId: 'sporth-c3c47',
    storageBucket: 'sporth-c3c47.appspot.com',
    iosClientId: '989862851610-bj0mptnvo0cj5355h6q7o945sk5i1dg1.apps.googleusercontent.com',
    iosBundleId: 'com.example.sporth',
  );
}
