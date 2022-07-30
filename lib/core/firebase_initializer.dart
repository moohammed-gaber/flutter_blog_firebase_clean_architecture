import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_blog_firebase/firebase_options.dart';

class FirebaseInitializer {
  static Future<void> initialize() {
    return Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}
