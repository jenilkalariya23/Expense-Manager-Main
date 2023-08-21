import 'package:flutter/material.dart';

class AssetsHelper {

  static AssetImage getIcon(String name) {
    return AssetImage("assets/Icons/"+name);
  }
  static AssetImage getOnboarding1(String name) {
    return AssetImage("assets/Icons/Onboarding 1/"+name);
  }

  static AssetImage getOnboarding2(String name) {
    return AssetImage("assets/Icons/Onboarding 2/"+name);
  }

  static AssetImage getOnboarding3(String name) {
    return AssetImage("assets/Icons/Onboarding 3/"+name);
  }

  static AssetImage getSplashScreen(String name) {
    return AssetImage("assets/Icons/Splash_Screen/"+name);
  }
}