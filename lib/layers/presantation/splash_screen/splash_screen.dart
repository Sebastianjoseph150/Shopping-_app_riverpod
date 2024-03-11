import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shoping/layers/presantation/home_page/home_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMainScreen();
  }

  Future _navigateToMainScreen() async {
    await Future.delayed(const Duration(seconds: 3)); 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const HomeScreen()), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/Animation - 1710167901894 (1).json'),
      ),
    );
  }
}
