import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';

class AmenitiesPicker extends StatefulWidget {
  final Function(String?) onStateChanged;
  final String? initialValue;

  const AmenitiesPicker({
    super.key,
    required this.onStateChanged,
    this.initialValue,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AmenitiesPickerState createState() => _AmenitiesPickerState();
}

class _AmenitiesPickerState extends State<AmenitiesPicker> {
  String? selectedState;

  List<String> cities = [
    'New York City, New York',
    'Los Angeles, California',
    'Chicago, Illinois',
    'Houston, Texas',
    'Phoenix, Arizona',
    'Philadelphia, Pennsylvania',
    'San Antonio, Texas',
    'San Diego, California',
    'Dallas, Texas',
    'San Jose, California',
    'Austin, Texas',
    'Jacksonville, Florida',
    'Fort Worth, Texas',
    'Columbus, Ohio',
    'Charlotte, North Carolina',
    'San Francisco, California',
    'Indianapolis, Indiana',
    'Seattle, Washington',
    'Denver, Colorado',
    'Washington, D.C.',
    'Boston, Massachusetts',
    'El Paso, Texas',
    'Nashville, Tennessee',
    'Detroit, Michigan',
    'Memphis, Tennessee',
    'Portland, Oregon',
    'Oklahoma City, Oklahoma',
    'Las Vegas, Nevada',
    'Louisville, Kentucky',
    'Baltimore, Maryland',
    'Milwaukee, Wisconsin',
    'Albuquerque, New Mexico',
    'Tucson, Arizona',
    'Fresno, California',
    'Mesa, Arizona',
    'Sacramento, California',
    'Kansas City, Missouri',
    'Long Beach, California',
    'Atlanta, Georgia',
    'Miami, Florida',
    'Raleigh, North Carolina',
    'Omaha, Nebraska',
    'Cleveland, Ohio',
    'Virginia Beach, Virginia',
    'Minneapolis, Minnesota',
    'Tampa, Florida',
    'Honolulu, Hawaii',
    'New Orleans, Louisiana',
    'St. Louis, Missouri',
    'Arlington, Texas',
    'Wichita, Kansas',
    'Bakersfield, California',
    'Aurora, Colorado',
    'Anaheim, California',
    'Santa Ana, California',
    'Corpus Christi, Texas',
    'Riverside, California',
    'Lexington, Kentucky',
    'Stockton, California',
    'Henderson, Nevada',
    'St. Paul, Minnesota',
    'Cincinnati, Ohio',
    'Anchorage, Alaska',
    'Greensboro, North Carolina',
    'Plano, Texas',
    'Newark, New Jersey',
    'Toledo, Ohio',
    'Orlando, Florida',
    'Chula Vista, California',
    'Irvine, California',
    'Fort Wayne, Indiana',
    'Jersey City, New Jersey',
    'Durham, North Carolina',
    'St. Petersburg, Florida',
    'Laredo, Texas',
    'Buffalo, New York',
    'Madison, Wisconsin',
    'Lubbock, Texas',
    'Chandler, Arizona',
    'Scottsdale, Arizona',
    'Reno, Nevada',
    'Glendale, Arizona',
    'Gilbert, Arizona',
    'Winston-Salem, North Carolina',
    'North Las Vegas, Nevada',
    'Norfolk, Virginia',
    'Chesapeake, Virginia',
    'Garland, Texas',
    'Irving, Texas',
    'Hialeah, Florida',
    'Fremont, California',
    'Boise, Idaho',
    'Richmond, Virginia',
    'Spokane, Washington',
    'Baton Rouge, Louisiana',
    'Tacoma, Washington',
    'San Bernardino, California',
    'Modesto, California',
    'Fontana, California',
    'Des Moines, Iowa',
    'Moreno Valley, California',
    'Fayetteville, North Carolina',
    'Birmingham, Alabama',
    'Rochester, New York',
  ];

  @override
  void initState() {
    super.initState();
    selectedState = widget.initialValue;
  }

  void _showStatesPicker() async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: cities.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                cities[index],
                style: const TextStyle(fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  selectedState = cities[index];
                });
                widget.onStateChanged(cities[index]);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amenities',
          style: TextStyle(
            fontSize: 16,
            color: AppConstants.blackColor,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _showStatesPicker,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedState ?? 'Pick city',
                  style: TextStyle(
                    color:
                        selectedState != null ? Colors.black : Colors.black54,
                    fontSize: 16,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.black54),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
