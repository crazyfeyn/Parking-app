import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/booking_space/data/datasources/booking_datasources.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/data/models/booking_model.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/server_locator.dart';

class BookingProvider extends ChangeNotifier {
  DateTime? _selectedDate;
  String? _selectedBookingType;
  String? _selectedDuration;
  String? _selectedVehicle;
  String? _selectedCard;
  final LocationModel locationModel;
  String? _vehicleType;
  String? _unitNumber;
  int? _year;
  String? make;
  String? _model;
  String? _plateNumber;
  int? user;
  int? _paymentId;
  int? _selectedVehicleId;
  int? _selectedVehicleIdExtend;
  String? _selectedVehicleExtend;
  String? _selectedDurationExtend;
  String? _selectedCardExtend;
  int? _paymentIdExtend;

  final BookingDatasources bookingDatasources;

  BookingProvider({required this.locationModel})
      : bookingDatasources = sl<BookingDatasources>();

  DateTime? get selectedDate => _selectedDate;
  String? get selectedBookingType => _selectedBookingType;
  String? get selectedDuration => _selectedDuration;
  String? get selectedVehicleType => _selectedVehicle;
  String? get selectedPaymentMethod => _selectedCard;
  String? get selectedDurationExtend => _selectedDurationExtend;
  String? get selectedVehicleExtend => _selectedVehicleExtend;
  int? get selectedVehicleIdExtend => _selectedVehicleIdExtend;
  String? get selectedCardExtend => _selectedCardExtend;
  int? get paymentIdExtend => _paymentIdExtend;

  String? get vehicleType => _vehicleType;
  String? get unitNumber => _unitNumber;
  int? get year => _year;
  String? get model => _model;
  String? get plateNumber => _plateNumber;
  int? get userId => user;
  int? get paymentId => _paymentId;
  int? get vehicleId => _selectedVehicleId;

  bool get isFormValid =>
      _selectedDate != null &&
      _selectedBookingType != null &&
      _selectedDuration != null &&
      _selectedVehicle != null &&
      _selectedCard != null &&
      locationModel.availableSpots! > 0 &&
      paymentId != null;

  bool get isFormValidVehicle {
    return _vehicleType != null &&
        _vehicleType!.isNotEmpty &&
        _unitNumber != null &&
        _unitNumber!.isNotEmpty &&
        _year != null &&
        make != null &&
        make!.isNotEmpty &&
        _model != null &&
        model!.isNotEmpty &&
        _plateNumber != null &&
        plateNumber!.isNotEmpty;
  }

  bool get isExtendBookingValid =>
      _selectedDurationExtend != null && paymentIdExtend != null;

  bool get isBookingUpdateVehicleValid =>
      _selectedVehicleExtend != null && selectedVehicleIdExtend != null;

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

  void setDurationExtend(String duration) {
    _selectedDurationExtend = duration;
    notifyListeners();
  }

  void setVehicle(String vehicle, int? vehicleId) {
    _selectedVehicle = vehicle;
    _selectedVehicleId = vehicleId;
    notifyListeners();
  }

  void setVehicleExtend(String vehicle, int? vehicleId) {
    _selectedVehicleExtend = vehicle;
    _selectedVehicleIdExtend = vehicleId;
    notifyListeners();
  }

  void setPaymentMethod(String method, int paymentId) {
    _selectedCard = method;
    _paymentId = paymentId;
    notifyListeners();
  }

  void setPaymentMethodExtend(String method, int paymentId) {
    _selectedCardExtend = method;
    _paymentIdExtend = paymentId;
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

  void setPaymentId(int paymentId) {
    _paymentId = paymentId;
    notifyListeners();
  }

  Future<Status?> handleBooking() async {
    if (!isFormValid) return null;

    try {
      final formattedDate =
          "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}";

      final booking = BookingModel(
        vehicleId: _selectedVehicleId!,
        duration: int.parse(_selectedDuration!),
        weekly: _selectedBookingType == 'weekly',
        daily: _selectedBookingType == 'daily',
        monthly: _selectedBookingType == 'monthly',
        startDate: formattedDate,
        paymentMethodId: _paymentId!,
        locationId: locationModel.id,
      );

      final response = await bookingDatasources.bookingFunc(booking);
      return response;
    } catch (e) {
      return null;
    }
  }

  void handleVehicleCreation(int userId) {
    if (!isFormValid) {
      return;
    }
  }

  void clearForm() {
    _selectedDate = null;
    _selectedBookingType = null;
    _selectedDuration = null;
    _selectedVehicle = null;
    _selectedCard = null;
    notifyListeners();
  }

  void fetchUserProfile(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    profileBloc.add(const ProfileEvent.getProfile());

    context.read<ProfileBloc>().stream.listen((state) {
      if (state.status == Status.success && state.profile != null) {
        setUser(state.profile!.id);
      } else if (state.status == Status.error) {}
    });
  }

  Future<Status?> extendBooking(int bookingId) async {
    if (!isExtendBookingValid) return null;

    final response = await bookingDatasources.extendBooking(
      id: bookingId,
      duration: int.parse(_selectedDurationExtend!),
      paymentMethodId: _paymentIdExtend!,
    );
    return response;
  }

  Future<Status?> bookingUpdateVehicle({
    required int vehicleId,
    required int bookingId,
  }) async {
    if (!isBookingUpdateVehicleValid) return null;

    final response = await bookingDatasources.updateBookingVehicle(
      vehicleId: vehicleId,
      bookingId: bookingId,
    );
    return response;
  }
}
