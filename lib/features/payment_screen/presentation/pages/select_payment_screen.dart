import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/payment_screen/presentation/widgets/card_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SelectPaymentScreen extends StatelessWidget {
  const SelectPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dispatch the fetchPaymentMethodList event when the screen is initialized
    context.read<HomeBloc>().add(const HomeEvent.fetchPaymentMethodList());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cards',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.PADDING_12),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == Status.error) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else if (state.status == Status.success &&
                state.listPaymentMethod != null) {
              final paymentMethods = state.listPaymentMethod!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ZoomTapAnimation(
                      onTap: () {
                        // Navigate to add card screen
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppDimens.PADDING_12),
                        margin:
                            const EdgeInsets.only(bottom: AppDimens.MARGIN_16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5D21E),
                          borderRadius:
                              BorderRadius.circular(AppDimens.BORDER_RADIUS_15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Add Card',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                              ),
                            ),
                            8.ws(),
                            const Icon(
                              Icons.add_circle_outline_rounded,
                              color: Colors.white,
                              size: 47,
                            ),
                          ],
                        ),
                      ),
                    ),
                    for (final method in paymentMethods)
                      CardWidget(
                        cardNumber: method
                            .card.last4, // Access the last4 property directly
                      ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No payment methods found.'));
            }
          },
        ),
      ),
    );
  }
}
