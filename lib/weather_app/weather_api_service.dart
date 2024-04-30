import 'package:dio/dio.dart';
import 'package:grade13/weather_app/weather_model.dart';

class WeatherApiService{
  final dio = Dio();

  Future<WeatherModel> fetchWeather(String cityName) async {
    final response = await dio.get('http://api.weatherapi.com/v1/forecast.json?key=7338b220c3cd42f7be4143017232505&q=$cityName&days=7');
    final weather = WeatherModel.fromJson(response.data);
    if(response.statusCode == 200){
      return weather;
    }else{
      print('failure');
      return weather;
    }
  }
}



