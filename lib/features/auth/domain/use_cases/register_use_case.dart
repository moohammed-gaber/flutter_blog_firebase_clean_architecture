import 'package:dartz/dartz.dart';
import 'package:flutter_blog_firebase/core/use_case/use_case.dart';
import 'package:flutter_blog_firebase/core/value_objects/email_value_object.dart';
import 'package:flutter_blog_firebase/core/value_objects/name_value_object.dart';
import 'package:flutter_blog_firebase/core/value_objects/password_value_object.dart';
import 'package:flutter_blog_firebase/features/auth/domain/repositories/auth_repo.dart';

import '../failures.dart';

class RegisterUseCase implements FailureUseCase<Unit, RegisterParams> {
  final AuthRepo authRepo;

  RegisterUseCase(this.authRepo);

  @override
  Future<Either<AuthFailure, Unit>> call(RegisterParams params) {
    return authRepo.register(params);
  }
}

class RegisterParams {
  final EmailAddress emailAddress;
  final Password password;
  final Name firstName, lastName;

  String get fullName => '${firstName.getOrCrash()} ${lastName.getOrCrash()}';

  RegisterParams(
      {required this.emailAddress,
      required this.firstName,
      required this.lastName,
      required this.password});
}
