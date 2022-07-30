import 'package:flutter/material.dart';

class CustomNavigator {
  static final key = GlobalKey<NavigatorState>();
  static NavigatorState get keyCurrentState => key.currentState!;
}
