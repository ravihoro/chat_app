import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/model/user_model.dart';
import 'package:chat_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationUsecase {
  final AuthenticationRepository repository;

  const AuthenticationUsecase(this.repository);

  Future<Either<Failure, User>> login({
    required String username,
    required String password,
  }) async {
    return repository.login(username: username, password: password);
  }

  Future<Either<Failure, User>> signUp({
    required String username,
    required String password,
  }) async {
    return repository.signUp(username: username, password: password);
  }

  Future<Either<Failure, User>> checkIfLoggedIn() async {
    return repository.checkIfLoggedIn();
  }

  Future<Failure?> logout() async {
    return await repository.logout();
  }
}
