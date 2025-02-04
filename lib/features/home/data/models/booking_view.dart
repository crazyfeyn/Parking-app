class BookingView {
  final int id;
  final BookingStatus status;
  final Client client;
  final Spot spot;
  final Vehicle vehicle;
  final PaymentDetails paymentDetails;
  final PayoutDetails? payoutDetails;
  final int duration;
  final bool weekly;
  final bool daily;
  final bool monthly;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final String reservationNumber;
  final DateTime lastUpdated;
  final int? extendedFor;

  BookingView({
    required this.id,
    required this.status,
    required this.client,
    required this.spot,
    required this.vehicle,
    required this.paymentDetails,
    this.payoutDetails,
    required this.duration,
    required this.weekly,
    required this.daily,
    required this.monthly,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.reservationNumber,
    required this.lastUpdated,
    this.extendedFor,
  });

  factory BookingView.fromJson(Map<String, dynamic> json) {
    try {
      return BookingView(
        id: json['id'] ?? (throw const FormatException('ID is null')),
        status: BookingStatus.fromJson(
            json['status'] ?? (throw const FormatException('Status is null'))),
        client: Client.fromJson(
            json['client'] ?? (throw const FormatException('Client is null'))),
        spot: Spot.fromJson(
            json['spot'] ?? (throw const FormatException('Spot is null'))),
        vehicle: Vehicle.fromJson(json['vehicle'] ??
            (throw const FormatException('Vehicle is null'))),
        paymentDetails: PaymentDetails.fromJson(json['payment_details'] ??
            (throw const FormatException('Payment details is null'))),
        payoutDetails: json['payout_details'] != null
            ? PayoutDetails.fromJson(json['payout_details'])
            : null,
        duration: json['duration'] ??
            (throw const FormatException('Duration is null')),
        weekly: json['weekly'] ?? false,
        daily: json['daily'] ?? false,
        monthly: json['monthly'] ?? false,
        startDate: DateTime.parse(json['start_date'] ??
            (throw const FormatException('Start date is null'))),
        endDate: DateTime.parse(json['end_date'] ??
            (throw const FormatException('End date is null'))),
        createdAt: DateTime.parse(json['created_at'] ??
            (throw const FormatException('Created at is null'))),
        reservationNumber: json['reservation_number'] ??
            (throw const FormatException('Reservation number is null')),
        lastUpdated: DateTime.parse(json['last_updated'] ??
            (throw const FormatException('Last updated is null'))),
        extendedFor: json['extended_for'],
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.toJson(),
      'client': client.toJson(),
      'spot': spot.toJson(),
      'vehicle': vehicle.toJson(),
      'payment_details': paymentDetails.toJson(),
      'payout_details': payoutDetails?.toJson(),
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
    try {
      return BookingStatus(
        id: json['id'] ?? (throw const FormatException('Status ID is null')),
        name: json['name'] ??
            (throw const FormatException('Status name is null')),
      );
    } catch (e) {
      rethrow;
    }
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
    try {
      return Client(
        id: json['id'] ?? (throw const FormatException('Client ID is null')),
        firstName: json['first_name'] ??
            (throw const FormatException('First name is null')),
        lastName: json['last_name'] ??
            (throw const FormatException('Last name is null')),
        email: json['email'] ?? (throw const FormatException('Email is null')),
      );
    } catch (e) {
      rethrow;
    }
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
    try {
      return Spot(
        id: json['id'] ?? (throw const FormatException('Spot ID is null')),
        location: json['location'] ??
            (throw const FormatException('Location is null')),
        locationName: json['location_name'] ??
            (throw const FormatException('Location name is null')),
        locationAddress: json['location_address'] ??
            (throw const FormatException('Location address is null')),
        locationCity: json['location_city'] ??
            (throw const FormatException('Location city is null')),
        locationState: json['location_state'] ??
            (throw const FormatException('Location state is null')),
        spotNumber: json['spot_number'] ??
            (throw const FormatException('Spot number is null')),
        locationDailyRate:
            (json['location_daily_rate'] as num?)?.toDouble() ?? 0.0,
        locationWeeklyRate:
            (json['location_weekly_rate'] as num?)?.toDouble() ?? 0.0,
        locationMonthlyRate:
            (json['location_monthly_rate'] as num?)?.toDouble() ?? 0.0,
      );
    } catch (e) {
      rethrow;
    }
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
    try {
      return Vehicle(
        id: json['id'] ?? (throw const FormatException('Vehicle ID is null')),
        unitNumber: json['unit_number'] ??
            (throw const FormatException('Unit number is null')),
        make: json['make'] ?? (throw const FormatException('Make is null')),
        model: json['model'] ?? (throw const FormatException('Model is null')),
        plateNumber: json['plate_number'] ??
            (throw const FormatException('Plate number is null')),
      );
    } catch (e) {
      rethrow;
    }
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
    try {
      return PaymentDetails(
        totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
        payoutAmount: (json['payout_amount'] as num?)?.toDouble() ?? 0.0,
        profit: (json['profit'] as num?)?.toDouble() ?? 0.0,
      );
    } catch (e) {
      rethrow;
    }
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
    try {
      return PayoutDetails(
        amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
        destinationAccount: json['destination_account'] ??
            (throw const FormatException('Destination account is null')),
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'destination_account': destinationAccount,
    };
  }
}
