import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/extension/extensions.dart';

// Moved to separate file: parking_filter_model.dart
class ParkingFilterModel {
  String? state;
  String? city;
  double miles;
  Map<String, bool> allowedServices;
  Map<String, bool> oneServiceAllowed;
  Map<String, bool> additionalServices;

  ParkingFilterModel({
    this.state,
    this.city,
    this.miles = 5.0,
  })  : allowedServices = {
          'truckAllowed': false,
          'trailerAllowed': false,
          'truckTrailerAllowed': false,
          'repairsAllowed': false,
          'lowboysAllowed': false,
          'oversizedAllowed': false,
          'hazmatAllowed': false,
          'doubleStackAllowed': false,
        },
        oneServiceAllowed = {
          'bobtailOnly': false,
          'containersOnly': false,
        },
        additionalServices = {
          'cameras': false,
          'fenced': false,
          'asphalt': false,
          'lights': false,
          'twentyFourHours': false,
          'limitedEntryExitTimes': false,
          'securityAtGate': false,
          'roamingSecurity': false,
          'landingGearSupportRequired': false,
          'laundryMachines': false,
          'freeShowers': false,
          'paidShowers': false,
          'repairShop': false,
          'paidContainerStacking': false,
          'trailerSnowScraper': false,
          'truckWash': false,
          'food': false,
          'noTowedVehicles': false,
        };
}

// Moved to separate file: services_section_widget.dart
class ServicesSectionWidget extends StatelessWidget {
  final String title;
  final Map<String, bool> items;
  final Function(String, bool) onChanged;

  const ServicesSectionWidget({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
  });

  String _formatLabel(String label) {
    final words = label
        .replaceAllMapped(
          RegExp(r'([A-Z]|\d+)'),
          (match) => ' ${match.group(0)?.toLowerCase()}',
        )
        .trim();
    return words[0].toUpperCase() + words.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        3.hs(),
        Wrap(
          spacing: 10,
          children: items.entries.map((entry) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 32,
              child: CheckboxListTile(
                title: Text(
                  _formatLabel(entry.key),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: entry.value,
                onChanged: (bool? value) {
                  if (value != null) {
                    onChanged(entry.key, value);
                  }
                },
                dense: true,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                activeColor: AppConstants.mainColor,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
