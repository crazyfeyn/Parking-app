import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService({required this.dio});

  final Dio dio;

  Future<List<Map<String, dynamic>>> fetchPaymentMethods() async {
    try {
      final response = await dio.get(
        '/payments/list-payment-methods/',
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to fetch payment methods: ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to fetch payment methods: $e');
    }
  }

  Future<int?> addCard() async {
    try {
      final secretKey = await _fetchSetupIntent();

      if (secretKey != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            setupIntentClientSecret: secretKey['setupIntentClientSecret'],
            merchantDisplayName: 'Parking App',
            customerId: secretKey['customerId'],
            customerEphemeralKeySecret: secretKey['customerEphemeralKeySecret'],
            allowsRemovalOfLastSavedPaymentMethod: false,
          ),
        );

        await presentPaymentSheet();

        final paymentMethodId = await _retrievePaymentMethodId(
            secretKey['setupIntentClientSecret']);
        if (paymentMethodId != null) {
          final paymentId = await _savePaymentMethodToServer(paymentMethodId);
          return paymentId;
        } else {
          throw Exception('No payment method ID returned');
        }
      } else {
        throw Exception('Failed to fetch SetupIntent client secret');
      }
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> _fetchSetupIntent() async {
    try {
      final response = await dio.post(
        '/payments/generate-client-secret-key-payment-intent/',
        data: {
          "mobile_client":
              "ee1ac1061e6c7daf410700b3047d3a49d47970d31f43e1469e9ef9a26373a9dd"
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to fetch SetupIntent client secret: ${response.data}');
      }
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> _retrievePaymentMethodId(String clientSecret) async {
    try {
      final setupIntent =
          await Stripe.instance.retrieveSetupIntent(clientSecret);
      return setupIntent.paymentMethodId;
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> _savePaymentMethodToServer(String paymentMethodId) async {
    try {
      final response = await dio.post(
        '/users/add-payment-method/',
        data: {
          'payment_method_id': paymentMethodId,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['id']; // Return the payment ID
      } else {
        throw Exception(
            'Failed to save payment method to server: ${response.data}');
      }
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  void _handleError(dynamic error) {}
}
