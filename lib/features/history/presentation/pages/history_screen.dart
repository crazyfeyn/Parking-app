import 'package:flutter/material.dart';
import 'package:flutter_application/features/history/presentation/widgets/error_refresh_widget.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart';
import 'package:flutter_application/features/home/presentation/pages/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/features/history/presentation/bloc/history_bloc.dart';
import 'package:flutter_application/features/history/presentation/widgets/parking_item_widget.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget_history.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomProfileAppBarWidgetHistory(
        title: widget.pageNumber == 0 ? 'History screen' : 'Your listings',
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
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 3,
              ),
            );
          } else if (state.status == Status.error) {
            showDialog(
                context: context,
                builder: (context) {
                  return ErrorRefreshWidget(
                      onRefresh: () => Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()),
                            (route) => false,
                          ));
                });
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildBookingList(
                  state.bookingList, 'There is no booking history.'),
              _buildBookingList(
                  state.currentBookingList, 'There are no current bookings.'),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBookingList(List<BookingView> bookings, String emptyMessage) {
    if (bookings.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return ParkingItem(
          title: booking.spot.locationName,
          bookingType: booking.weekly
              ? 'Weekly'
              : booking.daily
                  ? 'Daily'
                  : 'Monthly',
          startDate: _formatDate(booking.startDate),
          endDate: _formatDate(booking.endDate),
          timeZone: _formatTimeZone(booking.startDate),
          vehicleType: booking.vehicle.model,
          price: '\$${booking.duration}',
          priceStatus: booking.status.name,
          parkingStatus: booking.status.name,
          priceStatusColor: _getStatusColor(booking.status.name),
          parkingStatusColor: _getStatusColor(booking.status.name),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }

  String _formatTimeZone(DateTime date) {
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
