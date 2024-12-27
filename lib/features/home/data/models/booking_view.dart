class BookingView {
  final int id;
  final BookingStatus status;
  final String client;
  final String spot;
  final String vehicle;
  final int duration;
  final bool weekly;
  final bool daily;
  final bool monthly;
  final String startDate;
  final String? endDate;
  final String createdAt;
  final String? reservationNumber;
  final String lastUpdated;
  final int? extendedFor;

  BookingView({
    required this.id,
    required this.status,
    required this.client,
    required this.spot,
    required this.vehicle,
    required this.duration,
    required this.weekly,
    required this.daily,
    required this.monthly,
    required this.startDate,
    this.endDate,
    required this.createdAt,
    this.reservationNumber,
    required this.lastUpdated,
    this.extendedFor,
  });

  /// Converts JSON to a BookingView instance
  factory BookingView.fromJson(Map<String, dynamic> json) {
    return BookingView(
      id: json['id'],
      status: BookingStatus.fromJson(json['status']),
      client: json['client'],
      spot: json['spot'],
      vehicle: json['vehicle'],
      duration: json['duration'],
      weekly: json['weekly'],
      daily: json['daily'],
      monthly: json['monthly'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      createdAt: json['created_at'],
      reservationNumber: json['reservation_number'],
      lastUpdated: json['last_updated'],
      extendedFor: json['extended_for'],
    );
  }

  /// Converts BookingView instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.toJson(),
      'client': client,
      'spot': spot,
      'vehicle': vehicle,
      'duration': duration,
      'weekly': weekly,
      'daily': daily,
      'monthly': monthly,
      'start_date': startDate,
      'end_date': endDate,
      'created_at': createdAt,
      'reservation_number': reservationNumber,
      'last_updated': lastUpdated,
      'extended_for': extendedFor,
    };
  }
}

class BookingStatus {
  final int id;
  final String name;

  BookingStatus({
    required this.id,
    required this.name,
  });

  /// Converts JSON to a BookingStatus instance
  factory BookingStatus.fromJson(Map<String, dynamic> json) {
    return BookingStatus(
      id: json['id'],
      name: json['name'],
    );
  }

  /// Converts BookingStatus instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
