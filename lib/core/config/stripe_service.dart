import 'package:dio/dio.dart';
import 'package:flutter_application/core/constants/stripe_constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService(this.dio);

  final Dio dio;

  /// Makes a payment using Stripe's payment sheet.
  Future<void> makePayment() async {
    try {
      print('00000');
      // Step 1: Fetch the client secret from your backend
      final clientSecret = await _fetchClientSecret(10, 'usd');
      print('11111');

      if (clientSecret != null) {
        print('Initializing payment sheet with clientSecret: $clientSecret');

        // Step 2: Initialize the payment sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName:
                'John Cena', // Replace with actual merchant name
          ),
        );
        print('Payment sheet initialized');

        // Step 3: Present the payment sheet and handle the result
        await _processPayment(clientSecret);
      } else {
        print('Failed to fetch client secret');
      }
    } catch (e) {
      print('Error during payment: $e');
      _handlePaymentError(e);
    }
  }

  /// Fetches the client secret from your backend.
  Future<String?> _fetchClientSecret(int amount, String currency) async {
    try {
      // Call your backend to generate the client secret
      final response = await dio.post(
        'http://test.parkmytrucks.com/api/payments/generate-client-secret-key-payment-intent/',
        data: {
          'amount': _calculateAmount(amount),
          'currency': currency,
        },
      );

      if (response.statusCode == 200) {
        return response.data['client_secret'];
      } else {
        throw Exception('Failed to fetch client secret: ${response.data}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response data: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('Error fetching client secret: $e');
      rethrow;
    }
  }

  /// Presents the payment sheet and handles the payment result.
  Future<void> _processPayment(String clientSecret) async {
    try {
      // Step 4: Present the payment sheet
      await Stripe.instance.presentPaymentSheet();
      print('Payment sheet presented successfully');

      // Step 5: Handle successful payment
      await _handlePaymentSuccess(clientSecret);
    } catch (e) {
      print('Error presenting payment sheet: $e');
      _handlePaymentError(e);
    }
  }

  /// Handles successful payment.
  Future<void> _handlePaymentSuccess(String clientSecret) async {
    print('Payment succeeded!');

    // Step 6: Retrieve the payment method ID
    final paymentMethodId = await _retrievePaymentMethodId(clientSecret);

    if (paymentMethodId != null) {
      // Step 7: Add the payment method to your server
      await _addPaymentMethodToServer(paymentMethodId);
    } else {
      print('No payment method ID returned');
    }
  }

  /// Handles payment errors.
  void _handlePaymentError(dynamic error) {
    print('Payment failed: $error');
    // Add logic to show an error message or retry the payment.
  }

  /// Retrieves the payment method ID from the payment intent.
  Future<String?> _retrievePaymentMethodId(String clientSecret) async {
    try {
      // Retrieve the payment intent to get the payment method ID
      final paymentIntent =
          await Stripe.instance.retrievePaymentIntent(clientSecret);
      return paymentIntent.paymentMethodId;
    } catch (e) {
      print('Error retrieving payment method ID: $e');
      rethrow;
    }
  }

  /// Adds the payment method to your server.
  Future<void> _addPaymentMethodToServer(String paymentMethodId) async {
    try {
      // Send the payment method ID to your backend
      final response = await dio.post(
        'http://test.parkmytrucks.com/api/users/add-payment-method/',
        data: {
          'payment_method_id': paymentMethodId,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to add payment method to server: ${response.data}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response data: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('Error adding payment method: $e');
      rethrow;
    }
  }

  /// Converts the amount to the smallest currency unit (e.g., cents for USD).
  String _calculateAmount(int amount) {
    final calculateAmount = amount * 100;
    return calculateAmount.toString();
  }
}
