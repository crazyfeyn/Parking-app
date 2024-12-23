import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/stripe_constants.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_application/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/home/presentation/pages/main_screen.dart';
import 'package:flutter_application/server_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
