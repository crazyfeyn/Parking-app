import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';

abstract class AuthRepositories {
  Future<Either<Failure, void>> register(String password,String email);
  Future<Either<Failure, void>> logIn(String password,String email);
  Future<Either<Failure, void>> resetPass(String email);
  Future< void> refreshToken();
  Future<Either<Failure, void>> logOut();


}
