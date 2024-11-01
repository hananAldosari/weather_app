import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/service/api_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {


    on<SearchPressedEvent>((event, emit) async{
      String city = event.city;
     if(city.isEmpty){
      emit(HandleTextState(errorMessage: "Please enter a city name"));
     }else{
       WeatherApi.instance.setCityName(city);
        var weatherData= await WeatherApi.instance.fetchWeather(); 
        if(weatherData['statusCode']==200){
          emit(WeatherInfoState(cityName: weatherData['cityName'], weather: weatherData['weather'], temperature: weatherData['temperature'], humidity: weatherData['humidity'], pressure: weatherData['pressure'], description: weatherData['description'],));
        }else if (weatherData['statusCode']==404){
          emit(HandleTextState(errorMessage: "City not found. Please enter a valid city name."));
        }else{
          emit(HandleTextState(errorMessage: "Something went wrong. Please try again."));
        }
     }
    });
  }
}