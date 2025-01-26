import 'package:flutter/material.dart';
import 'package:flutter_application/core/config/stripe_service.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/server_locator.dart';
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
    final StripeService stripeService = sl<StripeService>();
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
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'An error occurred'),
                  duration: const Duration(seconds: 10),
                  action: SnackBarAction(
                    label: 'Retry',
                    onPressed: () {
                      context
                          .read<HomeBloc>()
                          .add(const HomeEvent.fetchPaymentMethodList());
                    },
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                  strokeWidth: 3,
                ),
              );
            } else if (state.status == Status.success &&
                state.listPaymentMethod != null) {
              final paymentMethods = state.listPaymentMethod;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ZoomTapAnimation(
                      onTap: () async {
                        await stripeService.addCard();
                        context
                            .read<HomeBloc>()
                            .add(const HomeEvent.fetchPaymentMethodList());
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppDimens.PADDING_14),
                        margin:
                            const EdgeInsets.only(bottom: AppDimens.MARGIN_16),
                        decoration: BoxDecoration(
                          color: AppConstants.mainColor,
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
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            8.ws(),
                            const Icon(
                              Icons.add_circle_outline_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                    for (final method in paymentMethods!)
                      CardWidget(
                        cardNumber: _maskCardNumber(method.card.last4),
                      ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No payment methods found.'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(const HomeEvent.fetchPaymentMethodList());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  String _maskCardNumber(String last4Digits) {
    const maskedDigits = '**** **** **** ';
    return maskedDigits + last4Digits;
  }
}
