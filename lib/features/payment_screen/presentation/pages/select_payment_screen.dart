import 'package:flutter/material.dart';
import 'package:flutter_application/core/config/stripe_service.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/payment_screen/presentation/widgets/shimmer_card_widget.dart';
import 'package:flutter_application/server_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/payment_screen/presentation/widgets/card_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SelectPaymentScreen extends StatefulWidget {
  const SelectPaymentScreen({super.key});

  @override
  State<SelectPaymentScreen> createState() => _SelectPaymentScreenState();
}

class _SelectPaymentScreenState extends State<SelectPaymentScreen> {
  final StripeService stripeService = sl<StripeService>();

  @override
  void initState() {
    super.initState();
    // Fetch payment methods only once when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeEvent.fetchPaymentMethodList());
    });
  }

  Widget _buildAddCardButton() {
    return ZoomTapAnimation(
      onTap: () async {
        await stripeService.addCard();
        if (mounted) {
          context
              .read<HomeBloc>()
              .add(const HomeEvent.fetchPaymentMethodList());
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimens.PADDING_14),
        margin: const EdgeInsets.only(bottom: AppDimens.MARGIN_16),
        decoration: BoxDecoration(
          color: AppConstants.mainColor,
          borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Add Card',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white,
              ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
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
            if (state.status == Status.errorNetwork) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage ?? 'Please check your connection',
                  ),
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildAddCardButton(),
                  if (state.status == Status.loading)
                    const ShimmerCardWidget()
                  else if (state.status == Status.success &&
                      state.listPaymentMethod != null)
                    ...state.listPaymentMethod!.map(
                      (method) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: AppDimens.MARGIN_12),
                        child: CardWidget(
                          cardNumber: _maskCardNumber(method.card.last4),
                          isDefault: method.isDefault,
                          onTap: () {
                            context.read<HomeBloc>().add(
                                  HomeEvent.updateIsDefaultCard(
                                    method.id.toString(),
                                  ),
                                );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _maskCardNumber(String last4Digits) {
    const maskedDigits = '**** ** ** ';
    return maskedDigits + last4Digits;
  }
}
