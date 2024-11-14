import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/features/history/presentation/widgets/search_widget.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _SearchHistoryDelegate(),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimens.PADDING_20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    children: [
                      const ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.restore),
                        title: Text("Parking slots"),
                        trailing: Icon(Icons.close),
                      ),
                      if (index != 2) const Divider(),
                    ],
                  );
                },
                childCount: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchHistoryDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 100.0; // height of the search widget
  @override
  double get minExtent => 60.0; // min height when collapsed
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false; // No need to rebuild on scrolling
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SearchHistoryWidget();
  }
}
