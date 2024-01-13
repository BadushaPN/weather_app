import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/api/api_key.dart';

import '../models/weather_models.dart';

class WeatherServices {
  static String baseUrl = API_KEY;
  final String apikey;
  WeatherServices({required this.apikey});
  Future<Weather> getWeather(String cityName) async {
    final responce = await http
        .get(Uri.parse('$baseUrl?q=$cityName&appid=$apikey&units=metric'));
    if (responce.statusCode == 200) {
      return Weather.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    //Get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } //fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //convert the location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // extract the city name from the first placemark
    String? city = placemarks[0].locality;
    return city ?? '';
  }
}
