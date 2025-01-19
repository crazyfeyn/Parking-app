import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/server_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/config/stripe_service.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PaymentMethodPicker extends StatefulWidget {
  final Function(String) onStateChanged;
  final String? initialValue;

  const PaymentMethodPicker({
    super.key,
    required this.onStateChanged,
    this.initialValue,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PaymentMethodPickerState createState() => _PaymentMethodPickerState();
}

class _PaymentMethodPickerState extends State<PaymentMethodPicker> {
  String? selectedPaymentMethods;

  List<String> paymentMethods = [
    'Cash',
    'By card',
  ];

  final StripeService _stripeService = sl<StripeService>();

  @override
  void initState() {
    super.initState();
    selectedPaymentMethods = widget.initialValue;
  }

  Future<void> _handleCardPayment(BuildContext context) async {
    try {
      await _stripeService.addCard();

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Payment method added successfully!')),
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add payment method: $e')),
      );
    }
  }

  void _showStatesPicker(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: paymentMethods.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                paymentMethods[index],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () async {
                setState(() {
                  selectedPaymentMethods = paymentMethods[index];
                });

                // Handle "By card" selection
                if (paymentMethods[index] == 'By card') {
                  await _handleCardPayment(context);
                }

                widget.onStateChanged(paymentMethods[index]);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
          );
        } else if (state.status == Status.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Payment method fetched successfully!')),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment methods',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ZoomTapAnimation(
            onTap: () => _showStatesPicker(context),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedPaymentMethods ?? 'Select payment methods',
                    style: TextStyle(
                      color: selectedPaymentMethods != null
                          ? Colors.black
                          : Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.black54),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
