import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_application/features/home/presentation/pages/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEvent.authicated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(seconds: 1),
                pageBuilder: (context, animation, secondaryAnimation) =>
                     MainScreen(
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          }
          if (state.status == Status.error) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 600),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const LoginScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            color: AppConstants.mainColor,
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment(-1, 0.9),
              image: AssetImage(
                'assets/images/bg.png',
              ),
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 194,
                height: 150,
              ),
              const Text(
                'Park my truck',
                style: TextStyle(
                    letterSpacing: 8,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFFFFF)),
              )
            ],
          )),
        ),
      ),
    );
  }
}
