import 'package:flutter/cupertino.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';

class PeriodWidget extends StatelessWidget {
  final String hour;
  const PeriodWidget({super.key, required this.hour});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(AppDimens.PADDING_10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_10),
        color: const Color(0xFFFFF3F3),
      ),
      child: Center(
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.clock,
              size: 18,
              color: Color(0xFFF43939),
            ),
            2.ws(),
            Text(
              "$hour hours",
              style: const TextStyle(
                color: Color(0xFFF43939),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
