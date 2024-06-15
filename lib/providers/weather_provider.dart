import 'package:flutter/material.dart';
import 'package:food_finder/weather_conditions.dart';

class WeatherProvider extends ChangeNotifier {
  bool updated = false;
  int tempInFarenheit = 0;
  WeatherCondition condition = WeatherCondition.unkown;

  updateWeather(int newTempFarenheit, WeatherCondition newCondition){
    tempInFarenheit = newTempFarenheit;
    condition = newCondition;
    updated = true;
    notifyListeners();
  }
}