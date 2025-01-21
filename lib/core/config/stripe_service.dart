import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/local_config.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService({required this.dio, required this.localConfig});

  final Dio dio;
  final LocalConfig localConfig;

  Future<void> addCard() async {
    try {
      // Step 1: Fetch the SetupIntent client secret
      final clientSecret = await _fetchSetupIntentClientSecret();

      if (clientSecret != null) {
        print('Initializing payment sheet with clientSecret: $clientSecret');

        // Step 2: Initialize the payment sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            setupIntentClientSecret: clientSecret,
            merchantDisplayName: 'Parking App',
          ),
        );
        print('Payment sheet initialized');

        // Step 3: Present the payment sheet
        await presentPaymentSheet();

        // Step 4: Handle successful card addition
        await _handleCardAdditionSuccess(clientSecret);
      } else {
        print('Failed to fetch SetupIntent client secret');
        throw Exception('Failed to fetch SetupIntent client secret');
      }
    } catch (e) {
      print('Error during card addition: $e');
      _handleError(e);
      rethrow;
    }
  }

  /// Fetches the SetupIntent client secret from the backend.
  Future<String?> _fetchSetupIntentClientSecret() async {
    try {
      final response = await dio.post(
        '/payments/generate-client-secret-key-payment-intent/',
      );

      if (response.statusCode == 200) {
        print('-----------');
        print(response.data['client_secret']);
        return response.data['client_secret'];
      } else {
        throw Exception(
            'Failed to fetch SetupIntent client secret: ${response.data}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response data: ${e.response?.data}');
      print('Status code: ${e.response?.statusCode}');
      rethrow;
    } catch (e) {
      print('Error fetching SetupIntent client secret: $e');
      rethrow;
    }
  }

  /// Presents the payment sheet to the user.
  Future<void> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('Payment sheet presented successfully');
    } catch (e) {
      print('Error presenting payment sheet: $e');
      rethrow;
    }
  }

  /// Handles successful card addition.
  Future<void> _handleCardAdditionSuccess(String clientSecret) async {
    print('Card added successfully!');

    // Step 5: Retrieve the payment method ID
    final paymentMethodId = await _retrievePaymentMethodId(clientSecret);

    if (paymentMethodId != null) {
      // Step 6: Save the payment method to the server
      await _savePaymentMethodToServer(paymentMethodId);
    } else {
      print('No payment method ID returned');
      throw Exception('No payment method ID returned');
    }
  }

  /// Retrieves the payment method ID from the SetupIntent.
  Future<String?> _retrievePaymentMethodId(String clientSecret) async {
    try {
      final setupIntent =
          await Stripe.instance.retrieveSetupIntent(clientSecret);
      return setupIntent.paymentMethodId;
    } catch (e) {
      print('Error retrieving payment method ID: $e');
      rethrow;
    }
  }

  /// Saves the payment method ID to the server.
  Future<void> _savePaymentMethodToServer(String paymentMethodId) async {
    try {
      final response = await dio.post(
        '/users/add-payment-method/',
        data: {
          'payment_method_id': paymentMethodId,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to save payment method to server: ${response.data}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response data: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('Error saving payment method: $e');
      rethrow;
    }
  }

  /// Handles errors during the card addition process.
  void _handleError(dynamic error) {
    print('Card addition failed: $error');
    // You can add additional error handling logic here, such as showing a user-friendly message.
  }
}
