import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';

class ShimmerCardWidget extends StatelessWidget {
  const ShimmerCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: 66,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.only(bottom: AppDimens.MARGIN_12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_15),
            ),
            child: Row(
              children: [
                // Circle for card icon
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                // Rectangle for card number
                Expanded(
                  child: Container(
                    height: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                // Small rectangle for "Default" tag
                Container(
                  width: 60,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
