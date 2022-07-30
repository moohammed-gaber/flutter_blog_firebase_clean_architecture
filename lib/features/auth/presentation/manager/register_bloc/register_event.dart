part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class EmailChanged extends RegisterEvent {
  final EmailAddress email;

  EmailChanged({required this.email});
}

class PasswordChanged extends RegisterEvent {
  final Password password;

  PasswordChanged({required this.password});
}

class FirstNameChanged extends RegisterEvent {
  final Name firstName;

  FirstNameChanged({required this.firstName});
}

// last name changed
class LastNameChanged extends RegisterEvent {
  final Name lastName;

  LastNameChanged({required this.lastName});
}

class RegisterSubmitted extends RegisterEvent {
  RegisterSubmitted();
}
