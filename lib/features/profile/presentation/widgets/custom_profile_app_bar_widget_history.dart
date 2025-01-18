import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';

class CustomProfileAppBarWidgetHistory extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom;

  const CustomProfileAppBarWidgetHistory({
    super.key,
    required this.title,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 80,
      bottom: bottom,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: AppConstants.blackColor,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize {
    final double bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
