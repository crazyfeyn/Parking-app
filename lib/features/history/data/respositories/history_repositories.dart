import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/history/data/datasources/history_datasources.dart';
import 'package:flutter_application/features/history/domain/repositories/history_repositories.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart';

class HistoryRepositoriesImpl extends HistoryRepositories {
  final HistoryDatasources historyDatasources;

  HistoryRepositoriesImpl({required this.historyDatasources});

  @override
  Future<Either<Failure, List<BookingView>>> getBookingList() async {
    try {
      final bookingList = await historyDatasources.getBookingList();
      return Right(bookingList);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<BookingView>>> getCurrentBookingList() async {
    try {
      final currentBookingList =
          await historyDatasources.getCurrentBookingList();
      return Right(currentBookingList);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
