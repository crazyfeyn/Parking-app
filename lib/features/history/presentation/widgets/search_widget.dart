import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';

class SearchHistoryWidget extends StatelessWidget {
  SearchHistoryWidget({super.key});
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppDimens.MARGIN_16),
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.PADDING_10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, size: 20),
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimens.BORDER_RADIUS_10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
