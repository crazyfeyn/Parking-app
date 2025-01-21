import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/config/work_manager.dart';
import 'package:flutter_application/core/constants/stripe_constants.dart';
import 'package:flutter_application/features/auth/data/datasources/local_auth_datasources.dart';
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
import 'package:workmanager/workmanager.dart';
import 'server_locator.dart' as di;

void main() async {
  try {
    print('-1-1-1-1-1-1');
    WidgetsFlutterBinding.ensureInitialized();
    print('-2-2-2-2-2');

    Stripe.publishableKey = StripeConstants.stripePublishableKey;
    Stripe.merchantIdentifier = 'any string works';
    await Stripe.instance.applySettings();
    print('-3--3-3-33-3--3-');
    await di.init();
    print('-4-4-4-4-4-4');

    final localAuthDatasources = di.sl<LocalAuthDatasources>();
    print('------');
    final workManagerClass = WorkManagerClass(
      dio: Dio(),
      localAuthDatasources: localAuthDatasources,
    );
    print('11111');

    await Workmanager()
        .initialize(WorkManagerClass.callbackDispatcher, isInDebugMode: true);

    // Handle refresh token
    final refreshToken = await localAuthDatasources.getRefreshToken();
    if (refreshToken.isNotEmpty) {
      await workManagerClass.registerPeriodicTask(refreshToken);
    }
  } catch (e) {
    print('Initialization error: $e');
    // Handle the error appropriately
  }

  runApp(const MyApp());
}

// Future<void> _setup() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Stripe.publishableKey = StripeConstants.stripePublishableKey;
// }

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
