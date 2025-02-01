import 'package:flutter/material.dart';
import 'package:flutter_application/features/home/data/models/filter_model.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';

class FilterProvider extends ChangeNotifier {
  final FilterModel _filterModel = FilterModel();
  List<LocationModel> _filteredLocations = [];

  List<LocationModel> get filteredLocations => _filteredLocations;
  FilterModel get filterModel => _filterModel;

  void setState(String state) {
    _filterModel.state = state;
    notifyListeners();
  }

  void setCity(String city) {
    _filterModel.city = city;
    notifyListeners();
  }

  void updateAllowedServices(String key, bool value) {
    _filterModel.allowedServices[key] = value;
    notifyListeners();
  }

  void updateOneServiceAllowed(String key, bool value) {
    _filterModel.oneServiceAllowed[key] = value;
    notifyListeners();
  }

  void updateAdditionalServices(String key, bool value) {
    _filterModel.additionalServices[key] = value;
    notifyListeners();
  }

  void filterLocations(List<LocationModel> allLocations) {
    _filteredLocations = allLocations.where((location) {
      final matchState =
          _filterModel.state == null || location.state == _filterModel.state;
      final matchCity =
          _filterModel.city == null || location.city == _filterModel.city;
      return matchState && matchCity;
    }).toList();

    notifyListeners();
  }
}
