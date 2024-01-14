import 'package:flutter/material.dart';
import 'package:weatherapp/api/api_key.dart';
import 'package:weatherapp/services/weather_services.dart';

import '../models/weather_models.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherServices(apikey: API_KEY);
  Weather? _weather;
//fetch weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();
    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    // any errors
    catch (e) {
      print(e);
    }
  }

//weather animation
//init state
  @override
  void initState() {
    super.initState();
    //fetch weather on startup
    _fetchWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold();
  }
}
