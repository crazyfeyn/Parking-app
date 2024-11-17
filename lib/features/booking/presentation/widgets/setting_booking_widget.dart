import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SettingBookingWidget extends StatefulWidget {
  const SettingBookingWidget({super.key});

  @override
  State<SettingBookingWidget> createState() => _SettingBookingWidgetState();
}

class _SettingBookingWidgetState extends State<SettingBookingWidget> {
  double _sliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            'Space 4C',
            style: TextStyle(
                fontSize: 20,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(AppDimens.PADDING_20),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Card(
                      elevation: 4,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(AppDimens.PADDING_10),
                        width: 175,
                        height: 45,
                        child: RichText(
                          text: TextSpan(
                            text: '${_sliderValue.toInt()} hours',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            children: const [
                              TextSpan(
                                text: '   N1200',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                20.hs(),
                const Text(
                  'Estimate Duration',
                  style: TextStyle(fontSize: 18),
                ),
                Slider(
                  value: _sliderValue,
                  min: 1,
                  max: 24,
                  divisions: 23,
                  label: '${_sliderValue.toInt()} hours',
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                ),
                Row(
                  children: [
                    const Text(
                      'Check-in Time: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    ZoomTapAnimation(
                      child: Image.asset(
                        'assets/icons/edit_icon.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    10.hs(),
                    const ZoomTapAnimation(
                      child: Text(
                        '11:00 PM',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                20.hs(),
                const Divider(),
                const Text(
                  'Specifications ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                _specificationsWidget('spec', 'Disabled Parking', true),
                _specificationsWidget(
                    'guard', 'Request Special Guard (\$10)', true),
              ],
            ),
          ),
        ),
        70.hs(),
        const ButtonWidget(text: 'Book Space'),
      ],
    );
  }

  Widget _specificationsWidget(String path, String title, bool booling) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        'assets/icons/${path}_icon.png',
        width: 24,
        height: 24,
      ),
      title: Text(title),
      trailing: Switch(
        activeTrackColor: Colors.green,
        activeColor: Colors.white,
        value: booling,
        onChanged: (value) {},
      ),
    );
  }
}
