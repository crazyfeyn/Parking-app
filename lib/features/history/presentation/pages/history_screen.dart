import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/history/presentation/pages/detail_screen.dart';
import 'package:flutter_application/features/history/presentation/widgets/period_widget.dart';
import 'package:flutter_application/features/history/presentation/widgets/search_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

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
                      ZoomTapAnimation(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DetailScreen())),
                        child: Container(
                          padding: const EdgeInsets.all(AppDimens.PADDING_14),
                          margin: const EdgeInsets.only(
                              bottom: AppDimens.MARGIN_16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(
                                AppDimens.BORDER_RADIUS_15),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(
                                  AppDimens.BORDER_RADIUS_15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/images/logo_1.png',
                                  height: 100,
                                  width: 105,
                                  color: Colors.black,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Graha Mall',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    5.hs(),
                                    const Text(
                                      'Brakha street',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      '12 Aug',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    5.hs(),
                                    //date time type beradigan qilib to'g'irlab qo'y
                                    const PeriodWidget(hour: '4'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                childCount: 10,
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
