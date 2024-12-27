import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/home/presentation/widgets/per_price_widget.dart';

class SearchOptionScreen extends StatelessWidget {
  SearchOptionScreen({super.key});
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            top: AppDimens.PADDING_20,
            left: AppDimens.PADDING_20,
            right: AppDimens.PADDING_20),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.94,
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => 8.hs(),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(AppDimens.PADDING_16),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_16),
                color: Colors.grey.shade300,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Parking name',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const Row(
                    children: [
                      Text(
                        'Logan, UT Truck & Trailer Parking on W 200 N',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 16,
                        backgroundImage:
                            AssetImage('assets/images/parking.png'),
                      ),
                    ],
                  ),
                  12.hs(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Available spaces',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            8.hs(),
                            const Text(
                              '18 spaces are available now',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available spaces',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const PerPriceWidget(price: '20', per: 'day'),
                              10.ws(),
                              const PerPriceWidget(price: '120', per: 'week'),
                              10.ws(),
                              const PerPriceWidget(
                                  price: '250', per: 'monthly'),
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}
