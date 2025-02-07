import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/features/booking_space/presentation/provider/booking_provider.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/duration_picker_widget.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/payment_method_picker.dart';
import 'package:flutter_application/features/history/presentation/pages/history_screen.dart';
import 'package:flutter_application/features/history/presentation/widgets/success_refresh_widget.dart';
import 'package:flutter_application/features/history/presentation/widgets/vehicle_extend_widget.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart'; // Import the BookingView model

class HistoryItem extends StatelessWidget {
  final Function refresh;
  final BookingView booking;

  const HistoryItem({
    super.key,
    required this.booking,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    BookingProvider provider = BookingProvider(
      locationModel: _convertSpotToLocationModel(booking.spot),
    );

    // Determine the booking type dynamically
    String bookingType;
    if (booking.daily) {
      bookingType = 'Daily';
    } else if (booking.weekly) {
      bookingType = 'Weekly';
    } else if (booking.monthly) {
      bookingType = 'Monthly';
    } else {
      bookingType = 'Unknown';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Parking name',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            booking.spot.locationName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 20, color: Colors.grey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Booking type'),
              Text(
                bookingType,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Start day'),
              Text(_formatDate(booking.startDate)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('End day'),
              Text(_formatDate(booking.endDate)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Time zone'),
              Text(_formatTimeZone(booking.startDate)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Vehicle type'),
              Text(booking.vehicle.model), // Access properties from BookingView
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Price'),
              Text(
                '\$${booking.paymentDetails.totalAmount}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          12.hs(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Price status'),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          _getStatusColor(booking.status.name).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      booking.status.name,
                      style: TextStyle(
                        color: _getStatusColor(booking.status.name),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              14.hs(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ZoomTapAnimation(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Extend Booking'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Spot',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(booking.spot.locationName),
                                5.hs(),
                                DurationPickerWidget(
                                  onDurationChanged: (duration) =>
                                      provider.setDurationExtend(duration),
                                  provider: provider,
                                  bookingType: bookingType,
                                ),
                                5.hs(),
                                PaymentMethodPicker(
                                    onStateChanged:
                                        provider.setPaymentMethodExtend),
                                5.hs(),
                                ButtonWidget(
                                    text: 'Extend',
                                    onTap: () async {
                                      final response = await provider
                                          .extendBooking(booking.id);
                                      if (response == Status.success) {
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SuccessNotifierWidget(
                                              onRefresh: () =>
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HistoryScreen(),
                                                ),
                                                (Route<dynamic> route) => false,
                                              ),
                                              text:
                                                  'Booking successfully extended',
                                              contentText:
                                                  'Back to main screen',
                                            );
                                          },
                                        );
                                      } else {
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Something went wrong'),
                                          ),
                                        );
                                      }
                                    }),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      child: const Text(
                        'Extend booking',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ZoomTapAnimation(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Update Vehicle'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                VehicleExtendWidget(
                                  onStateChanged: (String model, int? id) {
                                    provider.setVehicleExtend(model, id);
                                  },
                                  locationModel:
                                      _convertSpotToLocationModel(booking.spot),
                                  initialValue: booking.vehicle.model,
                                ),
                                5.hs(),
                                ButtonWidget(
                                    text: 'Update',
                                    onTap: () async {
                                      final response =
                                          await provider.bookingUpdateVehicle(
                                        vehicleId:
                                            provider.selectedVehicleIdExtend!,
                                        bookingId: booking.id,
                                      );
                                      if (response == Status.success) {
                                        Navigator.of(context).pop();
                                        await refresh();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Vehicle has been updated successfully')),
                                        );
                                      } else {
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Something went wrong'),
                                          ),
                                        );
                                      }
                                    }),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: const Text(
                        'Update vehicle',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }

  String _formatTimeZone(DateTime date) {
    return '${date.hour}:${date.minute}';
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      case 'closed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

LocationModel _convertSpotToLocationModel(Spot spot) {
  return LocationModel(
    id: spot.id,
    name: spot.locationName,
    description: '', // Add a default value or fetch from the API
    address: spot.locationAddress,
    city: spot.locationCity,
    state: spot.locationState,
    zipCode: '', // Add a default value or fetch from the API
    phNumber: '', // Add a default value or fetch from the API
    schedule: '', // Add a default value or fetch from the API
    weeklyRate: spot.locationWeeklyRate,
    dailyRate: spot.locationDailyRate,
    monthlyRate: spot.locationMonthlyRate,
    twentyFourHours: false, // Add a default value or fetch from the API
    limitedEntryExitTimes: false, // Add a default value or fetch from the API
    lowboysAllowed: false, // Add a default value or fetch from the API
    bobtailOnly: false, // Add a default value or fetch from the API
    containersOnly: false, // Add a default value or fetch from the API
    oversizedAllowed: false, // Add a default value or fetch from the API
    hazmatAllowed: false, // Add a default value or fetch from the API
    doubleStackAllowed: false, // Add a default value or fetch from the API
    securityAtGate: false, // Add a default value or fetch from the API
    roamingSecurity: false, // Add a default value or fetch from the API
    landingGearSupportRequired:
        false, // Add a default value or fetch from the API
    laundryMachines: false, // Add a default value or fetch from the API
    freeShowers: false, // Add a default value or fetch from the API
    paidShowers: false, // Add a default value or fetch from the API
    repairShop: false, // Add a default value or fetch from the API
    paidContainerStackingServices:
        false, // Add a default value or fetch from the API
    trailerSnowScraper: false, // Add a default value or fetch from the API
    truckWash: false, // Add a default value or fetch from the API
    food: false, // Add a default value or fetch from the API
    noTowedVehicles: false, // Add a default value or fetch from the API
    email: '', // Add a default value or fetch from the API
    truckAllowed: false, // Add a default value or fetch from the API
    trailerAllowed: false, // Add a default value or fetch from the API
    truckTrailerAllowed: false, // Add a default value or fetch from the API
    cameras: false, // Add a default value or fetch from the API
    fenced: false, // Add a default value or fetch from the API
    asphalt: false, // Add a default value or fetch from the API
    lights: false, // Add a default value or fetch from the API
    repairsAllowed: false, // Add a default value or fetch from the API
    images: null, // Add a default value or fetch from the API
    longitude: null, // Add a default value or fetch from the API
    latitude: null, // Add a default value or fetch from the API
    bankAccountAdded: null, // Add a default value or fetch from the API
    availableSpots: null, // Add a default value or fetch from the API
    status: null, // Add a default value or fetch from the API
  );
}
