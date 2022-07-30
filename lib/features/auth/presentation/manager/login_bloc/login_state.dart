part of 'login_bloc.dart';

@immutable
class LoginState {
  final EmailAddress email;
  final Password password;
  final Option<Either<AuthFailure, UserEntity>> authFailureOrSuccessOption;

  const LoginState(
      {required this.email,
      required this.authFailureOrSuccessOption,
      required this.password});

  factory LoginState.initial() => LoginState(
        email: EmailAddress(''),
        authFailureOrSuccessOption: none(),
        password: Password(''),
      );

  //copy with
  LoginState copyWith({
    EmailAddress? email,
    Password? password,
    Option<Either<AuthFailure, UserEntity>>? authFailureOrSuccessOption,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      authFailureOrSuccessOption:
          authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
    );
  }
}
