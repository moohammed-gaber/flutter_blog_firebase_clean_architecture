part of 'register_bloc.dart';

@immutable
class RegisterState {
  final EmailAddress email;
  final Password password;
  final Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption;
  final Name firstName, lastName;

  const RegisterState(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.authFailureOrSuccessOption,
      required this.password});

  factory RegisterState.initial() {
/*
    if (kDebugMode) {
      return RegisterState(
        email: EmailAddress('moohamedgaber@gmail.com'),
        lastName: Name('gaber'),
        firstName: Name('mssso'),
        authFailureOrSuccessOption: none(),
        password: Password('123456'),
      );
    }
*/
    return RegisterState(
      email: EmailAddress(''),
      lastName: Name(''),
      firstName: Name(''),
      authFailureOrSuccessOption: none(),
      password: Password(''),
    );
  }

  //copy with
  RegisterState copyWith({
    EmailAddress? email,
    Password? password,
    Option<Either<AuthFailure, Unit>>? authFailureOrSuccessOption,
    Name? firstName,
    Name? lastName,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      authFailureOrSuccessOption:
          authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
    );
  }
}
