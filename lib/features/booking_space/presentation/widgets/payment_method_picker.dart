import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/history/presentation/widgets/error_refresh_widget.dart';
import 'package:flutter_application/features/home/presentation/pages/main_screen.dart';
import 'package:flutter_application/server_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/config/stripe_service.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

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
      print('Failed to fetch payment methods: $e');
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
                title: Text('Card ending with ${method['card']['last4']}'),
                leading: const Icon(Icons.credit_card),
                onTap: () {
                  setState(() {
                    selectedPaymentMethods =
                        'Card ending with ${method['card']['last4']}';
                  });
                  widget.onStateChanged(
                      method['stripe_payment_method_id'], method['id']);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status == Status.error) {
          showDialog(
              context: context,
              builder: (context) {
                return ErrorRefreshWidget(
                  onRefresh: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (route) => false,
                  ),
                );
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
                  child: Row(
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
                      const Icon(Icons.arrow_drop_down, color: Colors.black54),
                    ],
                  ),
                ),
              ),
            )
          else if (existingPaymentMethods.isEmpty)
            const Text(
              'No payment methods available',
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
    );
  }
}
