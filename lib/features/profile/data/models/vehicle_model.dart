class VehicleModel {
  final int id; // Read-only property
  final String type;
  final String unitNumber;
  final int year;
  final String make;
  final String model;
  final String plateNumber;

  VehicleModel({
    this.id = 0, // Default value
    required this.type,
    required this.unitNumber,
    required this.year,
    required this.make,
    required this.model,
    required this.plateNumber,
  });

  // Factory constructor to create a VehicleModel instance from JSON
  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] ?? 0,
      type: json['type'] as String,
      unitNumber: json['unit_number'] as String,
      year: json['year'] as int,
      make: json['make'] as String,
      model: json['model'] as String,
      plateNumber: json['plate_number'] as String,
    );
  }

  // Method to convert a VehicleModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'unit_number': unitNumber,
      'year': year,
      'make': make,
      'model': model,
      'plate_number': plateNumber,
    };
  }

  // Equality operator and hashCode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehicleModel &&
        other.id == id &&
        other.type == type &&
        other.unitNumber == unitNumber &&
        other.year == year &&
        other.make == make &&
        other.model == model &&
        other.plateNumber == plateNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        unitNumber.hashCode ^
        year.hashCode ^
        make.hashCode ^
        model.hashCode ^
        plateNumber.hashCode;
  }

  // CopyWith method to create a modified copy of the instance
  VehicleModel copyWith({
    int? id,
    String? type,
    String? unitNumber,
    int? year,
    String? make,
    String? model,
    String? plateNumber,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      type: type ?? this.type,
      unitNumber: unitNumber ?? this.unitNumber,
      year: year ?? this.year,
      make: make ?? this.make,
      model: model ?? this.model,
      plateNumber: plateNumber ?? this.plateNumber,
    );
  }
}
