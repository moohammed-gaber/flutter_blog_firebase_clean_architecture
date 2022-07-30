import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blog_firebase/core/app_routes.dart';
import 'package:flutter_blog_firebase/core/custom_firestorage.dart';
import 'package:flutter_blog_firebase/core/local_data_source_initlaizer.dart';
import 'package:flutter_blog_firebase/core/network/network_info.dart';
import 'package:flutter_blog_firebase/features/auth/data/remote/data_sources/users_remote_data_source.dart';
import 'package:flutter_blog_firebase/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_blog_firebase/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_blog_firebase/features/auth/domain/use_cases/register_use_case.dart';
import 'package:flutter_blog_firebase/features/auth/presentation/manager/login_bloc/login_bloc.dart';
import 'package:flutter_blog_firebase/features/posts/data/local/data_sources/posts_local_data_source.dart';
import 'package:flutter_blog_firebase/features/posts/data/remote/data_sources/posts_remote_data_source.dart';
import 'package:flutter_blog_firebase/features/posts/data/repositories/posts_repo.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/toogle_like_post_use_case.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/load_posts_use_case.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/manager/posts_bloc/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

import '../features/auth/presentation/manager/register_bloc/register_bloc.dart';

class Injection {
  static final getIt = GetIt.instance;

  static setup() async {
    openDatabase('path');
    final LocalDataSourceInitializer localDataSourceInitializer =
        LocalDataSourceInitializer();
    await localDataSourceInitializer.openDatabaseConnection();
    getIt.registerSingleton<Database>(localDataSourceInitializer.database);
    getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
    final firebaseAuth = getIt.get<FirebaseAuth>();
    getIt.registerSingleton<AppRoutes>(AppRoutes(firebaseAuth));

    getIt.registerSingleton<AuthRepoImpl>(
      AuthRepoImpl(UsersRemoteDataSource(getIt.get<FirebaseAuth>()),
          getIt.get<FirebaseAuth>()),
    );
    getIt.registerLazySingleton(
      () => PostsRepoImpl(
          PostsRemoteDataSource(firebaseAuth),
          PostsLocaleDataSource(localDataSourceInitializer.database),
          NetworkInfoImpl(DataConnectionChecker()),
          getIt.get<AuthRepoImpl>(),
          CustomFireStorage(FirebaseStorage.instance)),
    );
    getIt.registerFactory<PostsBloc>(() => PostsBloc(
        LoadPostsUseCase(getIt.get<PostsRepoImpl>()),
        ToggleLikePostsUseCase(getIt.get<PostsRepoImpl>())));
    getIt.registerFactory<RegisterBloc>(() => RegisterBloc(RegisterUseCase(
          getIt.get<AuthRepoImpl>(),
        )));

    getIt.registerFactory<LoginBloc>(() => LoginBloc(LoginUseCase(
          getIt.get<AuthRepoImpl>(),
        )));
  }
}
