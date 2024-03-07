import 'dart:ui';

import 'package:lottie/lottie.dart';

class WeatherData {
  String cityName;
  double temperature;
  String cloudiness;
  String animationPath;
  VoidCallback   onPressed;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.cloudiness,
    required this.animationPath,

    required this.onPressed,
  });
}