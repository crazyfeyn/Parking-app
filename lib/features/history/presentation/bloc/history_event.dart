part of 'history_bloc.dart';

@freezed
class HistoryEvent with _$HistoryEvent {
  const factory HistoryEvent.getBookingList() = _getBookingList;
  const factory HistoryEvent.getCurrentBookingList() = _getCurrentBookingList;
}
