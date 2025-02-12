import 'package:flutter/material.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/features/history/presentation/bloc/history_bloc.dart';
import 'package:flutter_application/features/history/presentation/widgets/history_item_widget.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget_history.dart';
import 'package:shimmer/shimmer.dart';

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
    _tabController.addListener(_handleTabChangeListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchBookingList();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChangeListener);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChangeListener() {
    if (!_tabController.indexIsChanging) {
      _fetchBookingList();
    }
  }

  void _fetchBookingList() {
    if (!mounted) return;

    if (_tabController.index == 0) {
      context.read<HistoryBloc>().add(const HistoryEvent.getBookingList());
    } else {
      context
          .read<HistoryBloc>()
          .add(const HistoryEvent.getCurrentBookingList());
    }
  }

  Widget _buildShimmerItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 200,
                      height: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120,
                      height: 14,
                      color: Colors.white,
                    ),
                    Container(
                      width: 80,
                      height: 14,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: 100,
                  height: 14,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: 5,
      itemBuilder: (_, __) => _buildShimmerItem(),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingList(List<BookingView>? bookings, String emptyMessage) {
    if (bookings?.isEmpty ?? true) {
      return _buildEmptyState(emptyMessage);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: bookings!.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return HistoryItem(
          booking: booking,
          refresh: _fetchBookingList,
        );
      },
    );
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
                indicatorPadding: EdgeInsets.zero,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<HistoryBloc, HistoryState>(
        listenWhen: (previous, current) =>
            current.status == Status.errorNetwork ||
            (previous.status != Status.error && current.status == Status.error),
        listener: (context, state) {
          if (state.status == Status.errorNetwork) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('No Internet, check your connection.'),
                duration: const Duration(seconds: 10),
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: _fetchBookingList,
                ),
              ),
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.bookingList != current.bookingList ||
            previous.currentBookingList != current.currentBookingList,
        builder: (context, state) {
          return TabBarView(
            controller: _tabController,
            children: [
              state.status == Status.loading
                  ? _buildShimmerList()
                  : _buildBookingList(
                      state.bookingList,
                      'There is no booking history',
                    ),
              state.status == Status.loading
                  ? _buildShimmerList()
                  : _buildBookingList(
                      state.currentBookingList,
                      'There are no current bookings',
                    ),
            ],
          );
        },
      ),
    );
  }
}
