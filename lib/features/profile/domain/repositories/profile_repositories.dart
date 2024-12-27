import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/profile/data/models/profile_model.dart';

abstract class ProfileRepositories {
  Future<Either<Failure, ProfileModel>> getProfile();
  Future<Either<Failure, void>> updateProfile({
    required String? name,
    required String? surname,
    required String? email,
  });
  Future<Either<Failure, void>> changePassword(
      String oldPassword, String newPassword);
  Future<Either<Failure, void>> addPaymentMethod(
      Map<String, dynamic> paymentData);
}
