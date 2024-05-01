import 'dart:developer';

import 'package:chat_app/core/error/exception.dart';
import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/model/user_model.dart';
import 'package:chat_app/features/authentication/data/datasource/authentication_datasource.dart';
import 'package:chat_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDatasource datasource;

  const AuthenticationRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, User>> login(
      {required String username, required String password}) async {
    try {
      var user = await datasource.login(username: username, password: password);
      return Right(user);
    } on LoginException catch (e) {
      return Left(LoginFailure(error: e.message));
    } catch (e) {
      return const Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String username,
    required String password,
  }) async {
    try {
      var user = await datasource.signUp(
        username: username,
        password: password,
      );
      return Right(user);
    } on SignUpException catch (e) {
      return Left(SignUpFailure(error: e.toString()));
    } catch (e) {
      log("sign up: ${e.toString()}");
      return const Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, User>> checkIfLoggedIn() async {
    try {
      var user = await datasource.checkIfLoggedIn();
      return Right(user);
    } catch (e) {
      return Left(GenericFailure(error: e.toString()));
    }
  }
}
