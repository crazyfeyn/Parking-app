// ignore_for_file: non_constant_identifier_names
import 'package:flutter_application/features/profile/domain/entity/profile_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileModel with _$ProfileModel {
  factory ProfileModel({
    required int id,
    required String email,
    required String first_name,
    required String last_name,
    required bool owns_parking,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelImpl.fromJson(json);
}

extension ProfileMapper on ProfileModel {
  ProfileEntity toEntity() {
    return ProfileEntity(
        id: id,
        email: email,
        first_name: first_name,
        last_name: last_name,
        owns_parking: owns_parking);
  }
}
