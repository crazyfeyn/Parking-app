import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/features/booking/presentation/pages/booking_screen.dart';
import 'package:flutter_application/features/booking_space/presentation/pages/booking_space.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';

showLocationDetails(BuildContext context, LocationModel location) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              if (location.images != null && location.images!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    location.images!.first.image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 12.0),
              // Location Name
              Text(
                location.name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              // Address and City
              Text(
                "${location.address}, ${location.city}, ${location.state} ${location.zipCode}",
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8.0),
              // Description
              Text(
                location.description,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 16.0),
              // Available Spots
              if (location.availableSpots != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Available Spaces:",
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                    Text(
                      "${location.availableSpots} spots",
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16.0),
              // Rates
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Rates:",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Daily: \$${location.dailyRate.toStringAsFixed(2)}"),
                      Text(
                          "Weekly: \$${location.weeklyRate.toStringAsFixed(2)}"),
                      Text(
                          "Monthly: \$${location.monthlyRate.toStringAsFixed(2)}"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Features
              const Text(
                "Features:",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  if (location.twentyFourHours) _featureChip("24/7 Access"),
                  if (location.laundryMachines)
                    _featureChip("Laundry Machines"),
                  if (location.freeShowers) _featureChip("Free Showers"),
                  if (location.truckWash) _featureChip("Truck Wash"),
                  if (location.food) _featureChip("Food Available"),
                  if (location.securityAtGate) _featureChip("Security at Gate"),
                  if (location.roamingSecurity)
                    _featureChip("Roaming Security"),
                  if (location.asphalt) _featureChip("Asphalt Surface"),
                  if (location.cameras) _featureChip("Cameras"),
                ],
              ),
              const SizedBox(height: 16.0),
              // Contact Details
              const Text(
                "Contact:",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text("Phone: ${location.phNumber}"),
              Text("Email: ${location.email}"),
              const SizedBox(height: 16.0),
              // Book Now Button
              ButtonWidget(
                text: 'Book now',
                bgColor: AppConstants.mainColor,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BookingSpaceScreen(locationModel: location))),
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget _featureChip(String label) {
  return Chip(
    label: Text(label),
    backgroundColor: Colors.grey.shade200,
  );
}
