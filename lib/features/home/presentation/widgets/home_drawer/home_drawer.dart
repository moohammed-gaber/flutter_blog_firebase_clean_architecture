import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_firebase/core/app_colors.dart';
import 'package:flutter_blog_firebase/core/app_routes.dart';
import 'package:flutter_blog_firebase/features/home/presentation/manager/home_manager.dart';
import 'package:flutter_blog_firebase/features/home/presentation/widgets/home_drawer/drawer_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../profile/presentation/manager/profile_manager.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.read(profileProvider.notifier);
    final homeNotifier = ref.read(homeProvider.notifier);

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              color: AppColors.lightBlue,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 49.h, bottom: 15.h),
                  child: Container(
                      height: 49.h,
                      width: 49.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                notifier.userEntity.profilePicture),
                          ))),
                ),
                Text(
                  notifier.userEntity.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 22.94.h,
                )
              ])),
          DrawerTile(
              iconData: Icons.home,
              text: 'الرئيسية',
              onTap: () {
                homeNotifier.changePageIndex(0);
              }),
          DrawerTile(
              iconData: Icons.person,
              text: 'حسابي',
              onTap: () {
                homeNotifier.changePageIndex(1);
              }),
          DrawerTile(
              iconData: Icons.bookmark,
              text: 'المحفوظات',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.bookmark);
              }),
          DrawerTile(
              iconData: Icons.logout,
              text: 'تسجيل الخروج',
              onTap: () async {
                await notifier.logout();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.login, (Route<dynamic> route) => false);
              }),
        ],
      ),
    );
  }
}
