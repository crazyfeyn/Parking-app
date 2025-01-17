import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// First, update the StripeService class:

class StripeService {
  StripeService(this.dio);

  final Dio dio;

  Future<void> makePayment(
      {required int amount, required String currency}) async {
    try {
      final clientSecret = await _getClientSecretFromServer();
      if (clientSecret == null) {
        throw Exception('Failed to get client secret from server');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Park My Trucks',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      await _addPaymentMethodToServer();

      print('Payment method added successfully!');
    } catch (e) {
      print('Error during payment process: $e');
      rethrow;
    }
  }

  Future<String?> _getClientSecretFromServer() async {
    try {
      final response = await dio
          .post('/payments/generate-client-secret-key-payment-intent/');

      if (response.statusCode == 200) {
        return response.data['client_secret'];
      }
      return null;
    } catch (e) {
      print('Error getting client secret: $e');
      return null;
    }
  }

  Future<void> _addPaymentMethodToServer() async {
    try {
      final response = await dio.post('/users/add-payment-method/');

      if (response.statusCode != 200) {
        throw Exception('Failed to add payment method to server');
      }
    } catch (e) {
      print('Error adding payment method: $e');
      rethrow;
    }
  }
}
