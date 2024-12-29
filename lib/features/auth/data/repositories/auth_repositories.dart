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
  Future<bool> authoricated() {
    return authDatasources.authicated();
  }

  @override
  Future<Either<Failure, void>> logOut() {
    return _logOut(() => authDatasources.logOut());
  }

  @override
  Future<Either<Failure, void>> changePass(String oldPass, String newPass) {
    return _change(() => authDatasources.changePass(oldPass, newPass));
  }

  Future<Either<Failure, void>> _change(Future<void> Function() change) async {
    try {
      return Right(await change());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, void>> _logOut(Future<void> Function() log) async {
    try {
      print('REPOODAAOAOAAO');
      return Right(await log());
    } catch (e) {
      return Left(CacheFailure());
    }
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
