// booking_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';

class BookingProvider extends ChangeNotifier {
  DateTime? _selectedDate;
  String? _selectedBookingType;
  String? _selectedDuration;
  String? _selectedVehicleType;
  String? _selectedPaymentMethod;
  final LocationModel locationModel;

  BookingProvider({required this.locationModel});

  // Getters
  DateTime? get selectedDate => _selectedDate;
  String? get selectedBookingType => _selectedBookingType;
  String? get selectedDuration => _selectedDuration;
  String? get selectedVehicleType => _selectedVehicleType;
  String? get selectedPaymentMethod => _selectedPaymentMethod;

  bool get isFormValid =>
      _selectedDate != null &&
      _selectedBookingType != null &&
      _selectedDuration != null &&
      _selectedVehicleType != null &&
      _selectedPaymentMethod != null &&
      locationModel.availableSpots! > 0;

  // Setters
  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setBookingType(String type) {
    _selectedBookingType = type;
    notifyListeners();
  }

  void setDuration(String duration) {
    _selectedDuration = duration;
    notifyListeners();
  }

  void setVehicleType(String type) {
    _selectedVehicleType = type;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  void handleBooking() {
    if (!isFormValid) return;

    final bookingData = {
      'location_id': locationModel.id,
      'start_date': _selectedDate?.toIso8601String(),
      'booking_type': _selectedBookingType,
      'duration': _selectedDuration,
      'vehicle_type': _selectedVehicleType,
      'payment_method': _selectedPaymentMethod,
    };

    // Here you would make your API call
    print('Booking data: $bookingData');
  }
}
