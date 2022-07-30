import 'package:flutter/material.dart';

class CustomPopUp {
  static SnackBar errorSnackBar(String message) => SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      );
}
