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
    apiKey: 'AIzaSyAnwesvydLJYiolu6yiVP-J-Dts-GyMOaU',
    appId: '1:884201425330:web:b73e2878c2edb810407cab',
    messagingSenderId: '884201425330',
    projectId: 'arsim-6afe3',
    authDomain: 'arsim-6afe3.firebaseapp.com',
    storageBucket: 'arsim-6afe3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_FSRuEjiCDfxv8K2_ZhttbxcWS-B3LmM',
    appId: '1:884201425330:android:877e8b05a4e51c57407cab',
    messagingSenderId: '884201425330',
    projectId: 'arsim-6afe3',
    storageBucket: 'arsim-6afe3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKN4BrRqs0-TJD0TKmskvVsxMJn2sXc_k',
    appId: '1:884201425330:ios:38ba72f9530f6a3f407cab',
    messagingSenderId: '884201425330',
    projectId: 'arsim-6afe3',
    storageBucket: 'arsim-6afe3.appspot.com',
    iosClientId: '884201425330-d9m285t937ctc4f58jv0mhuuagc8psje.apps.googleusercontent.com',
    iosBundleId: 'com.example.arsim',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAKN4BrRqs0-TJD0TKmskvVsxMJn2sXc_k',
    appId: '1:884201425330:ios:e824a320038a4ad5407cab',
    messagingSenderId: '884201425330',
    projectId: 'arsim-6afe3',
    storageBucket: 'arsim-6afe3.appspot.com',
    iosClientId: '884201425330-qv780k1pv9co7mn651tdlp6k38nnh7tn.apps.googleusercontent.com',
    iosBundleId: 'com.example.arsim.RunnerTests',
  );
}