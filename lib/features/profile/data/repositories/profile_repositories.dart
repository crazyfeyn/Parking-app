// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/profile/data/datasources/profile_datasources.dart';
import 'package:flutter_application/features/profile/data/datasources/profile_local_data_sources.dart';
import 'package:flutter_application/features/profile/data/models/profile_model.dart';
import 'package:flutter_application/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_application/features/profile/domain/repositories/profile_repositories.dart';

class ProfileRepositoriesImpl extends ProfileRepositories {
  ProfileLocalDataSources profileLocalDataSources;
  final ProfileDatasources profileDatasources;

  ProfileRepositoriesImpl({
    required this.profileLocalDataSources,
    required this.profileDatasources,
  });

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final profile = await profileDatasources.getProfile();
      profileLocalDataSources.saveId(profile.id);
      return Right(profile.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
      String oldPassword, String newPassword) async {
    try {
      await profileDatasources.changePassword(
          oldPassword: oldPassword, newPassword: newPassword);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addPaymentMethod(
      Map<String, dynamic> paymentData) async {
    try {
      await profileDatasources.addPaymentMethod(paymentData);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(
      {required String name,
      required String surname,
      required String email}) async {
    try {
      await profileDatasources.updateProfile(
          name: name, surname: surname, email: email);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
