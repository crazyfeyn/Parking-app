import 'package:flutter/material.dart';

class CityPicker extends StatefulWidget {
  final Function(String?) onStateChanged;
  final String? initialValue;

  const CityPicker({
    super.key,
    required this.onStateChanged,
    this.initialValue,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CityPickerState createState() => _CityPickerState();
}

class _CityPickerState extends State<CityPicker> {
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
    'Omaha, Nebraska',
    'Minneapolis, Minnesota',
    'Tampa, Florida',
    'Honolulu, Hawaii',
    'New Orleans, Louisiana',
    'St. Louis, Missouri'
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
          'City',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
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
