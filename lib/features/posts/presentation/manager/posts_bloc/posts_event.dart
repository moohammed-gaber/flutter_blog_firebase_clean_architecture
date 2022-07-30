part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

// load
class LoadPosts extends PostsEvent {
  @override
  List<Object> get props => [];
}

// like post
class LikePost extends PostsEvent {
  final int postIndex;

  LikePost(this.postIndex);

  @override
  List<Object> get props => [postIndex];
}

// bookmark post
class BookmarkPost extends PostsEvent {
  final int postIndex;

  BookmarkPost({required this.postIndex});

  @override
  List<Object> get props => [postIndex];
}

// share post
class SharePost extends PostsEvent {
  final int postIndex;

  SharePost({required this.postIndex});

  @override
  List<Object> get props => [postIndex];
}
