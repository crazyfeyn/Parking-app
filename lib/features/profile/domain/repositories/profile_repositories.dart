import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepositories {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, void>> updateProfile({
    required String name,
    required String surname,
    required String email,
  });
  Future<Either<Failure, void>> changePassword(
      String oldPassword, String newPassword);
  Future<Either<Failure, void>> addPaymentMethod(
      Map<String, dynamic> paymentData);
  Future<Either<Failure, String>> generateClientSecretKey();
}
