import 'package:flutter/material.dart';

class AppConstants {
  static const String fontFamilyTtfLight = 'ttfirslight';
  static const String fontFamilyTtfBold = 'ttfirsbold';
  static const String fontFamilyTtfMedium = 'ttfirsmedium';
  static const Color mainColor = Colors.black;
  static const Color textForgotColor = Color(0xFF356899);
  static const Color unreadMessageColor =Color(0xFF5386E4);
  static const Color grayColor = Color(0xFFF2F2F3);
  static const baseUrl = 'http://18.222.167.242:4444/itjobs/';
  static const String sharedId = 'idUser';
  static const String sharedToken = 'tokenUser';
  static const String boolHome = 'isGrid';

}

enum Status { loading, error, success, initial }
