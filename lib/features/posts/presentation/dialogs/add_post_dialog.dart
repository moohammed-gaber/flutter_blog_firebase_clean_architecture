import 'package:flutter/material.dart';
import 'package:flutter_blog_firebase/core/app_colors.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/manager/add_post/add_post_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddPostDialog extends ConsumerWidget {
  const AddPostDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(addPostProvider);
    final notifier = ref.read(addPostProvider.notifier);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                child: InkWell(
                  onTap: () {
                    notifier.pickPostImage();
                  },
                  child: Container(
                      height: 157.h,
                      decoration: BoxDecoration(
                          image: state.pickedImage == null
                              ? null
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(state.pickedImage!)),
                          borderRadius: BorderRadius.circular(6.0.r),
                          color: AppColors.grey.withOpacity(0.2)),
                      child: state.pickedImage != null
                          ? null
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt,
                                    size: 80,
                                    color:
                                        AppColors.lightBlue.withOpacity(0.2)),
                                Text('رفع صورة',
                                    style: TextStyle(
                                        color: AppColors.darkBlue
                                            .withOpacity(0.5))),
                              ],
                            )),
                ),
              ),
              SizedBox(height: 31.h),
              Text('اكتب تعليقا حول الصورة',
                  style: TextStyle(color: Color(0xffBECCD4))),
              TextFormField(
                onChanged: notifier.onChangedDescription,
                maxLength: 120,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'اكتب هنا',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColors.orange,
                    )),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.orange,
                      ),
                    )),
              ),
              SizedBox(height: 37.h),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButtonTheme(
                  data: TextButtonThemeData(
                      style: TextButton.styleFrom(fixedSize: Size(77.w, 36.h))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('تجاهل',
                              style: TextStyle(color: AppColors.orange))),
                      TextButton(
                          onPressed: () async {
                            await notifier.addPost();
                            Navigator.pop(context);
                          },
                          child: Text('نشر',
                              style: TextStyle(color: Colors.white)),
                          style: TextButton.styleFrom(
                              backgroundColor: AppColors.orange)),
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
