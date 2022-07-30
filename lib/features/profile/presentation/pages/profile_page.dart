import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_firebase/core/widgets/custom_network_image.dart';
import 'package:flutter_blog_firebase/features/profile/presentation/manager/profile_manager.dart';
import 'package:flutter_blog_firebase/features/profile/presentation/widgets/profile_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);
/*
    FirebaseAuth.instance.
*/
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              CustomNetworkImage(
                  height: 218.h,
                  width: double.infinity,
                  imageUrl: state.userEntity.profilePicture,
                  radius: 0),
              Positioned(
                  // top: 150,
                  bottom: -50,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 133.h,
                        width: 133.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    state.userEntity.profilePicture),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle),
                      ))),
            ]),
        SizedBox(height: 80.5.h),
        Text('اسم المستخدم'),
        Padding(
          padding: EdgeInsets.only(top: 3.h, bottom: 57.h),
          child: Text(state.userEntity.email),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ProfileButton(
                onPressed: () {}, text: 'تعديل بياناتي', iconData: Icons.edit),
            ProfileButton(
                onPressed: () {}, text: 'الاعدادات', iconData: Icons.settings),
            ProfileButton(
                onPressed: () {}, text: 'المفضلة', iconData: Icons.star)
          ],
        )
      ],
    );
  }
}
