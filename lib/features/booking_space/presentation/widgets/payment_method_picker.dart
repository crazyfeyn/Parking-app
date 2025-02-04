import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/server_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/config/stripe_service.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

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
  String? errorMessage;

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
      setState(() {
        isLoading = false;
        errorMessage =
            null; // Clear the error message if data is fetched successfully
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage =
            'Network error. Please check your connection.'; // Set the error message
      });
    }
  }

  void _showPaymentMethodsPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400,
          child: ListView(
            shrinkWrap: true,
            children: [
              ...existingPaymentMethods.map((method) {
                final last4Digits = method['card']['last4'] as String?;
                return ListTile(
                  title: Text(
                    _maskCardNumber(last4Digits),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  leading: const Icon(Icons.credit_card),
                  onTap: () {
                    setState(() {
                      selectedPaymentMethods = _maskCardNumber(last4Digits);
                    });
                    widget.onStateChanged(
                      method['stripe_payment_method_id']?.toString() ?? '',
                      method['id'] as int? ?? 0, // Handle null
                    );
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
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
    return LiquidPullToRefresh(
      onRefresh: _handleRefresh,
      color: Colors.blue,
      height: 100,
      animSpeedFactor: 2,
      showChildOpacityTransition: false,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == Status.errorNetwork) {
            setState(() {
              errorMessage =
                  'No Internet connection. Please check your connection.';
            });
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
            if (isLoading)
              IgnorePointer(
                ignoring: true,
                child: Opacity(
                  opacity: 0.5,
                  child: _buildPaymentMethodSelector(enabled: false),
                ),
              )
            else if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
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
                onTap: () => _showPaymentMethodsPicker(context),
                child: _buildPaymentMethodSelector(enabled: true),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSelector({required bool enabled}) {
    return Container(
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
              color: enabled && selectedPaymentMethods != null
                  ? Colors.black
                  : Colors.black54,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.black54),
        ],
      ),
    );
  }

  // Handle null values in the card number masking
  String _maskCardNumber(String? last4Digits) {
    const maskedDigits = '**** **** **** ';
    return maskedDigits + (last4Digits ?? '****');
  }
}
