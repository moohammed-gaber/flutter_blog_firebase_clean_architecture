import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_firebase/core/app_colors.dart';
import 'package:flutter_blog_firebase/core/widgets/custom_network_image.dart';
import 'package:flutter_blog_firebase/features/posts/domain/entities/post.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/manager/posts_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostCard extends ConsumerWidget {
  const PostCard(
      {Key? key,
      required this.OnTapBookmark,
      required this.post,
      required this.index})
      : super(key: key);
  final Post post;
  final int index;
  final VoidCallback OnTapBookmark;

  @override
  Widget build(BuildContext context, ref) {
    print(post.userLikeIds.length);
    final notifier = ref.read(postsProvider.notifier);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xff2A557934),
              blurRadius: 12,
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(
          children: [
            CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider(post.uploader.profilePicture)),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            IconButton(
                color: post.isBookmarked ? AppColors.darkBlue : null,
                onPressed: OnTapBookmark,
                icon: Icon(Icons.bookmark)),
            Column(
              children: [
                IconButton(
                    padding: EdgeInsets.zero,
                    color: post.isLiked ? AppColors.darkBlue : null,
                    onPressed: () {
                      ref.read(postsProvider.notifier).toggleLike(index);
                    },
                    icon: Icon(Icons.thumb_up)),
                Text(post.userLikeIds.length.toString()),
              ],
            )
          ],
        ),
        SizedBox(height: 9.5.h),
        CustomNetworkImage(
          height: 202.h,
          imageUrl: post.imageUrl,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.5.h),
          child: Text(post.description),
        ),
      ]),
    );
  }
}
