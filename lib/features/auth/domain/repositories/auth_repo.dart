import 'package:dartz/dartz.dart';
import 'package:flutter_blog_firebase/core/domain/entities/user_entity.dart';
import 'package:flutter_blog_firebase/core/value_objects/email_value_object.dart';
import 'package:flutter_blog_firebase/core/value_objects/password_value_object.dart';
import 'package:flutter_blog_firebase/features/auth/domain/failures.dart';
import 'package:flutter_blog_firebase/features/auth/domain/use_cases/register_use_case.dart';

abstract class AuthRepo {
  UserEntity getLoggedUser();

  Future<UserEntity> getUserById(String id);

  Future<void> logout();

  Future<Either<AuthFailure, UserEntity>> login(
      EmailAddress emailAddress, Password password);

  Future<Either<AuthFailure, Unit>> register(
    RegisterParams registerParams,
  );
}
