import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
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
      body: SingleChildScrollView(
        child: Padding(
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
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/parking_ex.png',
                    height: 200,
                    width: 320,
                  ),
                ),
                10.hs(),
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
                10.hs(),
                const Text(
                  'Auh 12, 2024',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                5.hs(),
                const Text(
                  'Graha Mall',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                5.hs(),
                const Text(
                  '123 Dkha Street',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                5.hs(),
                //width time katta yoki kichikligiga qarab o'zgaradi
                const SizedBox(
                  width: 100,
                  child: PeriodWidget(hour: '4'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Information',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    10.hs(),
                    const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
