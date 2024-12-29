class ListPaymentMethods {
  final int id;
  final String stripePaymentMethodId;
  final bool isDefault;
  final String card;

  const ListPaymentMethods({
    required this.id,
    required this.stripePaymentMethodId,
    required this.isDefault,
    required this.card,
  });

  factory ListPaymentMethods.fromJson(Map<String, dynamic> json) {
    return ListPaymentMethods(
      id: json['id'] as int,
      stripePaymentMethodId: json['stripe_payment_method_id'] as String,
      isDefault: json['is_default'] as bool,
      card: json['card'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stripe_payment_method_id': stripePaymentMethodId,
      'is_default': isDefault,
      'card': card,
    };
  }
}
