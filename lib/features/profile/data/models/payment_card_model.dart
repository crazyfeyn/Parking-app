class PaymentCardModel {
  final String cardNumber;
  final String cardholderName;
  final DateTime expirationDate;
  final String cvv;
  final String cardType; // For example: Visa, MasterCard, etc.

  PaymentCardModel({
    required this.cardNumber,
    required this.cardholderName,
    required this.expirationDate,
    required this.cvv,
    required this.cardType,
  });

  // Factory constructor to create a PaymentCardModel instance from JSON
  factory PaymentCardModel.fromJson(Map<String, dynamic> json) {
    return PaymentCardModel(
      cardNumber: json['cardNumber'] as String,
      cardholderName: json['cardholderName'] as String,
      expirationDate: DateTime.parse(json['expirationDate'] as String),
      cvv: json['cvv'] as String,
      cardType: json['cardType'] as String,
    );
  }

  // Method to convert a PaymentCardModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'cardholderName': cardholderName,
      'expirationDate': expirationDate.toIso8601String(),
      'cvv': cvv,
      'cardType': cardType,
    };
  }

  // Equality operator and hashCode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentCardModel &&
        other.cardNumber == cardNumber &&
        other.cardholderName == cardholderName &&
        other.expirationDate == expirationDate &&
        other.cvv == cvv &&
        other.cardType == cardType;
  }

  @override
  int get hashCode {
    return cardNumber.hashCode ^
        cardholderName.hashCode ^
        expirationDate.hashCode ^
        cvv.hashCode ^
        cardType.hashCode;
  }

  // CopyWith method for creating modified copies of an instance
  PaymentCardModel copyWith({
    String? cardNumber,
    String? cardholderName,
    DateTime? expirationDate,
    String? cvv,
    String? cardType,
  }) {
    return PaymentCardModel(
      cardNumber: cardNumber ?? this.cardNumber,
      cardholderName: cardholderName ?? this.cardholderName,
      expirationDate: expirationDate ?? this.expirationDate,
      cvv: cvv ?? this.cvv,
      cardType: cardType ?? this.cardType,
    );
  }
}
