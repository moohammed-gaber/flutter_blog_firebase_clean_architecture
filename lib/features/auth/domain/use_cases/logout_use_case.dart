import 'package:flutter_blog_firebase/core/domain/entities/user_entity.dart';
import 'package:flutter_blog_firebase/core/use_case/use_case.dart';
import 'package:flutter_blog_firebase/core/value_objects/email_value_object.dart';
import 'package:flutter_blog_firebase/core/value_objects/password_value_object.dart';
import 'package:flutter_blog_firebase/features/auth/domain/repositories/auth_repo.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepo authRepo;

  LogoutUseCase(this.authRepo);

  @override
  Future<void> call(NoParams) {
    return authRepo.logout();
  }
}
