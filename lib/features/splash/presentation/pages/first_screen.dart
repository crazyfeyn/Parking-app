import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter_application/features/splash/presentation/widgets/when_first_widget.dart';
import 'package:flutter_application/features/splash/presentation/widgets/when_second_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final List images = [
    'assets/splash/first.png',
    'assets/splash/second.png',
    'assets/splash/third.png'
  ];
  final List<String> boldTexts = [
    'Make your career',
    'Search your dream job fast and ease',
    'Make your dream career with job'
  ];
  final List<String> lightTexts = [
    'Aute eiusmod velit dolor occaecat Ad elit laboris culpa culpa commodo Lorem ut enim Adipisicing officia tempor laborum nisi tempor deserunt laborum aute labore',
    'Aute eiusmod velit dolor occaecat Ad elit laboris culpa culpa commodo Lorem ut enim Adipisicing officia tempor laborum nisi tempor deserunt laborum aute labore',
    'Aute eiusmod velit dolor occaecat Ad elit laboris culpa culpa commodo Lorem ut enim Adipisicing officia tempor laborum nisi tempor deserunt laborum aute labore',
  ];
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.PADDING_40),
        child: Column(
          children: [
            60.hs(),
            _buildPageView(),
            30.hs(),
            SmoothPageIndicator(
              controller: _controller,
              count: images.length,
              effect: const ExpandingDotsEffect(
                  activeDotColor: AppConstants.mainColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: PageView.builder(
        controller: _controller,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return _buildPageContent(index);
        },
      ),
    );
  }

  Widget _buildPageContent(int index) {
    return Column(
      children: [
        Image.asset(
          images[index],
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        Center(
          child: Column(
            children: [
              Text(
                boldTexts[index],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                lightTexts[index],
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        60.hs(),
        if (index == 0) WhenFirstWidget(controller: _controller),
        if (index == 2) const WhenSecondWidget(),
      ],
    );
  }
}
