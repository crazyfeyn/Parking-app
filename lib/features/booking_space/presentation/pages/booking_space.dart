import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/core/widgets/white_back_widget.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/available_spots_indicator.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/booking_type_picker.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/payment_method_picker.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/start_date_picker_widget.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/vehicle_type_picker.dart';

class BookingSpaceScreen extends StatelessWidget {
  const BookingSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking space'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.PADDING_16),
        child: Column(
          children: [
            const AvailableSpotsIndicator(availableSpots: 2),
            WhiteBackWidget(
                widget: Column(
              children: [
                const StartDatePickerWidget(),
                14.hs(),
                BookingTypePicker(
                  onStateChanged: (state) {},
                ),
                14.hs(),
                VehicleTypePicker(
                  onStateChanged: (state) {},
                ),
                14.hs(),
                PaymentMethodPicker(onStateChanged: (state) {}),
                14.hs(),
                const ButtonWidget(
                  text: 'Book now',
                  bgColor: AppConstants.shadeColor,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
