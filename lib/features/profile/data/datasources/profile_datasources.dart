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
    } on DioException catch (e) {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }

  /// Updates the user's profile
  Future<void> updateProfile({
  required  String name,
    required  String surname,
   required  String email,
  }) async {
    print('QWERTYUIOIUYTREWQWERTYUIUYTREWERTYU');
    try {
      final updateData = {
       'first_name': name,
      'last_name': surname,
     'email': email,
      };
      print('UPDATED DATA');
      print(updateData);

      final response = await dio.patch(
        '/users/profile/',
        data: updateData,
      );
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('qwertyuiuytrewhello20202020202');
        return;
        // cachedProfile = cachedProfile?.copyWith(
        //   name: name,
        //   surname: surname,
        //   email: email,
        // );
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

  Future<void> addPaymentMethod(Map<String, dynamic> paymentData) async {
    try {
      final response = await dio.post(
        '/users/add-payment-method/',
        data: paymentData,
      );

      if (response.statusCode != 200) {
        throw ServerException();
      } else {
        print('success');
      }
    } on DioException catch (e) {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }
}
