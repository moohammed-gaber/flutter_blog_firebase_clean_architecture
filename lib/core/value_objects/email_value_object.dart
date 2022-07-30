import 'package:dartz/dartz.dart';
import 'package:flutter_blog_firebase/core/value_object.dart';

class EmailAddress extends ValueObject<String> {
  static Either<ValueFailure<String>, String> validate(String input) {
    const emailRegex =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
    if (RegExp(emailRegex).hasMatch(input)) {
      return right(input);
    } else {
      return left(ValueFailure());
    }
  }

  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(
      validate(input),
    );
  }

  const EmailAddress._(this.value);
}
