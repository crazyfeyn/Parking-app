import 'package:flutter/material.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/booking_space/presentation/pages/booking_space_screen.dart';
import 'package:flutter_application/features/history/presentation/widgets/parking_detail_screen.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';

class ParkingItem extends StatelessWidget {
  final LocationModel location;

  const ParkingItem({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Parking name:',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          Text(
            location.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.hs(),
          const Text(
            'Adress:',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          Text(
            location.address,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.hs(),
          Text(
            'Available Spaces: ${location.availableSpots ?? 'N/A'}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.hs(),
          const Text(
            'Rates:',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          Text(
            'Weekly - \$${location.weeklyRate}, Daily - \$${location.dailyRate}, Monthly - \$${location.monthlyRate}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          16.hs(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ParkingDetailsScreen(location: location),
                      ),
                    );
                  },
                  child: const Text('Details'),
                ),
              ),
              8.ws(),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BookingSpaceScreen(locationModel: location),
                      ),
                    );
                  },
                  child: const Text('Book'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
