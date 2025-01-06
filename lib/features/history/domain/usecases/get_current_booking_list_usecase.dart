import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/history/domain/repositories/history_repositories.dart';

class GetCurrentBookingListUsecase extends Usecase {
  HistoryRepositories historyRepositories;

  GetCurrentBookingListUsecase({required this.historyRepositories});

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return historyRepositories.getCurrentBookingList();
  }
}
