class BookingView {
  final int id;
  final BookingStatus status;
  final Client client;
  final Spot spot;
  final Vehicle vehicle;
  final PaymentDetails paymentDetails;
  final PayoutDetails payoutDetails;
  final int duration;
  final bool weekly;
  final bool daily;
  final bool monthly;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final String reservationNumber;
  final DateTime lastUpdated;
  final int extendedFor;

  BookingView({
    required this.id,
    required this.status,
    required this.client,
    required this.spot,
    required this.vehicle,
    required this.paymentDetails,
    required this.payoutDetails,
    required this.duration,
    required this.weekly,
    required this.daily,
    required this.monthly,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.reservationNumber,
    required this.lastUpdated,
    required this.extendedFor,
  });

  factory BookingView.fromJson(Map<String, dynamic> json) {
    return BookingView(
      id: json['id'],
      status: BookingStatus.fromJson(json['status']),
      client: Client.fromJson(json['client']),
      spot: Spot.fromJson(json['spot']),
      vehicle: Vehicle.fromJson(json['vehicle']),
      paymentDetails: PaymentDetails.fromJson(json['payment_details']),
      payoutDetails: PayoutDetails.fromJson(json['payout_details']),
      duration: json['duration'],
      weekly: json['weekly'],
      daily: json['daily'],
      monthly: json['monthly'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      createdAt: DateTime.parse(json['created_at']),
      reservationNumber: json['reservation_number'],
      lastUpdated: DateTime.parse(json['last_updated']),
      extendedFor: json['extended_for'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.toJson(),
      'client': client.toJson(),
      'spot': spot.toJson(),
      'vehicle': vehicle.toJson(),
      'payment_details': paymentDetails.toJson(),
      'payout_details': payoutDetails.toJson(),
      'duration': duration,
      'weekly': weekly,
      'daily': daily,
      'monthly': monthly,
      'start_date': startDate.toIso8601String().split('T').first,
      'end_date': endDate.toIso8601String().split('T').first,
      'created_at': createdAt.toIso8601String(),
      'reservation_number': reservationNumber,
      'last_updated': lastUpdated.toIso8601String(),
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

  factory BookingStatus.fromJson(Map<String, dynamic> json) {
    return BookingStatus(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Client {
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  Client({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    };
  }
}

class Spot {
  final int id;
  final int location;
  final String locationName;
  final String locationAddress;
  final String locationCity;
  final String locationState;
  final String spotNumber;
  final double locationDailyRate;
  final double locationWeeklyRate;
  final double locationMonthlyRate;

  Spot({
    required this.id,
    required this.location,
    required this.locationName,
    required this.locationAddress,
    required this.locationCity,
    required this.locationState,
    required this.spotNumber,
    required this.locationDailyRate,
    required this.locationWeeklyRate,
    required this.locationMonthlyRate,
  });

  factory Spot.fromJson(Map<String, dynamic> json) {
    return Spot(
      id: json['id'],
      location: json['location'],
      locationName: json['location_name'],
      locationAddress: json['location_address'],
      locationCity: json['location_city'],
      locationState: json['location_state'],
      spotNumber: json['spot_number'],
      locationDailyRate: json['location_daily_rate'],
      locationWeeklyRate: json['location_weekly_rate'],
      locationMonthlyRate: json['location_monthly_rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'location_name': locationName,
      'location_address': locationAddress,
      'location_city': locationCity,
      'location_state': locationState,
      'spot_number': spotNumber,
      'location_daily_rate': locationDailyRate,
      'location_weekly_rate': locationWeeklyRate,
      'location_monthly_rate': locationMonthlyRate,
    };
  }
}

class Vehicle {
  final int id;
  final String unitNumber;
  final String make;
  final String model;
  final String plateNumber;

  Vehicle({
    required this.id,
    required this.unitNumber,
    required this.make,
    required this.model,
    required this.plateNumber,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      unitNumber: json['unit_number'],
      make: json['make'],
      model: json['model'],
      plateNumber: json['plate_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unit_number': unitNumber,
      'make': make,
      'model': model,
      'plate_number': plateNumber,
    };
  }
}

class PaymentDetails {
  final double totalAmount;
  final double payoutAmount;
  final double profit;

  PaymentDetails({
    required this.totalAmount,
    required this.payoutAmount,
    required this.profit,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      totalAmount: json['total_amount'],
      payoutAmount: json['payout_amount'],
      profit: json['profit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_amount': totalAmount,
      'payout_amount': payoutAmount,
      'profit': profit,
    };
  }
}

class PayoutDetails {
  final double amount;
  final String destinationAccount;

  PayoutDetails({
    required this.amount,
    required this.destinationAccount,
  });

  factory PayoutDetails.fromJson(Map<String, dynamic> json) {
    return PayoutDetails(
      amount: json['amount'],
      destinationAccount: json['destination_account'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'destination_account': destinationAccount,
    };
  }
}
