import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blog_firebase/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_blog_firebase/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_blog_firebase/features/home/presentation/pages/home_page.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/pages/bookmark_page.dart';

class AppRoutes {
  final FirebaseAuth firebaseAuth;

  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String bookmark = '/bookmark';
  late final String initialRoute;

  AppRoutes(this.firebaseAuth) {
    if (firebaseAuth.currentUser == null) {
      initialRoute = login;
    } else {
      initialRoute = home;
    }
  }

  static get routes => {
        home: (context) => HomePage(),
        login: (context) => LoginPage(),
        register: (context) => RegisterBlocProvider(),
        bookmark: (context) => BookmarkPage(),
      };
}
