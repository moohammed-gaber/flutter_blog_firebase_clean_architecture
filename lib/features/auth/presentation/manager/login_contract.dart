import 'package:flutter_blog_firebase/core/domain/entities/user_entity.dart';
import 'package:flutter_blog_firebase/features/auth/domain/failures.dart';
import 'package:flutter_blog_firebase/features/auth/domain/use_cases/login_use_case.dart';

abstract class LoginContract {
  onLogin(LoginParams loginParams);

  void onLoginSuccess(UserEntity loggedUser);

  void onLoginFailure(AuthFailure failure);
}
