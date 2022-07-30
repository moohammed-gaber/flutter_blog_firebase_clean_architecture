part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

// posts loadinginprogress
class PostsLoadInProgress extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsLoadSuccess extends PostsState {
  final List<Post> posts;
  final String test;

  PostsLoadSuccess(this.posts, this.test);

  // copy with
  PostsLoadSuccess copyWith({List<Post>? posts, String? test}) {
    return PostsLoadSuccess(posts ?? this.posts, test ?? this.test);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PostsLoadSuccess &&
          runtimeType == other.runtimeType &&
          posts == other.posts &&
          test == other.test;

  @override
  int get hashCode => super.hashCode ^ posts.hashCode ^ test.hashCode;

  // equals operator

  @override
  List<Object> get props => [posts, test];
}

class PostsLoadFailure extends PostsState {
  PostsLoadFailure();

  @override
  List<Object> get props => [];
}

// post liked

class PostLiked extends PostsState {
  final Post post;

  PostLiked({required this.post});

  @override
  List<Object> get props => [post];
}
