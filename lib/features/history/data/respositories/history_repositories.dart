import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/history/data/datasources/history_datasources.dart';
import 'package:flutter_application/features/history/domain/repositories/history_repositories.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HistoryRepositoriesImpl extends HistoryRepositories {
  final HistoryDatasources historyDatasources;
  InternetConnectionChecker internetConnectionChecker;

  HistoryRepositoriesImpl(
      {required this.historyDatasources,
      required this.internetConnectionChecker});

  @override
  Future<Either<Failure, List<BookingView>>> getBookingList() async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final bookingList = await historyDatasources.getBookingList();
        return Right(bookingList);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<BookingView>>> getCurrentBookingList() async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final currentBookingList =
            await historyDatasources.getCurrentBookingList();
        return Right(currentBookingList);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
