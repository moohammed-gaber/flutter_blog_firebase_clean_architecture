import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blog_firebase/core/injection.dart';
import 'package:flutter_blog_firebase/core/io/custom_file_picker.dart';
import 'package:flutter_blog_firebase/core/use_case/use_case.dart';
import 'package:flutter_blog_firebase/features/posts/data/repositories/posts_repo.dart';
import 'package:flutter_blog_firebase/features/posts/domain/entities/post.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/load_posts_use_case.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/pick_post_image_use_case.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/toogle_bookmark_post_use_case.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/toogle_like_post_use_case.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/manager/posts_bloc/posts_bloc.dart';
import 'package:riverpod/riverpod.dart';

final postsProvider = StateNotifierProvider<PostList, PostsState>((ref) {
  return PostList(
      LoadPostsUseCase(
        Injection.getIt.get<PostsRepoImpl>(),
      ),
      ToggleLikePostsUseCase(Injection.getIt.get<PostsRepoImpl>()),
      ToggleBookmarkPostsUseCase(Injection.getIt.get<PostsRepoImpl>()),
      PickPostImageUseCase(CustomFilePicker()));
});

class PostList extends StateNotifier<PostsState> {
  final LoadPostsUseCase loadPostsUseCase;
  final ToggleLikePostsUseCase toggleLikePostsUseCase;
  final ToggleBookmarkPostsUseCase toggleBookmarkPostsUseCase;
  final PickPostImageUseCase pickPostImageUseCase;

  PostList(this.loadPostsUseCase, this.toggleLikePostsUseCase,
      this.toggleBookmarkPostsUseCase, this.pickPostImageUseCase)
      : super(PostsInitial()) {
    loadPosts();
  }

  loadPosts() async {
    state = PostsLoadInProgress();
    final result = await loadPostsUseCase.call(NoParams());
    result.fold((l) => state = PostsLoadFailure(),
        (r) => state = PostsLoadSuccess(r, 'test'));
  }

  List<Post> get posts => (super.state as PostsLoadSuccess).posts;

  PostsLoadSuccess get postsLoadSuccessState =>
      (super.state as PostsLoadSuccess);

  unBookMarkPost(Post post) {
    final index = posts.indexWhere((element) => element.id == post.id);
    final newPosts = postsLoadSuccessState.posts;
    newPosts[index] = newPosts[index].copyWith(isBookmarked: false);
    state = postsLoadSuccessState.copyWith(posts: newPosts);
  }

  pickPostImage() async {
    final result = await pickPostImageUseCase.call(NoParams());
  }

  toggleLike(int index) async {
    final post = posts[index];
    final result = await toggleLikePostsUseCase.call(post);
    result.fold((l) => null, (r) {
      final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      final newPosts = postsLoadSuccessState.posts;
      if (post.isLiked) {
        final newLikes = newPosts[index].userLikeIds;
        newLikes.removeWhere((element) => element == currentUserUid);
        newPosts[index] = newPosts[index].copyWith(userLikeIds: newLikes);
      } else {
        newPosts[index] = newPosts[index].copyWith(
            userLikeIds: [...newPosts[index].userLikeIds, currentUserUid]);
      }

      return state = postsLoadSuccessState.copyWith(posts: newPosts);

      return null;
    });

/*
    result.fold((l) => null, (r) {
      final newPosts = postsLoadSuccessState.posts;
      newPosts[index] = newPosts[index]
          .copyWith(userLikeIds: [...newPosts[index].userLikeIds, 'dsadsd']);
      return state = postsLoadSuccessState.copyWith(posts: newPosts);
    });
*/
  }

  toggleBookmark(int index) async {
    final result = await toggleBookmarkPostsUseCase.call(posts[index]);
    result.fold((l) => null, (r) {
      final newPosts = postsLoadSuccessState.posts;
      newPosts[index] =
          newPosts[index].copyWith(isBookmarked: !newPosts[index].isBookmarked);
      state = postsLoadSuccessState.copyWith(posts: newPosts);
    });
  }
}
