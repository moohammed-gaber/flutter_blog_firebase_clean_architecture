import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blog_firebase/core/value_objects/email_value_object.dart';
import 'package:flutter_blog_firebase/core/value_objects/name_value_object.dart';
import 'package:flutter_blog_firebase/core/value_objects/password_value_object.dart';
import 'package:flutter_blog_firebase/features/auth/domain/failures.dart';
import 'package:flutter_blog_firebase/features/auth/domain/use_cases/register_use_case.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(RegisterState.initial()) {
    print('RegisterBloc');
    on<RegisterEvent>((event, emit) async {
      if (event is EmailChanged) {
        emit(state.copyWith(
          email: event.email,
          authFailureOrSuccessOption: none(),
        ));
      }
      if (event is PasswordChanged) {
        emit(state.copyWith(
          password: event.password,
          authFailureOrSuccessOption: none(),
        ));
      }

      if (event is FirstNameChanged) {
        emit(state.copyWith(
            authFailureOrSuccessOption: none(), firstName: event.firstName));
      }
      if (event is LastNameChanged) {
        emit(state.copyWith(
            authFailureOrSuccessOption: none(), lastName: event.lastName));
      }

      if (event is RegisterSubmitted) {
        final params = RegisterParams(
          emailAddress: state.email,
          password: state.password,
          firstName: state.firstName,
          lastName: state.lastName,
        );
        final result = await registerUseCase.call(params);
        emit(state.copyWith(authFailureOrSuccessOption: some(result)));
      }
    });
  }
}
