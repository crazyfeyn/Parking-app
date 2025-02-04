import 'package:dio/dio.dart';
import 'package:flutter_application/core/error/exception.dart';
import 'package:flutter_application/features/profile/data/models/profile_model.dart';

class ProfileDatasources {
  ProfileModel? cachedProfile;
  final Dio dio;

  ProfileDatasources({required this.dio, this.cachedProfile});

  Future<ProfileModel> getProfile() async {
    try {
      final response = await dio.get('/users/profile/');
      if (response.statusCode == 200) {
        cachedProfile = ProfileModel.fromJson(response.data);
        return cachedProfile!;
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }

  /// Updates the user's profile
  Future<void> updateProfile({
    required String name,
    required String surname,
    required String email,
  }) async {
    try {
      final updateData = {
        'first_name': name,
        'last_name': surname,
        'email': email,
      };

      final response = await dio.patch(
        '/users/profile/',
        data: updateData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
        // cachedProfile = cachedProfile?.copyWith(
        //   name: name,
        //   surname: surname,
        //   email: email,
        // );
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }

  /// Changes the user's password
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await dio.post(
        '/users/change-password/',
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }

  Future<void> addPaymentMethod(Map<String, dynamic> paymentData) async {
    try {
      final response = await dio.post(
        '/users/add-payment-method/',
        data: paymentData,
      );

      if (response.statusCode != 200) {
        throw ServerException();
      } else {}
    } on DioException {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }

  Future<String> generateClientSecretKey() async {
    try {
      final response = await dio.post(
        '/payments/generate-client-secret-key-payment-intent/',
      );

      if (response.statusCode == 200) {
        return response.data['clientSecret'];
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }
}
