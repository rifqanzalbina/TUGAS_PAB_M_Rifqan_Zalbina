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
    apiKey: 'AIzaSyAigS-dKPhwfAdcZSMkKULuLz4ZTXVaN8A',
    appId: '1:899280247923:web:7e05c6a68782290a93de06',
    messagingSenderId: '899280247923',
    projectId: 'mahasiswa-dc754',
    authDomain: 'mahasiswa-dc754.firebaseapp.com',
    databaseURL: 'https://mahasiswa-dc754-default-rtdb.firebaseio.com',
    storageBucket: 'mahasiswa-dc754.firebasestorage.app',
    measurementId: 'G-QZG2L1VD60',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEhin4VkZOlyhu5qtqjiXapww2WkHyLME',
    appId: '1:899280247923:android:964a99bbb3965f7593de06',
    messagingSenderId: '899280247923',
    projectId: 'mahasiswa-dc754',
    storageBucket: 'mahasiswa-dc754.firebasestorage.app',
    databaseURL: 'https://mahasiswa-dc754-default-rtdb.firebaseio.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrgSFIyRLNxe2phCJphqRGYwvzPKEjOIU',
    appId: '1:899280247923:ios:6b572dda962f246a93de06',
    messagingSenderId: '899280247923',
    projectId: 'mahasiswa-dc754',
    storageBucket: 'mahasiswa-dc754.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrgSFIyRLNxe2phCJphqRGYwvzPKEjOIU',
    appId: '1:899280247923:ios:6b572dda962f246a93de06',
    messagingSenderId: '899280247923',
    projectId: 'mahasiswa-dc754',
    storageBucket: 'mahasiswa-dc754.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAigS-dKPhwfAdcZSMkKULuLz4ZTXVaN8A',
    appId: '1:899280247923:web:06761db607be7fcb93de06',
    messagingSenderId: '899280247923',
    projectId: 'mahasiswa-dc754',
    authDomain: 'mahasiswa-dc754.firebaseapp.com',
    storageBucket: 'mahasiswa-dc754.firebasestorage.app',
    measurementId: 'G-L6MZZZGM4D',
  );
}
