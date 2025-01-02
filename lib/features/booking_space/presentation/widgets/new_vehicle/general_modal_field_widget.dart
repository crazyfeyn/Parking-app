import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GeneralModalFieldWidget extends StatefulWidget {
  final Function onStateChanged;
  final String? initialValue;
  final List dataList;
  final String labelText;
  final String aboveText;

  const GeneralModalFieldWidget({
    super.key,
    required this.onStateChanged,
    this.initialValue,
    required this.dataList,
    required this.labelText,
    required this.aboveText,
  });

  @override
  _GeneralModalFieldWidgetState createState() =>
      _GeneralModalFieldWidgetState();
}

class _GeneralModalFieldWidgetState extends State<GeneralModalFieldWidget> {
  String? selectedBookingType;

  void clearSelection() {
    setState(() {
      selectedBookingType = null;
      widget.onStateChanged(null);
    });
  }

  @override
  void initState() {
    super.initState();
    selectedBookingType = widget.initialValue;
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
          itemCount: widget.dataList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                widget.dataList[index],
                style: const TextStyle(fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  selectedBookingType = widget.dataList[index];
                });
                widget.onStateChanged(widget.dataList[index]);
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
        Text(
          widget.labelText,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        ZoomTapAnimation(
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
                  selectedBookingType ?? widget.aboveText,
                  style: TextStyle(
                    color: selectedBookingType != null
                        ? Colors.black
                        : Colors.black54,
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
