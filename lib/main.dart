import 'package:flutter/material.dart';
import 'package:grade13/games_app/games_view.dart';
import 'package:grade13/news_app/news_api_service.dart';
import 'package:grade13/news_app/news_home_view.dart';
import 'package:grade13/shop_app/shop_api_service.dart';
import 'package:grade13/shop_app/shop_view.dart';
import 'package:grade13/weather_app/weather_api_service.dart';
import 'package:grade13/weather_app/weather_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    NewsApiService().fetchData();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
       // home:WeatherView() ,
         home:ShopView() ,
      //home:NewsHomeView() ,
     // home:GamesView() ,
    );
  }
}

