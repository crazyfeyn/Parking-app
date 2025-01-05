// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/home/domain/repositories/home_repositories.dart';

class FetchSearchUsecase extends Usecase<List<LocationModel>, String> {
  HomeRepositories homeRepositories;
  FetchSearchUsecase({
    required this.homeRepositories,
  });
  @override
  Future<Either<Failure, List<LocationModel>>> call(String params) {
    return homeRepositories.fetchSearchAllLocations(params);
  }
}
