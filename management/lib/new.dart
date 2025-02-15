import 'package:flutter/material.dart';
import 'package:management/firebase_services/splash_screen.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => NewPageState();
}

class NewPageState extends State<NewPage> {
  SplashScreenRepo splashScreen = SplashScreenRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          height: 100,
        ),
      ),
    );
  }
}
