import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/features/history/data/datasources/hIstory_datasources.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController searchController = TextEditingController();
  List<dynamic> _predictions = [];
  Timer? _debounceTimer;
  bool _showPredictions = false;

  final PlaceService placeService = PlaceService();

  void _onSearchChanged(String value) {
    if (value.isEmpty) {
      _showPredictions = false;
      _predictions = [];
    }
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 200), () {
      _getPlacePredictions(value);
    });
  }

  void _onSearchSubmitted(String value) {
    setState(() {
      _showPredictions = false;
      _predictions = [];
    });

    if (value.isNotEmpty) {
      context.read<HomeBloc>().add(HomeEvent.fetchSearchLocations(value));
    }
  }

  Future<void> _getPlacePredictions(String input) async {
    final predictions = await placeService.getPlacePredictions(input);
    setState(() {
      _predictions = predictions;
      _showPredictions = predictions.isNotEmpty;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  String _getMainText(dynamic prediction) {
    try {
      return prediction['structured_formatting']['main_text'] ??
          prediction['description']?.split(',')[0] ??
          prediction['description'] ??
          '';
    } catch (e) {
      return prediction['description'] ?? '';
    }
  }

  String _getSecondaryText(dynamic prediction) {
    try {
      return prediction['structured_formatting']['secondary_text'] ??
          prediction['description']?.split(',').skip(1).join(',').trim() ??
          '';
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.76,
              height: MediaQuery.of(context).size.height * 0.057,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_12),
                color: Colors.white,
              ),
              child: TextFormField(
                controller: searchController,
                onChanged: _onSearchChanged,
                onFieldSubmitted: _onSearchSubmitted,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                  labelText: 'Where to park',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (_showPredictions && _predictions.isNotEmpty)
          Container(
            width: MediaQuery.of(context).size.width * 0.76,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.3,
            ),
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_12),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _predictions.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final dynamic prediction = _predictions[index];
                final String mainText = _getMainText(prediction);
                final String secondaryText = _getSecondaryText(prediction);

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                  title: Text(
                    mainText,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: secondaryText.isNotEmpty
                      ? Text(
                          secondaryText,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                  onTap: () {
                    searchController.text = prediction['description'] ?? '';
                    context.read<HomeBloc>().add(HomeEvent.fetchSearchLocations(
                          prediction['description'] ?? '',
                        ));
                    setState(() {
                      _showPredictions = false;
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
