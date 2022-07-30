import 'package:dartz/dartz.dart';
import 'package:flutter_blog_firebase/core/value_object.dart';

class Name extends ValueObject<String> {
  static Either<ValueFailure<String>, String> validatePassword(String input) {
    if (input.length >= 3) {
      return right(input);
    } else {
      return left(ValueFailure());
    }
  }

  @override
  final Either<ValueFailure<String>, String> value;

  factory Name(String input) {
    assert(input != null);
    return Name._(
      validatePassword(input),
    );
  }

  const Name._(this.value);
}
