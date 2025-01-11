import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/history/domain/usecases/get_booking_list_usecase.dart';
import 'package:flutter_application/features/history/domain/usecases/get_current_booking_list_usecase.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_bloc.freezed.dart';
part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetBookingListUsecase getBookingListUsecase;
  final GetCurrentBookingListUsecase getCurrentBookingListUsecase;

  HistoryBloc(this.getBookingListUsecase, this.getCurrentBookingListUsecase)
      : super(const HistoryState()) {
    on<_getBookingList>(_getBookingListFunc);
    on<_getCurrentBookingList>(getCurrentBookingListFunc);
  }

  Future<void> _getBookingListFunc(
      _getBookingList event, Emitter<HistoryState> emit) async {}

  Future<void> getCurrentBookingListFunc(
      // ignore: library_private_types_in_public_api
      _getCurrentBookingList event,
      Emitter<HistoryState> emit) async {}
}
