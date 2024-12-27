// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter_application/features/profile/data/models/profile_model.dart';

class ProfileDataSources {
  Dio dio;
  ProfileDataSources({
    required this.dio,
  });

  Future<ProfileModel> getProfile(String token) async {
    final recponce = await dio.get('users/profile/');
    return ProfileModel.fromJson(recponce.data);
  }
}
