// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/profile/data/models/profile_model.dart';
import 'package:flutter_application/features/profile/domain/entity/profile_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalConfig {
  SharedPreferences sharedPreferences;
  LocalConfig({
    required this.sharedPreferences,
  });

  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(AppConstants.userToken, token);
  }

  Future<String?> getToken() async {
    final token = sharedPreferences.getString(
      AppConstants.userToken,
    );
    return token;
  }

  Future<bool> authenticated() async {
    final token = sharedPreferences.getString(AppConstants.userToken);
    return token != null && token.isNotEmpty;
  }

  Future<void> saveRefreshToken(String token) async {
    await sharedPreferences.setString(AppConstants.userRefresh, token);
  }

  Future<void> saveUserIdToken(int token) async {
    await sharedPreferences.setInt(AppConstants.sharedUserId, token);
  }

  Future<int> getUserIdToken() async {
    return sharedPreferences.getInt(
          AppConstants.sharedUserId,
        ) ??
        0;
  }

  Future<String> getRefreshToken() async {
    final token = sharedPreferences.getString(
      AppConstants.userRefresh,
    );
    return token ?? "";
  }

  Future<void> deleteTokens() async {
    sharedPreferences.remove(AppConstants.userToken);
    sharedPreferences.remove(AppConstants.userRefresh);
  }

  Future<ProfileModel?> getProfile() async {
    log('Retrieving profile from local storage');
    try {
      String? response =
          sharedPreferences.getString(AppConstants.sharedProfile);

      if (response == null || response.isEmpty) {
        return null; // No profile stored
      }

      final decoded = jsonDecode(response);
      return ProfileModel.fromJson(decoded);
    } catch (e) {
      log("Error retrieving profile: $e");
      throw CacheFailure();
    }
  }

  Future<void> updateProfileInfo({
    required String name,
    required String surname,
    required String email,
  }) async {
    log("Updating profile info (name, surname, email) in local storage");
    try {
      // Retrieve existing profile
      String? response =
          sharedPreferences.getString(AppConstants.sharedProfile);

      if (response == null || response.isEmpty) {
        log("No existing profile found");
        throw CacheFailure();
      }

      // Decode existing profile
      final decoded = jsonDecode(response);
      ProfileModel profile = ProfileModel.fromJson(decoded);

      // Create updated profile with new values
      ProfileModel updatedProfile = profile.copyWith(
        first_name: name,
        last_name: surname,
        email: email,
      );

      // Save updated profile
      final encoded = jsonEncode(updatedProfile.toJson());
      await sharedPreferences.setString(AppConstants.sharedProfile, encoded);

      log("Profile successfully updated");
    } catch (e) {
      log("Error updating profile: $e");
      throw CacheFailure();
    }
  }

  Future<void> addProfile(ProfileModel profile) async {
    log("Adding profile to local storage");
    try {
      final encoded = jsonEncode(profile.toJson());
      await sharedPreferences.setString(AppConstants.sharedProfile, encoded);
    } catch (e) {
      log("Error adding profile: $e");
      throw CacheFailure();
    }
  }
}
