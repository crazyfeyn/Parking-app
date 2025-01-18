class ListPaymentMethods {
  final int id;
  final String stripePaymentMethodId;
  final bool isDefault;
  final CardInfo card;

  ListPaymentMethods({
    required this.id,
    required this.stripePaymentMethodId,
    required this.isDefault,
    required this.card,
  });

  factory ListPaymentMethods.fromJson(Map<String, dynamic> json) {
    return ListPaymentMethods(
      id: json['id'],
      stripePaymentMethodId: json['stripe_payment_method_id'],
      isDefault: json['is_default'],
      card: CardInfo.fromJson(json['card']), // Parse the nested card object
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stripe_payment_method_id': stripePaymentMethodId,
      'is_default': isDefault,
      'card': card.toJson(),
    };
  }
}

class CardInfo {
  final int expMonth;
  final int expYear;
  final String last4;

  CardInfo({
    required this.expMonth,
    required this.expYear,
    required this.last4,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) {
    return CardInfo(
      expMonth: json['exp_month'],
      expYear: json['exp_year'],
      last4: json['last4'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exp_month': expMonth,
      'exp_year': expYear,
      'last4': last4,
    };
  }
}
