import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/stripe_constants.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/booking_space/presentation/provider/booking_provider.dart';
import 'package:flutter_application/features/history/presentation/bloc/history_bloc.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_application/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter_application/server_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'server_locator.dart' as di;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await _setup();
  runApp(
    const MyApp(),
  );
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = StripeConstants.stripePublishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return sl<AuthBloc>();
          },
        ),
        BlocProvider(create: (context) {
          return sl<HomeBloc>();
        }),
        BlocProvider(
          create: (context) {
            return sl<ProfileBloc>();
          },
        ),
        BlocProvider(create: (context) {
          return sl<HistoryBloc>();
        }),
        Provider<BookingProvider>(
          create: (context) {
            final provider = sl<BookingProvider>();
            return provider;
          },
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
