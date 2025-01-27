import 'package:flutter/material.dart';

class AppConstants {
  static const String fontFamilyTtfLight = 'ttfirslight';
  static const String fontFamilyTtfBold = 'ttfirsbold';
  static const String fontFamilyTtfMedium = 'ttfirsmedium';
  static const Color mainColor = Color(0xFFE1262D);
  static const Color textForgotColor = Color(0xFF356899);
  static const Color unreadMessageColor = Color(0xFF5386E4);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color grayColor = Color(0xFFF2F2F3);
  static const Color shadeColor = Color(0xFF787878);
  static const String sharedId = 'idUser';
  static const String userToken = 'userToken';
  static const String userRefresh = 'userRefresh';
  static const String sharedToken = 'tokenUser';
  static const String sharedUserId = 'userId';
  static const String boolHome = 'isGrid';
  static const TextStyle textStyle_16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppConstants.blackColor,
  );
  static const TextStyle textStyle_14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppConstants.blackColor,
  );
  static const stripePublishableKey =
      "pk_live_51QJJwLKGxTbJF2zHAAwb5WwS0W8FrHwWQ3MOjF17dHXFHylffb3EpfoCecxi8IAXTZkH69hi1jkQyHpXpW5obb7O00WF7hunHE";
  static const baseseconUrl = "https://parkmytrucks.com/api/";
  static const GOOGLE_MAPS_API_KEY = "AIzaSyDm9itJq8n-dpqw4m88T3NuGaPTU7RFT-E";
}

enum Status { loading, error, success, initial, errorNetwork }

enum Status2 { loading, error, success, initial, errorNetwork }

enum Status3 { loading, error, success, initial, errorNetwork }
