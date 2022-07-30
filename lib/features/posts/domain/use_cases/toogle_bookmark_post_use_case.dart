import 'package:dartz/dartz.dart';
import 'package:flutter_blog_firebase/core/failures/failures.dart';
import 'package:flutter_blog_firebase/core/use_case/use_case.dart';
import 'package:flutter_blog_firebase/features/posts/domain/entities/post.dart';
import 'package:flutter_blog_firebase/features/posts/domain/repositories/posts_repo.dart';

class ToggleBookmarkPostsUseCase implements FailureUseCase<Unit, Post> {
  final PostsRepo postsRepo;

  ToggleBookmarkPostsUseCase(this.postsRepo);

  @override
  Future<Either<Failure, Unit>> call(Post params) {
    if (params.isBookmarked) {
      return postsRepo.unBookmark(params);
    } else {
      return postsRepo.bookmark(params);
    }
  }
}
