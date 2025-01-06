part of 'history_bloc.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default(Status.initial) Status status,
    @Default([]) List<BookingView> bookingList,
    @Default([]) List<BookingView> currentBookingList,
  }) = _HistoryState;
}
