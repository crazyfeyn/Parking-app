import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/booking_space/data/datasources/booking_datasources.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/server_locator.dart';

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
  int? user;

  final BookingDatasources bookingDatasources;

  BookingProvider({required this.locationModel})
      : bookingDatasources = sl<BookingDatasources>();

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
    return _vehicleType != null &&
        _vehicleType!.isNotEmpty &&
        _unitNumber != null &&
        _year != null &&
        make != null &&
        _model != null &&
        _plateNumber != null;
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

  Future<void> handleBooking() async {
    if (!isFormValid) return;

    try {
      final booking = BookingView(
        id: 0,
        status: BookingStatus(id: 1, name: 'Pending'),
        client: 'Client Name',
        spot: locationModel.name,
        vehicle: _selectedVehicle!,
        duration: int.parse(_selectedDuration!),
        weekly: _selectedBookingType == 'Weekly',
        daily: _selectedBookingType == 'Daily',
        monthly: _selectedBookingType == 'Monthly',
        startDate: _selectedDate!.toIso8601String(),
        endDate: _calculateEndDate(_selectedDate!, _selectedBookingType!,
            int.parse(_selectedDuration!)),
        createdAt: DateTime.now().toIso8601String(),
        reservationNumber: null,
        lastUpdated: DateTime.now().toIso8601String(),
        extendedFor: null,
      );

      await bookingDatasources.bookingFunc(booking);

      print('Booking created successfully');
    } catch (e) {
      print('Error creating booking: $e');
    }
  }

  String _calculateEndDate(
      DateTime startDate, String bookingType, int duration) {
    DateTime endDate;

    switch (bookingType) {
      case 'Daily':
        endDate = startDate.add(Duration(days: duration));
        break;
      case 'Weekly':
        endDate = startDate.add(Duration(days: duration * 7));
        break;
      case 'Monthly':
        endDate =
            DateTime(startDate.year, startDate.month + duration, startDate.day);
        break;
      default:
        throw ArgumentError('Invalid booking type: $bookingType');
    }

    return endDate.toIso8601String();
  }

  void handleVehicleCreation(int userId) {
    if (!isFormValid) {
      return;
    }
    print('-----User ID: $user');

    final vehicle = VehicleModel(
      type: _vehicleType!,
      unitNumber: _unitNumber!,
      year: _year!,
      make: make!,
      model: _model!,
      plateNumber: _plateNumber!,
      user: userId,
    );

    print('Vehicle data: ${vehicle.toJson()}');
  }

  void clearForm() {
    _selectedDate = null;
    _selectedBookingType = null;
    _selectedDuration = null;
    _selectedVehicle = null;
    _selectedPaymentMethod = null;
    notifyListeners();
  }

  void fetchUserProfile(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    profileBloc.add(const ProfileEvent.getProfile());

    context.read<ProfileBloc>().stream.listen((state) {
      if (state.status == Status.success && state.profile != null) {
        setUser(state.profile!.id);
      } else if (state.status == Status.error) {
        print('--------Failed to fetch user profile: ${state.message}');
      }
    });
  }
}
