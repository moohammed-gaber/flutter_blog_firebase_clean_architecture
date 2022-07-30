import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blog_firebase/core/custom_firestorage.dart';
import 'package:flutter_blog_firebase/core/failures/failures.dart';
import 'package:flutter_blog_firebase/core/network/network_info.dart';
import 'package:flutter_blog_firebase/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter_blog_firebase/features/posts/data/local/data_sources/posts_local_data_source.dart';
import 'package:flutter_blog_firebase/features/posts/data/mappers/locale_domain_mapper.dart';
import 'package:flutter_blog_firebase/features/posts/data/mappers/remote_domain_mapper.dart';
import 'package:flutter_blog_firebase/features/posts/data/remote/data_sources/posts_remote_data_source.dart';
import 'package:flutter_blog_firebase/features/posts/data/remote/models/post_remote_data_model.dart';
import 'package:flutter_blog_firebase/features/posts/domain/entities/post.dart';
import 'package:flutter_blog_firebase/features/posts/domain/repositories/posts_repo.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/add_post_use_case.dart';
import 'package:uuid/uuid.dart';

class PostsRepoImpl implements PostsRepo {
  final PostsRemoteDataSource _remoteDataSource;
  final PostsLocaleDataSource _localeDataSource;
  final AuthRepo authRepo;
  final NetworkInfo networkInfo;
  final CustomFireStorage customFireStorage;

  PostsRepoImpl(this._remoteDataSource, this._localeDataSource,
      this.networkInfo, this.authRepo, this.customFireStorage);

  @override
  Future<Either<Failure, List<Post>>> getAll() async {
    try {
      final posts = <Post>[];
      final result = await _remoteDataSource.getAll();
      for (int i = 0; i < result.length; i++) {
        final remotePost = result[i];
        print(remotePost.uploaderID);
        final uploader = await authRepo.getUserById(remotePost.uploaderID);

        final post = (RemoteDomainMapper.toDomain(remotePost, uploader));
        final local = await _localeDataSource.getOne(remotePost.id);
        if (local == null) {
          posts.add(post);
        } else {
          posts.add(post.copyWith(isBookmarked: true));
        }
      }
      return right(posts);
    } catch (e) {
      rethrow;
      return left(Failure());
    }

/*
    return networkInfo.handleConnection(onConnected: () async {
      final result = await _remoteDataSource.getAll();
      // _localeDataSource.addAll(LocalDomainMapper.toLocalDataModelList(result))
      // _localeDataSource.
      return RemoteDomainMapper.toDomainList(result);
    }, onNotConnected: () async {
      final result = await _localeDataSource.getAll();
      return LocalDomainMapper.toDomainList(result);
    });
*/
  }

  Future<Either<Failure, Unit>> add(AddPostParams params) async {
    try {
      final imageUrl = await customFireStorage.upload(params.image);

      if (await networkInfo.isConnected) {
        await _remoteDataSource.add(PostRemoteDataModel(
            id: Uuid().v4(),
            description: params.description,
            userLikeIds: [],
            imageUrl: imageUrl,
            uploaderID: authRepo.getLoggedUser().id));
        return right(unit);
      } else {
        return left(NetworkFailure());
      }
    } catch (e) {
      if (kDebugMode) rethrow;
      return left(UnexpectedFailure());
    }
  }

  Future<Either<Failure, Unit>> delete(String id) async {
    if (await networkInfo.isConnected) {
      await _remoteDataSource.delete(id);
      return right(unit);
    } else {
/*
      final result = await _localeDataSource
          .add(LocalDomainMapper.toLocalDataModel(post));
*/
      return right(unit);
    }
  }

  Future<Either<Failure, Unit>> edit(String id, Post post) async {
    if (await networkInfo.isConnected) {
      // await _remoteDataSource.update(id, RemoteDomainMapper.toPostRemoteDataModel(post));
      return right(unit);
    } else {
      final result = await _localeDataSource
          .update(LocalDomainMapper.toLocalDataModel(post));
      return right(unit);
    }
  }

  @override
  Future<Either<Failure, Unit>> likePost(Post post) async {
    try {
      final result = await _remoteDataSource
          .likePost(RemoteDomainMapper.toPostRemoteDataModel(post));
      return right(unit);
    } catch (e) {
      return left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> bookmark(Post post) async {
    try {
      final result =
          await _localeDataSource.add(LocalDomainMapper.toLocalDataModel(post));
      return right(unit);
    } catch (e) {
      rethrow;
      return left(Failure());
      print(e);
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getAllBookmarkedPosts() async {
    try {
      final result = await _localeDataSource.getAll();
      final uploader = authRepo.getLoggedUser();

      return right(LocalDomainMapper.toDomainList(result, uploader));
    } catch (e) {
      return left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> unBookmark(Post post) async {
    try {
      final result = await _localeDataSource.delete(post.id);
      return right(unit);
    } catch (e) {
      return left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> unLikePost(Post post) async {
    try {
      final result = await _remoteDataSource
          .unLikePost(RemoteDomainMapper.toPostRemoteDataModel(post));
      return right(unit);
    } catch (e) {
      return left(Failure());
    }
  }
}
