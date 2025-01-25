import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/server_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/config/stripe_service.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart'; // Import the package

class PaymentMethodPicker extends StatefulWidget {
  final Function(String, int) onStateChanged;
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
  List<Map<String, dynamic>> existingPaymentMethods = [];
  bool isLoading = true;

  final StripeService _stripeService = sl<StripeService>();

  @override
  void initState() {
    super.initState();
    selectedPaymentMethods = widget.initialValue;
    _fetchExistingPaymentMethods();
  }

  Future<void> _fetchExistingPaymentMethods() async {
    try {
      existingPaymentMethods = await _stripeService.fetchPaymentMethods();
    } catch (e) {
      rethrow;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showPaymentMethodsPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            ...existingPaymentMethods.map((method) {
              return ListTile(
                title: Text(
                  _maskCardNumber(method['card']['last4']),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                leading: const Icon(Icons.credit_card),
                onTap: () {
                  setState(() {
                    selectedPaymentMethods =
                        _maskCardNumber(method['card']['last4']);
                  });
                  widget.onStateChanged(
                      method['stripe_payment_method_id'], method['id']);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        );
      },
    );
  }

  // Handle the refresh action
  Future<void> _handleRefresh() async {
    setState(() {
      isLoading = true; // Show loading state
    });
    await _fetchExistingPaymentMethods(); // Fetch payment methods again
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status == Status.error) {
          // Show a MaterialBanner at the top of the screen
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text(state.errorMessage ?? 'An error occurred'),
              actions: [
                TextButton(
                  onPressed: () {
                    // Dismiss the banner
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    // Optionally, retry the operation
                    _fetchExistingPaymentMethods();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );

          // Automatically dismiss the banner after 3 seconds
          Future.delayed(const Duration(seconds: 3), () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          });
        }
      },
      child: LiquidPullToRefresh(
        onRefresh: _handleRefresh, // Callback for refresh action
        color: Colors.blue, // Background color of the refresh indicator
        height: 100, // Height of the refresh indicator
        animSpeedFactor: 2, // Speed of the refresh animation
        showChildOpacityTransition: false, // Disable opacity transition
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
            if (isLoading)
              // Disabled button while loading
              IgnorePointer(
                ignoring: true, // Make the button untappable
                child: Opacity(
                  opacity: 0.5, // Make the button look disabled
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select payment methods',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.black54),
                      ],
                    ),
                  ),
                ),
              )
            else if (existingPaymentMethods.isEmpty)
              const Text(
                'No payment methods are available. Please add a card to proceed',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              )
            else
              ZoomTapAnimation(
                onTap: () {
                  _showPaymentMethodsPicker(context);
                },
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
      ),
    );
  }
}

String _maskCardNumber(String last4Digits) {
  const maskedDigits = '**** **** **** ';
  return maskedDigits + last4Digits;
}
