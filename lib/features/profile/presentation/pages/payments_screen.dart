import 'package:flutter/material.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget.dart';
import 'package:flutter_application/features/profile/presentation/widgets/payment_widget.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomProfileAppBarWidget(title: 'Payment methods'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: const Column(
                children: [
                  PaymentWidget(title: 'Add payment method', iconPath: 'add'),
                  PaymentWidget(title: 'Cash', iconPath: 'cash'),
                  PaymentWidget(title: 'Visa ----1290', iconPath: 'card'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
