import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart';

abstract class HistoryRepositories {
  Future<Either<Failure, List<BookingView>>> getBookingList();
  Future<Either<Failure, List<BookingView>>> getCurrentBookingList();
}
