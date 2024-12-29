import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/home/domain/repositories/location_repositories.dart';
import 'package:flutter_application/features/profile/data/models/vehicle_model.dart';

class GetVehicleListUsecase extends Usecase {
  HomeRepositories homeRepositories;

  GetVehicleListUsecase({required this.homeRepositories});

  @override
  Future<Either<Failure, List<VehicleModel>>> call(params) {
    return homeRepositories.fetchVehicleList();
  }
}
