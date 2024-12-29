import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PaymentMethodPicker extends StatefulWidget {
  final Function onStateChanged;
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
    'New York City, New York',
    'Los Angeles, California',
    'Chicago, Illinois',
  ];

  @override
  void initState() {
    super.initState();
    selectedPaymentMethods = widget.initialValue;
  }

  void _showStatesPicker() async {
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
                style: const TextStyle(fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  selectedPaymentMethods = paymentMethods[index];
                });
                widget.onStateChanged(paymentMethods[index]);
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
    return Column(
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
          onTap: _showStatesPicker,
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
                    fontSize: 16,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.black54),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
