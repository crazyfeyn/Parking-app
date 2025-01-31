import 'package:flutter/material.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/features/history/presentation/bloc/history_bloc.dart';
import 'package:flutter_application/features/history/presentation/widgets/history_item_widget.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget_history.dart';

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
        title: 'Your listings',
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
                onTap: _handleTabChange,
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
      body: BlocConsumer<HistoryBloc, HistoryState>(
        listener: (context, state) {
          if (state.status == Status.errorNetwork) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('No Internet, check your connection.'),
                duration: const Duration(seconds: 10),
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: () => _refreshCurrentTab(),
                ),
              ),
            );
          } else if (state.status == Status.error) {
            _refreshCurrentTab();
          }
        },
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 3,
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildBookingList(
                  state.bookingList, 'There is no booking history'),
              _buildBookingList(
                  state.currentBookingList, 'There are no current bookings'),
            ],
          );
        },
      ),
    );
  }

  void _handleTabChange(int index) {
    if (index == 0) {
      context.read<HistoryBloc>().add(const HistoryEvent.getBookingList());
    } else {
      context
          .read<HistoryBloc>()
          .add(const HistoryEvent.getCurrentBookingList());
    }
  }

  void _refreshCurrentTab() {
    if (_tabController.index == 0) {
      context.read<HistoryBloc>().add(const HistoryEvent.getBookingList());
    } else {
      context
          .read<HistoryBloc>()
          .add(const HistoryEvent.getCurrentBookingList());
    }
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
        return HistoryItem(
          booking: booking,
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
