import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/features/home/presentation/widgets/search_widget.dart';

class SearchWidgetHome extends StatelessWidget {
  const SearchWidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: AppDimens.PADDING_20,
        left: AppDimens.PADDING_20,
        right: AppDimens.PADDING_20,
      ),
      child: SearchWidget(),
    );
  }
}
