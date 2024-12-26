import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';

class MileSliderWidget extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final Function(double) onChanged;
  final double initialValue;
  MileSliderWidget({
    Key? key,
    this.minValue = 0,
    this.maxValue = 10,
    required this.onChanged,
    this.initialValue = 7.5,
  }) : super(key: key);

  @override
  State<MileSliderWidget> createState() => _MileSliderWidgetState();
}

class _MileSliderWidgetState extends State<MileSliderWidget> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Miles',
          style: TextStyle(
            color: AppConstants.blackColor,
            fontSize: 16,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.minValue.toInt()}km',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${widget.maxValue.toInt()}km',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.red,
                  inactiveTrackColor: Colors.grey[400],
                  thumbColor: Colors.white,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 12,
                    elevation: 4,
                  ),
                  trackHeight: 4,
                ),
                child: Slider(
                  value: _currentValue,
                  min: widget.minValue,
                  max: widget.maxValue,
                  onChanged: (value) {
                    setState(() {
                      _currentValue = value;
                    });
                    widget.onChanged(value);
                  },
                ),
              ),
              Text(
                'Mile ${_currentValue.toStringAsFixed(1)} km',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
