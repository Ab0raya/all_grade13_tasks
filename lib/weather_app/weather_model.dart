class WeatherModel {
  final String locationName;
  final String icon;
  final String state;
  final num degree;

  WeatherModel({
    required this.locationName,
    required this.icon,
    required this.degree,
    required this.state,
  });

  factory WeatherModel.fromJson(dynamic data) {
    return WeatherModel(
      state: data['current']['condition']['text'],
      locationName: data['location']['name'],
      icon: data['current']['condition']['icon'],
      degree: data['current']['temp_c'],
    );
  }
}
