import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_blog_firebase/core/failures/failures.dart';
import 'package:flutter_blog_firebase/core/use_case/use_case.dart';
import 'package:flutter_blog_firebase/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter_blog_firebase/features/posts/domain/repositories/posts_repo.dart';

class AddPostsUseCase implements FailureUseCase<Unit, AddPostParams> {
  final PostsRepo postsRepo;

  AddPostsUseCase(this.postsRepo, );

  @override
  Future<Either<Failure, Unit>> call(AddPostParams params) {

    return postsRepo.add(params);
  }
}

class AddPostParams {
  final File image;
  final String description;

  AddPostParams(this.image, this.description);
}
