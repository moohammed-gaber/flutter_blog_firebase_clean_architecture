import 'package:dartz/dartz.dart';
import 'package:flutter_blog_firebase/core/domain/entities/user_entity.dart';
import 'package:flutter_blog_firebase/core/failures/failures.dart';
import 'package:flutter_blog_firebase/features/posts/domain/entities/post.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/add_post_use_case.dart';

abstract class PostsRepo {
  Future<Either<Failure, List<Post>>> getAll();

  Future<Either<Failure, Unit>> add(AddPostParams addPostParams);

  Future<Either<Failure, Unit>> likePost(Post post);
  Future<Either<Failure, Unit>> unLikePost(Post post);

  Future<Either<Failure, Unit>> bookmark(Post post);

  Future<Either<Failure, Unit>> unBookmark(Post post);

  Future<Either<Failure, List<Post>>> getAllBookmarkedPosts();

  Future<Either<Failure, Unit>> delete(String id);

  Future<Either<Failure, Unit>> edit(String id, Post post);
}
