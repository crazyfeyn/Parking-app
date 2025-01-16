class ListPaymentMethods {
  final int id;
  final String stripePaymentMethodId;
  final bool isDefault;
  final String card;

  ListPaymentMethods({
    required this.id,
    required this.stripePaymentMethodId,
    required this.isDefault,
    required this.card,
  });

  // Factory method to create an instance from JSON
  factory ListPaymentMethods.fromJson(Map<String, dynamic> json) {
    return ListPaymentMethods(
      id: json['id'],
      stripePaymentMethodId: json['stripe_payment_method_id'],
      isDefault: json['is_default'],
      card: json['card'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stripe_payment_method_id': stripePaymentMethodId,
      'is_default': isDefault,
      'card': card,
    };
  }
}
