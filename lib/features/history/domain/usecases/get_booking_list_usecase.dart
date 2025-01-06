import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/history/domain/repositories/history_repositories.dart';

class GetBookingListUsecase extends Usecase {
  HistoryRepositories profileRepositories;
  GetBookingListUsecase({required this.profileRepositories});

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return profileRepositories.getBookingList();
  }
}
