import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/home/presentation/widgets/search_widget.dart';

class SearchWidgetHome extends StatelessWidget {
  const SearchWidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppDimens.PADDING_20),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            const SearchWidget(),
            40.hs(),
          ],
        ),
      ),
    );
  }
}
