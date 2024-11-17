import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';

class BookingSpaceInfoWidget extends StatefulWidget {
  const BookingSpaceInfoWidget({super.key});

  @override
  State<BookingSpaceInfoWidget> createState() => _BookingSpaceInfoWidgetState();
}

class _BookingSpaceInfoWidgetState extends State<BookingSpaceInfoWidget> {
   final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() async {
    await Future.delayed(const Duration(seconds: 1));
    while (true) {
      if (!_scrollController.hasClients) break;
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 5),
        curve: Curves.easeInOut,
      );
      await Future.delayed(const Duration(seconds: 2));
      if (!_scrollController.hasClients) break;
      await _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(seconds: 5),
        curve: Curves.easeInOut,
      );
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(AppDimens.PADDING_10),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppDimens.BORDER_RADIUS_15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: const Text(
                          'Laboris fugiat excepteur laboris ea tempor mot officia.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    20.ws(),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: '200',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            TextSpan(
                              text: '/hr',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ;
  }
}