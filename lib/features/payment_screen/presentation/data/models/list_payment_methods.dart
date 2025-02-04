class ListPaymentMethods {
  final int id;
  final String stripeListPaymentMethodsId;
  final bool isDefault;
  final CardInfo card;

  ListPaymentMethods({
    required this.id,
    required this.stripeListPaymentMethodsId,
    required this.isDefault,
    required this.card,
  });

  factory ListPaymentMethods.fromJson(Map<String, dynamic> json) {
    return ListPaymentMethods(
      id: json['id'] as int,
      stripeListPaymentMethodsId: json['stripe_payment_method_id'] as String,
      isDefault: json['is_default'] as bool,
      card: CardInfo.fromJson(json['card'] as Map<String, dynamic>),
    );
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
      expMonth: json['exp_month'] as int,
      expYear: json['exp_year'] as int,
      last4: json['last4'].toString(), // Convert `last4` to String
    );
  }
}
