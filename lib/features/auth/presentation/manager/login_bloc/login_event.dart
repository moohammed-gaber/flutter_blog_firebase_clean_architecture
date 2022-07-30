part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class EmailChanged extends LoginEvent {
  final EmailAddress email;

  EmailChanged({required this.email});
}

class PasswordChanged extends LoginEvent {
  final Password password;

  PasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {
  LoginSubmitted();
}
