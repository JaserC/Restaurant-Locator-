import 'dart:convert';
import 'package:food_finder/providers/weather_provider.dart';
import 'package:http/http.dart' as http;
import 'package:food_finder/weather_conditions.dart';

class WeatherChecker {
  final WeatherProvider weatherProvider;
  double? _latitude; //Allen Center is here, per Google Maps
  double? _longitude;

  WeatherChecker(this.weatherProvider);

  updateLocation(double newLatitude, double newLongitude) {
    _latitude = newLatitude;
    _longitude = newLongitude;
  }

  double get latitude{
    return _latitude ?? 0.0;
  }

  double get longitude{
    return _latitude ?? 0.0;
  }

  fetchAndUpdateCurrentSeattleWeather() async {
    var client = http.Client();
    try {
      final gridResponse = await client.get(
          Uri.parse('https://api.weather.gov/points/$_latitude,$_longitude'));
      final gridParsed = (jsonDecode(gridResponse.body));
      final String? forecastURL = gridParsed['properties']?['forecast'];
      if (forecastURL == null) {
        // do nothing
      } else {
        final weatherResponse = await client.get(Uri.parse(forecastURL));
        final weatherParsed = jsonDecode(weatherResponse.body);
        final currentPeriod = weatherParsed['properties']?['periods']?[0];
        if (currentPeriod != null) {
          final temperature = currentPeriod['temperature'];
          final shortForecast = currentPeriod['shortForecast'];
          print(
              'Got the weather at ${DateTime.now()}. $temperature F and $shortForecast');
          if (temperature != null && shortForecast != null) {
            final condition = _shortForecastToCondition(shortForecast);
            weatherProvider.updateWeather(temperature, condition);
          }
        }
      }
    } catch (_) {
      // TODO(optional): Find a way to have the UI let the user know that we haven't been able to update data successfully
    } finally {
      client.close();
    }
  }

  WeatherCondition _shortForecastToCondition(String shortForecast) {
    final lowercased = shortForecast.toLowerCase();
    if (lowercased.startsWith('rain')) return WeatherCondition.rainy;
    if (lowercased.startsWith('sun') || lowercased.startsWith('partly'))
      return WeatherCondition.sunny;
    return WeatherCondition.gloomy;
  }
}
