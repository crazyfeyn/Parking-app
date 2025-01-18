import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/history/domain/repositories/history_repositories.dart';

class GetBookingListUsecase extends Usecase {
  HistoryRepositories historyRepositories;
  GetBookingListUsecase({required this.historyRepositories});

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return historyRepositories.getBookingList();
  }
}
