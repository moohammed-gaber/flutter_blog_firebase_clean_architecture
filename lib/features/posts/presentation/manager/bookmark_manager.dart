import 'package:flutter_blog_firebase/core/injection.dart';
import 'package:flutter_blog_firebase/core/use_case/use_case.dart';
import 'package:flutter_blog_firebase/features/posts/data/repositories/posts_repo.dart';
import 'package:flutter_blog_firebase/features/posts/domain/entities/post.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/toogle_bookmark_post_use_case.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/get_bookmarked_posts_use_case.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/toogle_like_post_use_case.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/load_posts_use_case.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/manager/posts_bloc/posts_bloc.dart';
import 'package:riverpod/riverpod.dart';

final bookMarkProvider =
    StateNotifierProvider.autoDispose<BookMarkList, PostsState>((ref) {
  return BookMarkList(
      GetBookmarkedPostsUseCase(
        Injection.getIt.get<PostsRepoImpl>(),
      ),
      ToggleBookmarkPostsUseCase(Injection.getIt.get<PostsRepoImpl>()));
});

class BookMarkList extends StateNotifier<PostsState> {
  final GetBookmarkedPostsUseCase getBookmarkedPostsUseCase;
  final ToggleBookmarkPostsUseCase bookmarkPostsUseCase;

  BookMarkList(
    this.getBookmarkedPostsUseCase,
    this.bookmarkPostsUseCase,
  ) : super(PostsInitial()) {
    getAll();
  }

  getAll() async {
    final result = await getBookmarkedPostsUseCase.call(NoParams());
    result.fold((l) => null, (r) => state = PostsLoadSuccess(r, 'test'));
  }

  List<Post> get posts => (super.state as PostsLoadSuccess).posts;

  PostsLoadSuccess get postsLoadSuccessState =>
      (super.state as PostsLoadSuccess);
  Future toogleBookmark(int index) async {
    final result = await bookmarkPostsUseCase.call(posts[index]);
    result.fold((l) => null, (r) {
      final newPosts = postsLoadSuccessState.posts;
      newPosts.removeAt(index);

      state = postsLoadSuccessState.copyWith(posts: newPosts);
    });
  }
}
