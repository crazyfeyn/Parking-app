import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/booking_space/presentation/provider/booking_provider.dart';
import 'package:flutter_application/features/history/presentation/widgets/error_refresh_widget.dart';
import 'package:flutter_application/features/history/presentation/widgets/success_refresh_widget.dart';
import 'package:flutter_application/features/home/presentation/pages/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/white_back_widget.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/available_spots_indicator.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/booking_type_picker.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/duration_picker_widget.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/payment_method_picker.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/start_date_picker_widget.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/vehicle_type_picker.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BookingSpaceScreen extends StatelessWidget {
  final LocationModel locationModel;

  const BookingSpaceScreen({super.key, required this.locationModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingProvider(locationModel: locationModel),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking space'),
        ),
        body: const BookingSpaceContent(),
      ),
    );
  }
}

class BookingSpaceContent extends StatefulWidget {
  const BookingSpaceContent({super.key});

  @override
  State<BookingSpaceContent> createState() => _BookingSpaceContentState();
}

class _BookingSpaceContentState extends State<BookingSpaceContent> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.PADDING_16),
        child: Column(
          children: [
            AvailableSpotsIndicator(
                availableSpots: provider.locationModel.availableSpots ?? 0),
            14.hs(),
            WhiteBackWidget(
              widget: Column(
                children: [
                  StartDatePickerWidget(
                    onDateSelected: provider.setDate,
                  ),
                  14.hs(),
                  BookingTypePicker(
                    onStateChanged: provider.setBookingType,
                  ),
                  14.hs(),
                  DurationPickerWidget(
                    onDurationChanged: provider.setDuration,
                  ),
                  14.hs(),
                  VehicleTypePicker(
                    locationModel: provider.locationModel,
                    onStateChanged: provider.setVehicle,
                    provider: provider,
                  ),
                  14.hs(),
                  PaymentMethodPicker(
                    onStateChanged: provider.setPaymentMethod,
                  ),
                  14.hs(),
                  BookingButton(
                    provider: provider,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BookingButton extends StatelessWidget {
  final BookingProvider provider;
  const BookingButton({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () async {
        if (provider.isFormValid) {
          final response = await provider.handleBooking();
          if (response == Status.success) {
            showDialog(
              context: context,
              builder: (context) {
                return SuccessNotifierWidget(
                  onRefresh: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (Route<dynamic> route) => false,
                  ),
                  text: 'Booking successfully created',
                  contentText: 'back to main screen',
                );
              },
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                    'Error occurred while booking. Please try again.'),
                duration: const Duration(seconds: 5),
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: () {
                    provider.handleBooking();
                  },
                ),
              ),
            );
          }
        } else {
          return null;
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.98,
        height: MediaQuery.of(context).size.height * 0.06,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppDimens.BORDER_RADIUS_15,
          ),
          color: provider.isFormValid
              ? AppConstants.mainColor
              : const Color(0xFFF2F2F2),
        ),
        child: Text(
          'Book now',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: provider.isFormValid ? Colors.white : Colors.grey[800],
          ),
        ),
      ),
    );
  }
}



// ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: const Text('No Internet, check your connection.'),
//                 duration: const Duration(seconds: 10),
//                 action: SnackBarAction(
//                   label: 'Retry',
//                   onPressed: () {
//                     _initializeData();
//                   },
//                 ),
//               ),
//             );