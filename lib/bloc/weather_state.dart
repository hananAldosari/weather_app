part of 'weather_bloc.dart';

@immutable
class WeatherState {}

final class WeatherInitial extends WeatherState {}

// ignore: must_be_immutable
class WeatherInfoState extends WeatherState{

    String weather;
    String description;
    String temperature;
    String humidity;
    String pressure;
    String cityName;

    WeatherInfoState({required this.cityName, required this.weather, required this.temperature,required this.humidity, required this.pressure, required this.description});
}

class HandleTextState extends WeatherState{
  late String errorMessage;

  HandleTextState({required this.errorMessage});
}

