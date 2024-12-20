import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/features/history/presentation/widgets/parking_item_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(
                AppDimens.BORDER_RADIUS_30,
              ),
              color: AppConstants.whiteColor,
            ),
            child: Container(
              padding: const EdgeInsets.all(AppDimens.PADDING_4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'History parking'),
                  Tab(text: 'Current parking'),
                ],
                indicator: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                unselectedLabelColor: Colors.black,
                labelColor: Colors.white,
                dividerColor: Colors.transparent,
                indicatorPadding: const EdgeInsets.all(0),
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(0),
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: 2,
            itemBuilder: (context, index) {
              return const ParkingItem(
                title: 'Logan, UT Truck & Trailer Parking on W 200 N',
                bookingType: 'Per day',
                startDate: '12.12.2024',
                endDate: '14.12.2024',
                timeZone: '1:20',
                vehicleType: 'Truck',
                price: '\$20.00',
                priceStatus: 'Paid',
                parkingStatus: 'Closed',
                priceStatusColor: Colors.green,
                parkingStatusColor: Colors.red,
              );
            },
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: 2,
            itemBuilder: (context, index) {
              return const ParkingItem(
                title: 'Main Street Parking Lot',
                bookingType: 'Hourly',
                startDate: '20.12.2024',
                endDate: '20.12.2024',
                timeZone: '14:30',
                vehicleType: 'Car',
                price: '\$5.00',
                priceStatus: 'Pending',
                parkingStatus: 'In progress',
                priceStatusColor: Colors.orange,
                parkingStatusColor: Colors.blue,
              );
            },
          ),
        ],
      ),
    );
  }
}
