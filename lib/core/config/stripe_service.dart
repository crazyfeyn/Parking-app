import 'package:dio/dio.dart';
import 'package:flutter_application/core/constants/stripe_constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment() async {
    try {
      final clientSecret = await _createPaymentIntent(10, 'usd');
      if (clientSecret != null) {
        // print('Payment Intent created successfully: $clientSecret');
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'John Cena',
          ),
        );
        await _processPayment();
      } else {
        return;
      }
    } catch (e) {
      print('Error during payment: $e');
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        'amount': _calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      final response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization":
                "Bearer ${StripeConstants.stripeSecretKey}", // Fixed format
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Payment Intent Response: ${response.data}');
        return response.data['client_secret'];
      } else {
        print('Failed to create payment intent. Response: ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response data: ${e.response?.data}');
      print('Headers: ${e.response?.headers}');
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print(e.toString());
    }
  }

  String _calculateAmount(int amount) {
    final calculateAmount = amount * 100;
    return calculateAmount.toString();
  }
}
