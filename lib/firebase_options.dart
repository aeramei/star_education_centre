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
    apiKey: 'AIzaSyAkq1yHzP8nkYCkxyq5eDMPy7wuN0nIRjE',
    appId: '1:578754999002:web:9a1d1a4f1416dea707abe3',
    messagingSenderId: '578754999002',
    projectId: 'hnd-53-3d26b',
    authDomain: 'hnd-53-3d26b.firebaseapp.com',
    storageBucket: 'hnd-53-3d26b.appspot.com',
    measurementId: 'G-JTZ8J1SXP8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7-gGw5UZQSqoh4RzAe4MYwdB9bWnKERA',
    appId: '1:578754999002:android:9129e444ac8b628a07abe3',
    messagingSenderId: '578754999002',
    projectId: 'hnd-53-3d26b',
    storageBucket: 'hnd-53-3d26b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJcyGbUu0Lq7lhnJ_jrnQFiwpBMDRWx2M',
    appId: '1:578754999002:ios:12f2a915bd5b359907abe3',
    messagingSenderId: '578754999002',
    projectId: 'hnd-53-3d26b',
    storageBucket: 'hnd-53-3d26b.appspot.com',
    iosBundleId: 'com.example.firebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJcyGbUu0Lq7lhnJ_jrnQFiwpBMDRWx2M',
    appId: '1:578754999002:ios:12f2a915bd5b359907abe3',
    messagingSenderId: '578754999002',
    projectId: 'hnd-53-3d26b',
    storageBucket: 'hnd-53-3d26b.appspot.com',
    iosBundleId: 'com.example.firebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAkq1yHzP8nkYCkxyq5eDMPy7wuN0nIRjE',
    appId: '1:578754999002:web:3aba10e6b1b045ef07abe3',
    messagingSenderId: '578754999002',
    projectId: 'hnd-53-3d26b',
    authDomain: 'hnd-53-3d26b.firebaseapp.com',
    storageBucket: 'hnd-53-3d26b.appspot.com',
    measurementId: 'G-N7Y2LMM145',
  );
}
