import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {Key? key,
      required this.iconData,
      required this.text,
      required this.onTap})
      : super(key: key);
  final IconData iconData;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Icon(iconData),
                SizedBox(width: 15.w),
                Text(text),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
