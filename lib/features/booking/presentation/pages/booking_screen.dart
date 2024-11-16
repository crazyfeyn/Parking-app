import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/features/booking/presentation/widgets/booking_space_info_widget.dart';
import 'package:flutter_application/features/booking/presentation/widgets/setting_booking_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.PADDING_20),
        child: Column(
          children: [
            const BookingSpaceInfoWidget(),
            20.hs(),
            const SettingBookingWidget(),
          ],
        ),
      ),
    );
  }
}
