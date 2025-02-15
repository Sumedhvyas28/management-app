import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:management/home/dashboard.dart';
import 'package:management/onboarding/intro_screen/onboarding_screen.dart';

class SplashScreenRepo {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => DashboardPage())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => OnboardingScreen())));
    }
  }
}
