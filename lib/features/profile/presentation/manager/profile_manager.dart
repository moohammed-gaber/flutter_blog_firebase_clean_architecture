import 'package:flutter/material.dart';
import 'package:flutter_blog_firebase/core/domain/entities/user_entity.dart';
import 'package:flutter_blog_firebase/core/injection.dart';
import 'package:flutter_blog_firebase/core/use_case/use_case.dart';
import 'package:flutter_blog_firebase/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_blog_firebase/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:flutter_blog_firebase/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileProvider =
    ChangeNotifierProvider.autoDispose<ProfileProvider>((ref) {
  return ProfileProvider(
    GetProfileUseCase(Injection.getIt.get<AuthRepoImpl>()),
    LogoutUseCase(Injection.getIt.get<AuthRepoImpl>()),
  );
});

class ProfileProvider extends ChangeNotifier {
  ProfileProvider(
    this.getProfileUseCase,
    this.logoutUseCase,
  ) {
    userEntity = getProfileUseCase.call(NoParams());
  }

  final GetProfileUseCase getProfileUseCase;
  final LogoutUseCase logoutUseCase;

  late final UserEntity userEntity;

  // logout
  Future<void> logout() async {
    await logoutUseCase.call(NoParams());
  }
}
