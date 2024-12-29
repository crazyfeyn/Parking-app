// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:flutter_application/features/profile/data/models/profile_model.dart';

class ProfileEntity {
  int id;
  String email;
  String first_name;
  String last_name;
  bool owns_parking;
  ProfileEntity({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.owns_parking,
  });
}

extension ProfileMapper on ProfileEntity {
  ProfileModel toModel() {
    return ProfileModel(
        id: id,
        email: email,
        first_name: first_name,
        last_name: last_name,
        owns_parking: owns_parking);
  }
}
