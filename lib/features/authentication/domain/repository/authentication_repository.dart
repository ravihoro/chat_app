import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/model/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, User>> signUp({
    required String username,
    required String password,
  });

  Future<Either<Failure, User>> checkIfLoggedIn();

  Future<Failure?> logout();
}
