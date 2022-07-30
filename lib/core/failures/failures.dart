import 'package:flutter_blog_firebase/features/auth/domain/failures.dart';

class Failure {}

class NetworkFailure extends Failure {}

// unexpected error
class UnexpectedFailure extends Failure implements AuthFailure {}
// class UnExcepected extends Failure {}
