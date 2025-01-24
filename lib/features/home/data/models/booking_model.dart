class BookingModel {
  final int vehicleId;
  final int duration;
  final bool weekly;
  final bool daily;
  final bool monthly;
  final String startDate;
  final int paymentMethodId;
  final int locationId;

  BookingModel({
    required this.vehicleId,
    required this.duration,
    required this.weekly,
    required this.daily,
    required this.monthly,
    required this.startDate,
    required this.paymentMethodId,
    required this.locationId,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      vehicleId: json['vehicle_id'],
      duration: json['duration'],
      weekly: json['weekly'],
      daily: json['daily'],
      monthly: json['monthly'],
      startDate: json['start_date'],
      paymentMethodId: json['payment_method_id'],
      locationId: json['location_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final dateTime = DateTime.parse(startDate);
    final formattedDate =
        '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

    return {
      'vehicle': vehicleId,
      'duration': duration,
      'weekly': weekly,
      'daily': daily,
      'monthly': monthly,
      'start_date': formattedDate,
      'payment_method_id': paymentMethodId,
      'location': locationId,
    };
  }
}
