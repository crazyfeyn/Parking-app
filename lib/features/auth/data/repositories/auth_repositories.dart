// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/auth/data/datasources/auth_datasources.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoriesImpl extends AuthRepositories {
  AuthDatasources authDatasources;
  AuthRepositoriesImpl({
    required this.authDatasources,
  });
  @override
  Future<Either<Failure, void>> logIn(String password, String email) {
    return _logIn(() => authDatasources.logIn(password, email));
  }

  @override
  Future<Either<Failure, void>> register(String password, String email) {
    return _register(() => authDatasources.register(password, email));
  }

  @override
  Future<Either<Failure, void>> resetPass(String email) {
    return _reset(() => authDatasources.resetPass(email));
  }

  @override
  Future<void> refreshToken() {
    return authDatasources.startTokenAutoRefresh();
  }

  @override
  Future<Either<Failure, void>> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  Future<Either<Failure, void>> _logIn(Future<void> Function() log) async {
    try {
      return Right(await log());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, void>> _register(
      Future<void> Function() register) async {
    try {
      return Right(await register());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, void>> _reset(Future<void> Function() reset) async {
    try {
      return Right(await reset());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
