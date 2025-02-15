import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    } else if (Platform.isAndroid) {
      return android;
    } else if (Platform.isIOS) {
      return ios;
    } else if (Platform.isMacOS) {
      return macos;
    } else if (Platform.isWindows) {
      return windows;
    } else if (Platform.isLinux) {
      return linux;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyB5geqD3OfX5uwKHSZWwooadBJgFZWakN8",
    appId: "1:43069233290:android:04ad3c130f2b0bac66b573",
    messagingSenderId: "43069233290",
    projectId: "management-pr",
    storageBucket: "management-pr.appspot.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyB5geqD3OfX5uwKHSZWwooadBJgFZWakN8",
    appId: "1:43069233290:ios:YOUR_IOS_APP_ID",
    messagingSenderId: "43069233290",
    projectId: "management-pr",
    storageBucket: "management-pr.appspot.com",
    iosClientId: "YOUR_IOS_CLIENT_ID",
    iosBundleId: "com.example.management",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyB5geqD3OfX5uwKHSZWwooadBJgFZWakN8",
    appId: "1:43069233290:macos:YOUR_MACOS_APP_ID",
    messagingSenderId: "43069233290",
    projectId: "management-pr",
    storageBucket: "management-pr.appspot.com",
    iosClientId: "YOUR_MACOS_CLIENT_ID",
    iosBundleId: "com.example.management",
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "AIzaSyB5geqD3OfX5uwKHSZWwooadBJgFZWakN8",
    appId: "1:43069233290:windows:YOUR_WINDOWS_APP_ID",
    messagingSenderId: "43069233290",
    projectId: "management-pr",
    storageBucket: "management-pr.appspot.com",
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: "AIzaSyB5geqD3OfX5uwKHSZWwooadBJgFZWakN8",
    appId: "1:43069233290:linux:YOUR_LINUX_APP_ID",
    messagingSenderId: "43069233290",
    projectId: "management-pr",
    storageBucket: "management-pr.appspot.com",
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyB5geqD3OfX5uwKHSZWwooadBJgFZWakN8",
    appId: "1:43069233290:web:YOUR_WEB_APP_ID",
    messagingSenderId: "43069233290",
    projectId: "management-pr",
    storageBucket: "management-pr.appspot.com",
  );
}
