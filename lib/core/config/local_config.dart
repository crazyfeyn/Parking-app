// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalConfig {
  SharedPreferences sharedPreferences;
  LocalConfig({
    required this.sharedPreferences,
  });

  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(AppConstants.userToken, token);
  }

  Future<String> getToken() async {
    print('hello from localconfig');

    final token = sharedPreferences.getString(
      AppConstants.userToken,
    );
    return token ?? "";
  }

  Future<void> saveRefreshToken(String token) async {
    await sharedPreferences.setString(AppConstants.userRefresh, token);
  }

  Future<String> getRefreshToken() async {
    final token = sharedPreferences.getString(
      AppConstants.userRefresh,
    );
    return token ?? "";
  }
}
