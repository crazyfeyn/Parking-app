import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';

class SearchOptionScreen extends StatelessWidget {
  SearchOptionScreen({super.key});
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.PADDING_20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.94,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
            ),
            title: const Text(
              'Search',
              style: TextStyle(
                fontFamily: AppConstants.fontFamilyTtfMedium,
              ),
            ),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                vertical: AppDimens.PADDING_20,
                horizontal: AppDimens.PADDING_10),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(AppDimens.PADDING_15),
                          child: Image.asset(
                            'assets/icons/search.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        labelText: 'Search a job type...',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppDimens.BORDER_RADIUS_10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.PADDING_20),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Recent Searches',
                style: TextStyle(
                  fontFamily: AppConstants.fontFamilyTtfBold,
                  fontSize: 16,
                ),
              ),
            ),
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
                        title: Text("Product Manager"),
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
          SliverToBoxAdapter(child: 20.hs()),
          SliverToBoxAdapter(
            child: 10.hs(),
          ),
          SliverToBoxAdapter(
            child: 20.hs(),
          ),
        ],
      ),
    );
  }
}
