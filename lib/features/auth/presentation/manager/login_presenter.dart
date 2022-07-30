import 'package:flutter_blog_firebase/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_blog_firebase/features/auth/presentation/manager/login_contract.dart';

class LoginPresenter {
  final LoginUseCase loginUseCase;
  final LoginContract contract;

  LoginPresenter(this.loginUseCase, this.contract);

  login(LoginParams loginParams) async {
    final result = await loginUseCase.call(LoginParams(
        emailAddress: loginParams.emailAddress,
        password: loginParams.password));
    result.fold(
        (l) => contract.onLoginFailure(l), (r) => contract.onLoginSuccess(r));
  }
}
