import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/profile/domain/repositories/profile_repositories.dart';

class AddPaymentMethodUsecase extends Usecase<void, Map<String, dynamic>> {
  final ProfileRepositories profileRepositories;

  AddPaymentMethodUsecase({required this.profileRepositories});

  @override
  Future<Either<Failure, void>> call(Map<String, dynamic> params) {
    return profileRepositories.addPaymentMethod(params);
  }
}
