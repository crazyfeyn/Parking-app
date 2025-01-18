import 'package:flutter/material.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget_history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/features/history/presentation/bloc/history_bloc.dart';
import 'package:flutter_application/features/history/presentation/widgets/parking_item_widget.dart';

class HistoryScreen extends StatefulWidget {
  final int pageNumber;
  const HistoryScreen({super.key, required this.pageNumber});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomProfileAppBarWidgetHistory(
        title: widget.pageNumber == 1 ? 'History screen' : 'History screen',
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
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
                onTap: (index) {
                  if (index == 0) {
                    context
                        .read<HistoryBloc>()
                        .add(const HistoryEvent.getBookingList());
                  } else {
                    context
                        .read<HistoryBloc>()
                        .add(const HistoryEvent.getCurrentBookingList());
                  }
                },
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
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == Status.error) {
            return const Center(child: Text('Error loading data'));
          }

          return TabBarView(
            controller: _tabController,
            children: [
              state.bookingList.isEmpty
                  ? const Center(child: Text('There is no booking history.'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemCount: state.bookingList.length,
                      itemBuilder: (context, index) {
                        final booking = state.bookingList[index];
                        return ParkingItem(
                          title: booking.spot,
                          bookingType: booking.weekly
                              ? 'Weekly'
                              : booking.daily
                                  ? 'Daily'
                                  : 'Monthly',
                          startDate: _formatDate(booking.startDate),
                          endDate: booking.endDate != null
                              ? _formatDate(booking.endDate!)
                              : 'N/A',
                          timeZone: _formatTimeZone(booking.startDate),
                          vehicleType: booking.vehicle,
                          price: '\$${booking.duration}',
                          priceStatus: booking.status.name,
                          parkingStatus: booking.status.name,
                          priceStatusColor:
                              _getStatusColor(booking.status.name),
                          parkingStatusColor:
                              _getStatusColor(booking.status.name),
                        );
                      },
                    ),
              state.currentBookingList.isEmpty
                  ? const Center(child: Text('There are no current bookings.'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemCount: state.currentBookingList.length,
                      itemBuilder: (context, index) {
                        final booking = state.currentBookingList[index];
                        return ParkingItem(
                          title: booking.spot,
                          bookingType: booking.weekly
                              ? 'Weekly'
                              : booking.daily
                                  ? 'Daily'
                                  : 'Monthly',
                          startDate: _formatDate(booking.startDate),
                          endDate: booking.endDate != null
                              ? _formatDate(booking.endDate!)
                              : 'N/A',
                          timeZone: _formatTimeZone(booking.startDate),
                          vehicleType: booking.vehicle,
                          price: '\$${booking.duration}',
                          priceStatus: booking.status.name,
                          parkingStatus: booking.status.name,
                          priceStatusColor:
                              _getStatusColor(booking.status.name),
                          parkingStatusColor:
                              _getStatusColor(booking.status.name),
                        );
                      },
                    ),
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    context.read<HistoryBloc>().add(const HistoryEvent.getBookingList());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.day}.${date.month}.${date.year}';
  }

  String _formatTimeZone(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.hour}:${date.minute}';
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      case 'closed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
