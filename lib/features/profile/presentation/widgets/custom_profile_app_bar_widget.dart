import 'package:flutter/material.dart';
import 'package:flutter_application/core/widgets/back_button_circle_widget.dart';

class CustomProfileAppBarWidget extends StatelessWidget
    implements PreferredSize {
  final String title;
  const CustomProfileAppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 80,
      leading: const BackButtonCircleWidget(),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
