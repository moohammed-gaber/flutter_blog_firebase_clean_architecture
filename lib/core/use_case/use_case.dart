import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blog_firebase/core/failures/failures.dart';

abstract class FailureUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class FutureUseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class UseCase<Type, Params> {
  Type call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
