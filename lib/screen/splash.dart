import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:masaruna/screen/dashboard.dart';
import 'package:masaruna/screen_Driver/dashboard_Driver.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 500,
      splash: 'assets/images/Logo.png',
      nextScreen: loginPage(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
