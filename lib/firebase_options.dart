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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
    apiKey: 'AIzaSyChX9g-3omAlJirZIHIVQKAKkGgEwH5OuA',
    appId: '1:855992071312:android:7231cc6034543f16379415',
    messagingSenderId: '855992071312',
    projectId: 'sdvgo-8f8e5',
    storageBucket: 'sdvgo-8f8e5.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBS3oKP1qoa6A9r8bKH9UWaN_Rs1N4OY6I',
    appId: '1:855992071312:ios:b34bebf23610f05b379415',
    messagingSenderId: '855992071312',
    projectId: 'sdvgo-8f8e5',
    storageBucket: 'sdvgo-8f8e5.firebasestorage.app',
    androidClientId:
        '855992071312-av5a95j3kr6orp1mikmju9n74r3ui1is.apps.googleusercontent.com',
    iosClientId:
        '855992071312-12f9a9fadbkl2vajhj08ss8bsoeevf0d.apps.googleusercontent.com',
    iosBundleId: 'com.sirius.yandex.sdvgo',
  );
}
