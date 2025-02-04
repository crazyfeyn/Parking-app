import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/home/presentation/widgets/search_option_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});
  openGotNext(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimens.BORDER_RADIUS_20),
        ),
      ),
      builder: (context) {
        return const SearchOptionScreen();
      },
    );
  }

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.76,
            height: MediaQuery.of(context).size.height * 0.057,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_12),
              color: Colors.white,
            ),
            child: TextFormField(
              onFieldSubmitted: (newValue) {
                if (searchController.text.trim().isNotEmpty) {
                  context.read<HomeBloc>().add(
                      HomeEvent.fetchSearchLocations(searchController.text));
                }
              },
              decoration: InputDecoration(
                labelText: 'Where to park',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              controller: searchController,
            )),
      ],
    );
  }
}
