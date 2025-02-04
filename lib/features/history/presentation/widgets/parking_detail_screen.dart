import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';

class ParkingDetailsScreen extends StatelessWidget {
  final LocationModel location;

  const ParkingDetailsScreen({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (location.images != null && location.images!.isNotEmpty)
              location.images!.length == 1
                  ? _buildSingleImage(location.images!.first)
                  : _buildImageCarousel(location.images!)
            else
              _buildFallbackImage(),
            const SizedBox(height: 16),
            Text(
              location.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              location.address,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('City', _truncateText(location.city)),
            _buildInfoRow('State', location.state),
            _buildInfoRow('Zip Code', location.zipCode),
            _buildInfoRow('Phone Number', location.phNumber),
            7.hs(),
            _buildInfoColumn('Schedule', location.schedule),
            5.hs(),
            _buildInfoRow(
                'Available Spaces', '${location.availableSpots ?? 'N/A'}'),
            const SizedBox(height: 16),
            const Text(
              'Rates',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildInfoRow('Weekly Rate', '\$${location.weeklyRate}'),
            _buildInfoRow('Daily Rate', '\$${location.dailyRate}'),
            _buildInfoRow('Monthly Rate', '\$${location.monthlyRate}'),
            16.hs(),
            const Text(
              'Features',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildFeatureChips(location),
            16.hs(),
            const Text(
              'Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildStatusChips(location.status),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleImage(LocationImage image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        image.image,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildImageCarousel(List<LocationImage> images) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
      ),
      items: images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(image.image),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildFallbackImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/images/network_error.png',
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChips(LocationModel location) {
    final features = [
      if (location.twentyFourHours) '24/7',
      if (location.limitedEntryExitTimes) 'Limited Entry/Exit',
      if (location.lowboysAllowed) 'Lowboys Allowed',
      if (location.bobtailOnly) 'Bobtail Only',
      if (location.containersOnly) 'Containers Only',
      if (location.oversizedAllowed) 'Oversized Allowed',
      if (location.hazmatAllowed) 'Hazmat Allowed',
      if (location.doubleStackAllowed) 'Double Stack Allowed',
      if (location.securityAtGate) 'Security at Gate',
      if (location.roamingSecurity) 'Roaming Security',
      if (location.landingGearSupportRequired) 'Landing Gear Support',
      if (location.laundryMachines) 'Laundry Machines',
      if (location.freeShowers) 'Free Showers',
      if (location.paidShowers) 'Paid Showers',
      if (location.repairShop) 'Repair Shop',
      if (location.paidContainerStackingServices) 'Container Stacking',
      if (location.trailerSnowScraper) 'Trailer Snow Scraper',
      if (location.truckWash) 'Truck Wash',
      if (location.food) 'Food Available',
      if (location.noTowedVehicles) 'No Towed Vehicles',
      if (location.truckAllowed) 'Trucks Allowed',
      if (location.trailerAllowed) 'Trailers Allowed',
      if (location.truckTrailerAllowed) 'Truck & Trailers Allowed',
      if (location.cameras) 'Cameras',
      if (location.fenced) 'Fenced',
      if (location.asphalt) 'Asphalt Surface',
      if (location.lights) 'Lights',
      if (location.repairsAllowed) 'Repairs Allowed',
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: features
          .map(
            (feature) => Chip(
              label: Text(feature),
              backgroundColor: Colors.blue.withOpacity(0.1),
              labelStyle: const TextStyle(color: Colors.blue),
            ),
          )
          .toList(),
    );
  }

  Widget _buildStatusChips(LocationStatus? status) {
    if (status == null) {
      return const Chip(
        label: Text('Unknown'),
        backgroundColor: Colors.grey,
        labelStyle: TextStyle(color: Colors.white),
      );
    }

    final statusColor = _getStatusColor(status.name);

    return Chip(
      label: Text(status.name),
      backgroundColor: statusColor.withOpacity(0.2),
      labelStyle: TextStyle(color: statusColor),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      case 'closed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

String _truncateText(String text, {int maxLength = 24}) {
  return text.length > maxLength
      ? '${text.substring(0, maxLength - 3)}...'
      : text;
}
