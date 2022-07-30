import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_firebase/core/app_colors.dart';
import 'package:flutter_blog_firebase/core/injection.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/dialogs/add_post_dialog.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/manager/posts_bloc/posts_bloc.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/manager/posts_manager.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/widgets/post_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
/*
    PostsRemoteDataSource().getAll().then((value) => print(value));
*/

    return BlocProvider<PostsBloc>(
      create: (BuildContext context) => Injection.getIt.get<PostsBloc>()
/*
    PostsBloc(LoadPostsUseCase(
        PostsRepoImpl(
            PostsRemoteDataSource(),
            PostsLocaleDataSource(Injection.getIt.get<Database>()),
            NetworkInfoImpl(DataConnectionChecker()))))
*/
        ..add(LoadPosts()),
      child: PostsList(),
    );
  }
}

class PostsList extends ConsumerWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // ref.read(provider)
    final state = ref.watch(postsProvider);
    final notifier = ref.read(postsProvider.notifier);

/*
    notifier.loadPostsUseCase.postsRepo.getAll().then(
        (value) => (value.fold((l) => null, (r) => print(r[0].uploader.name))));
*/

    // context.read<PostsBloc>().initHandler();
/*
    print((context.read<PostsBloc>().state as PostsLoadSuccess ==
                (context.read<PostsBloc>().state as PostsLoadSuccess)
                    .copyWith(posts:( ))
            .toString() +
        'AAAAAAA');
*/
    return RefreshIndicator(
      onRefresh: () {
        notifier.loadPosts();
        return Future.value(true);
      },
      child: Builder(
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
            print('aaaaaaa');
            final posts = state.posts;

            return Stack(
              children: [
                ListView.separated(
                  padding:
                      EdgeInsets.symmetric(vertical: 25.h, horizontal: 16.w),
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = posts[index];
                    // print(post == post);
                    return PostCard(
                      OnTapBookmark: () {
                        final notifier = ref.read(postsProvider.notifier);
                        notifier.toggleBookmark(index);
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
                ),
                Positioned(
                  right: 25.w,
                  bottom: 80.h,
                  child: FloatingActionButton(
                      backgroundColor: AppColors.orange,
                      child: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        showDialog(
                            context: context, builder: (_) => AddPostDialog());
                      }),
                )
              ],
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
