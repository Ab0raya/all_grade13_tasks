import 'package:flutter/material.dart';
import 'package:grade13/weather_app/weather_api_service.dart';
import 'package:grade13/weather_app/weather_model.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final WeatherApiService _weatherApiService = WeatherApiService();
  late Future<WeatherModel> weatherFuture;

  @override
  void initState() {
    weatherFuture = _weatherApiService.fetchWeather('cairo');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff414141),
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: weatherFuture,
            builder: (context, snapshot) {
              final weatherData = snapshot.data ??
                  WeatherModel(
                      locationName: 'locationName',
                      icon: '',
                      degree: 0,
                      state: 'state');
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Icon(
                        Icons.pin_drop_rounded,
                        size: 35,
                        color: Colors.grey,
                      ),
                      Text(
                        weatherData.locationName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 37),
                      )
                    ],
                  ),
                  Image.network('http:${weatherData.icon}'),
                  Column(
                    children: [
                      Text(
                        weatherData.state,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 20),
                      ),
                      Text(
                        '${weatherData.degree} °C',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 42),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
