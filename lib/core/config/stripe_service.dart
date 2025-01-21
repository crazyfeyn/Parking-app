import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/local_config.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService({required this.dio, required this.localConfig});

  final Dio dio;
  final LocalConfig localConfig;

  Future<void> addCard() async {
    try {
      final clientSecret = await _fetchSetupIntentClientSecret();

      if (clientSecret != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            setupIntentClientSecret: clientSecret,
            merchantDisplayName: 'Parking App',
            paymentIntentClientSecret: 'da',
            customerId: 'sad',
            customerEphemeralKeySecret: 'sad',
          ),
        );

        print('Payment sheet initialized');

        await presentPaymentSheet();

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

  Future<String?> _fetchSetupIntentClientSecret() async {
    try {
      final response = await dio.post(
        '/payments/generate-client-secret-key-payment-intent/',
      );

      if (response.statusCode == 200) {
        print('---------');
        print(response);
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

  Future<void> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('Payment sheet presented successfully');
    } catch (e) {
      print('Error presenting payment sheet: $e');
      rethrow;
    }
  }

  Future<void> _handleCardAdditionSuccess(String clientSecret) async {
    print('Card added successfully!');

    final paymentMethodId = await _retrievePaymentMethodId(clientSecret);

    if (paymentMethodId != null) {
      await _savePaymentMethodToServer(paymentMethodId);
    } else {
      print('No payment method ID returned');
      throw Exception('No payment method ID returned');
    }
  }

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

  void _handleError(dynamic error) {
    print('Card addition failed: $error');
  }
}
