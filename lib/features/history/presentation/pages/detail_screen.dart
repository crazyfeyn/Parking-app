import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/features/history/presentation/widgets/period_widget.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail history',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.PADDING_20),
        child: Center(
          child: Column(
            children: [
              Container(
                height: 200,
                width: 320,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                )),
                child: Image.asset(
                  'assets/images/parking_ex.png',
                  height: 200,
                  width: 320,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppDimens.PADDING_10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF43939),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.location_pin,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              const Text(
                'Graha Mall',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const Text(
                '123 Dkha Street',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const PeriodWidget(hour: '4'),
            ],
          ),
        ),
      ),
    );
  }
}
