import 'package:flutter/material.dart';
import 'package:flutter_blog_firebase/core/app_colors.dart';

class AppTheme {
  static get lightTheme => ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.grey.withOpacity(0.2),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        fontFamily: 'Almarai',
        colorScheme: ColorScheme.light(
          primary: AppColors.darkBlue,
        ),
        iconTheme: IconThemeData(color: AppColors.grey),
        scaffoldBackgroundColor: AppColors.offWhite,
        primarySwatch: Colors.blue,
      );
}
