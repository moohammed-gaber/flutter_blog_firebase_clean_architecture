import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blog_firebase/core/use_case/use_case.dart';
import 'package:flutter_blog_firebase/features/posts/domain/entities/post.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/toogle_like_post_use_case.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/load_posts_use_case.dart';
import 'package:uuid/uuid.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final LoadPostsUseCase loadPostsUseCase;
  final ToggleLikePostsUseCase likePostsUseCase;

  PostsBloc(this.loadPostsUseCase, this.likePostsUseCase)
      : super(PostsInitial()) {
    initHandler();
  }

  initHandler() {
    on<PostsEvent>((event, emit) async {
      if (event is LoadPosts) {
        emit(PostsLoadInProgress());
        final result = await loadPostsUseCase.call(NoParams());
        result.fold((l) => emit(PostsLoadFailure()),
            (r) => emit(PostsLoadSuccess(r, 'test')));
      }
      if (event is LikePost) {
        final newState = state as PostsLoadSuccess;
        // emit(PostsLoadInProgress());
        final post = newState.posts[event.postIndex];
        if (post.isLiked) {
          final newUserLiked = post.userLikeIds;
          newUserLiked.remove(('sasas'));
          newState.posts[event.postIndex] = newState.posts[event.postIndex]
              .copyWith(userLikeIds: newUserLiked);
        } else {
          final newPostLikes = ['sasas', ...post.userLikeIds];
          final newPost = newState.posts[event.postIndex]
              .copyWith(userLikeIds: newPostLikes, description: Uuid().v4());
          final result = await likePostsUseCase.call(newPost);
          result.fold(
              (l) => null, (r) => newState.posts[event.postIndex] = newPost);
        }
        print(newState.posts.map((e) => e.userLikeIds));
        emit(PostsLoadSuccess(newState.posts, Uuid().v4()));
      }
    });
  }
// map event to state

}
