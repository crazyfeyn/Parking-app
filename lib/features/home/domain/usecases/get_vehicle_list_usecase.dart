import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/domain/repositories/home_repositories.dart';

class GetVehicleListUsecase extends Usecase {
  HomeRepositories homeRepositories;

  GetVehicleListUsecase({required this.homeRepositories});

  @override
  Future<Either<Failure, List<VehicleModel>>> call(params) {
    return homeRepositories.fetchVehicleList();
  }
}
