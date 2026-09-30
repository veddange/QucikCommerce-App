import 'package:flutter/material.dart';

class OnboardingScreen {
  final String title;
  final String description;
  final String image;

  OnboardingScreen({
    required this.title,
    required this.description,
    required this.image,
  });
}


final List<OnboardingScreen> onboardingScreensData = [
  OnboardingScreen(
    title: "Welcome",
    description: "Welcome to our app. Let's get started!",
    image: "assets/screen_1.png",
  ),
  OnboardingScreen(
    title: "Explore",
    description: "Discover amazing features and explore the app.",
    image: "assets/screen_2.png",
  ),
  OnboardingScreen(
    title: "Get Started",
    description: "Everything is ready. Start using the app today!",
    image: "assets/screen_3.png",
  ),
];


class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenW;
  static double? screenH;
  static double? blockH;
  static double? blockV;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenW = _mediaQueryData!.size.width;
    screenH = _mediaQueryData!.size.height;
    blockH = screenW! / 100;
    blockV = screenH! / 100;
  }
}