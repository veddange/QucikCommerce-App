import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quickcommerce_app/OnboardingScreen/onboarding_screen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color((0xFFCBE3FC)), Color(0xFFE8F4FF), Color(0xFFFFFFFF)],
          ),
        ),
          child: Column(
            spacing: 5.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset("assets/online-shopping.png", width: 100, height: 100),
              Icon(Icons.shopping_cart_outlined, size: 90, color: Colors.orange[300]),
              Text(
                "Quick Commerce App",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
