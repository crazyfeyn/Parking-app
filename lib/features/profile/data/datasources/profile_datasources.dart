import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/dio_config.dart';
import 'package:flutter_application/core/error/exception.dart';
import 'package:flutter_application/features/profile/data/models/profile_model.dart';

class ProfileDatasources {
  ProfileModel? cachedProfile;
  final Dio dio;

  ProfileDatasources({required this.dio, this.cachedProfile});

  /// Fetches the user's profile from the server
  Future<ProfileModel> getProfile() async {
    try {
      final response = await dio.get('/users/profile/');
      if (response.statusCode == 200) {
        cachedProfile = ProfileModel.fromJson(response.data);
        return cachedProfile!;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }

  /// Updates the user's profile
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

      final response = await dio.patch(
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
        throw ServerException();
      }
    } on DioException catch (e) {
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
    } on DioException catch (e) {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }

  /// Adds a payment method for the user
  Future<void> addPaymentMethod(Map<String, dynamic> paymentData) async {
    try {
      final response = await dio.post(
        '/users/add-payment-method/',
        data: paymentData,
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } on DioException catch (e) {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }
}
