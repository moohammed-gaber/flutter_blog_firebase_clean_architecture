import 'package:dartz/dartz.dart';
import 'package:flutter_blog_firebase/core/failures/failures.dart';
import 'package:flutter_blog_firebase/core/use_case/use_case.dart';
import 'package:flutter_blog_firebase/features/posts/domain/entities/post.dart';
import 'package:flutter_blog_firebase/features/posts/domain/repositories/posts_repo.dart';

class LoadPostsUseCase implements FailureUseCase<List<Post>, NoParams> {
  final PostsRepo postsRepo;

  LoadPostsUseCase(this.postsRepo);

  @override
  Future<Either<Failure, List<Post>>> call(params) {
    return postsRepo.getAll();
  }
}
