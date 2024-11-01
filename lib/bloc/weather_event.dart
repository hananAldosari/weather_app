part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class SearchPressedEvent extends WeatherEvent{
  String city;
  SearchPressedEvent(this.city);
}

