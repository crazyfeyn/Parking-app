import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/dio_config.dart';
import 'package:flutter_application/core/error/exception.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/profile/data/models/profile_model.dart';

class ProfileDatasources {
  ProfileModel? cachedProfile;
  final DioConfig dioConfig;

  ProfileDatasources({required this.dioConfig, ProfileModel? cachedProfile});

  Future<ProfileModel> getProfile() async {
    try {
      final response = await dioConfig!.client.get('/users/profile/');

      if (response.statusCode == 200) {
        cachedProfile = ProfileModel.fromJson(response.data);
        return cachedProfile!;
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: '/users/profile/'),
          error: 'Failed to fetch profile',
        );
      }
    } on DioException {
      throw ServerException();
    } catch (e) {
      throw ServerFailure();
    }
  }

  Future<void> updateProfile({
    String? name,
    String? surname,
    String? email,
  }) async {
    try {
      final updateData = {
        if (name != null) 'name': name,
        if (surname != null) 'surname': surname,
        if (email != null) 'email': email,
      };

      final response = await dioConfig.client.patch(
        '/users/profile/',
        data: updateData,
      );

      if (response.statusCode == 200) {
        cachedProfile = cachedProfile?.copyWith(
          name: name,
          surname: surname,
          email: email,
        );
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: '/users/profile/'),
          error: 'Failed to update profile',
        );
      }
    } catch (e) {
      throw ServerException();
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await dioConfig.client.post(
        '/users/change-password/',
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );
    } catch (e) {
      throw ServerException();
    }
  }

  Future<void> addPaymentMethod(Map<String, dynamic> paymentData) async {
    try {
      await dioConfig.client.post(
        '/users/add-payment-method/',
        data: paymentData,
      );
    } catch (e) {
      throw ServerException();
    }
  }
}
