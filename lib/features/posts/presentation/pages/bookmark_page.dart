import 'package:flutter/material.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/manager/bookmark_manager.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/manager/posts_bloc/posts_bloc.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/manager/posts_manager.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/widgets/post_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookmarkPage extends ConsumerWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(bookMarkProvider);

    return Scaffold(
      body: Builder(
        // bloc: context.read<PostsBloc>(),
        builder: (
          _,
        ) {
          if (state is PostsLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostsLoadSuccess) {
            final posts = state.posts;
            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 16.w),
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                final post = posts[index];
                // print(post == post);
                return PostCard(
                  OnTapBookmark: () {
                    final notifier = ref.read(bookMarkProvider.notifier);
                    notifier.toogleBookmark(index);
                    final postsProviderNotifier =
                        ref.read(postsProvider.notifier);
                    postsProviderNotifier.unBookMarkPost(post);

// notifier.
                  },
                  post: post,
                  index: index,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 16.h,
                );
              },
            );
          }
          return Center(
            child: Text('Error'),
          );
        },
      ),
    );
  }
}
