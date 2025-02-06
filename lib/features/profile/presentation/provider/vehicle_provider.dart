import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleProvider extends ChangeNotifier {
  String? _vehicleType;
  String? _unitNumber;
  int? _year;
  String? _make;
  String? _model;
  String? _plateNumber;
  int? _userId;
  int? _vehicleId;

  String? get vehicleType => _vehicleType;
  String? get unitNumber => _unitNumber;
  int? get year => _year;
  String? get make => _make;
  String? get model => _model;
  String? get plateNumber => _plateNumber;
  int? get userId => _userId;
  int? get vehicleId => _vehicleId;

  bool get isFormValidVehicle {
    return _vehicleType != null &&
        _vehicleType!.isNotEmpty &&
        _unitNumber != null &&
        _unitNumber!.isNotEmpty &&
        _year != null &&
        _year != 0 &&
        _make != null &&
        _make!.isNotEmpty &&
        _model != null &&
        _model!.isNotEmpty &&
        _plateNumber != null &&
        _plateNumber!.isNotEmpty;
  }

  void setVehicleType(String? type) {
    _vehicleType = type;
    notifyListeners();
  }

  void setVehicleId(int? id) {
    _vehicleId = id;
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
    _make = carMake;
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
    _userId = userId;
    notifyListeners();
  }

  void clearForm() {
    _vehicleType = null;
    _unitNumber = null;
    _year = null;
    _make = null;
    _model = null;
    _plateNumber = null;
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

  void handleVehicleCreation() {
    if (!isFormValidVehicle) {
      return;
    }
  }
}
