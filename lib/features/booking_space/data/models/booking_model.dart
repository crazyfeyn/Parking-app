// booking_model.dart
class BookingModel {
  final int locationId;
  final DateTime startDate;
  final String bookingType;
  final String duration;
  final String vehicleType;
  final String paymentMethod;

  BookingModel({
    required this.locationId,
    required this.startDate,
    required this.bookingType,
    required this.duration,
    required this.vehicleType,
    required this.paymentMethod,
  });

  // Convert BookingModel to a map for API call or database insertion
  Map<String, dynamic> toMap() {
    return {
      'location_id': locationId,
      'start_date': startDate.toIso8601String(),
      'booking_type': bookingType,
      'duration': duration,
      'vehicle_type': vehicleType,
      'payment_method': paymentMethod,
    };
  }
}
