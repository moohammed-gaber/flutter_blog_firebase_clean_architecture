import 'package:flutter/material.dart';
import 'package:flutter_blog_firebase/core/app_colors.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.iconData})
      : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
            onPressed: (onPressed),
            backgroundColor: AppColors.orange,
            child: Icon(
              iconData,
              color: Colors.white,
            )),
        SizedBox(
          height: 9,
        ),
        Text(text)
      ],
    );
  }
}
