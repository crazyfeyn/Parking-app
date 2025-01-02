import 'package:flutter/material.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/booking_space/data/models/booking_model.dart';

class BookingProvider extends ChangeNotifier {
  DateTime? _selectedDate;
  String? _selectedBookingType;
  String? _selectedDuration;
  String? _selectedVehicle;
  String? _selectedPaymentMethod;
  final LocationModel locationModel;
  String? _vehicleType;
  String? _unitNumber;
  int? _year;
  String? make;
  String? _model;
  String? _plateNumber;
  //!LOOOOOOOOOK idni haqiqiysini bervor
  int? user;

  BookingProvider({required this.locationModel});

  DateTime? get selectedDate => _selectedDate;
  String? get selectedBookingType => _selectedBookingType;
  String? get selectedDuration => _selectedDuration;
  String? get selectedVehicleType => _selectedVehicle;
  String? get selectedPaymentMethod => _selectedPaymentMethod;

  String? get vehicleType => _vehicleType;
  String? get unitNumber => _unitNumber;
  int? get year => _year;
  String? get model => _model;
  String? get plateNumber => _plateNumber;
  int? get userId => user;

  bool get isFormValid =>
      _selectedDate != null &&
      _selectedBookingType != null &&
      _selectedDuration != '' &&
      _selectedVehicle != null &&
      _selectedPaymentMethod != null &&
      locationModel.availableSpots! > 0;

  bool get isFormValidVehicle {
    user = 22;
    return _vehicleType != null &&
        _unitNumber != null &&
        _year != null &&
        make != null &&
        _model != null &&
        _plateNumber != null &&
        user != null;
  }

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

  void setVehicle(String vehicle) {
    _selectedVehicle = vehicle;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  void setVehicleType(String? type) {
    _vehicleType = type;
    notifyListeners();
  }

  void setUnitNumber(String unit) {
    _unitNumber = unit;
    notifyListeners();
  }

  void setYear(int year) {
    _year = year;
    notifyListeners();
  }

  void setMake(String carMake) {
    make = carMake;
    notifyListeners();
  }

  void setModel(String carModel) {
    _model = carModel;
    notifyListeners();
  }

  void setPlateNumber(String plate) {
    _plateNumber = plate;
    notifyListeners();
  }

  void setUser(int userId) {
    user = userId;
    notifyListeners();
  }

  void handleBooking() {
    if (!isFormValid) return;

    final booking = BookingModel(
      locationId: locationModel.id,
      startDate: _selectedDate!,
      bookingType: _selectedBookingType!,
      duration: _selectedDuration!,
      vehicleType: _selectedVehicle!,
      paymentMethod: _selectedPaymentMethod!,
    );

    print('Booking data: ${booking.toMap()}');
  }

  void handleVehicleCreation(int userId) {
    if (!isFormValid) {
      return;
    }

    final vehicle = VehicleModel(
        type: _vehicleType!,
        unitNumber: _unitNumber!,
        year: _year!,
        make: make!,
        model: _model!,
        plateNumber: _plateNumber!,
        user: userId);

    print('Vehicle data: ${vehicle.toJson()}');
  }

  createVehicle() {}

  void clearForm() {}
}
