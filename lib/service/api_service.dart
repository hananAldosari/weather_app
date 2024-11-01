import 'dart:convert';
import 'package:http/http.dart' as http;  

// Step 1: Define a repository class with a private constructor
class WeatherApi{
  // Single instance of the class
  static final WeatherApi _instance = WeatherApi._privateConstructor();
  
  // Private constructor to prevent multiple instances
  WeatherApi._privateConstructor();

  // Getter to access the instance
  static WeatherApi get instance => _instance;

  final String _apiKey = "c691bac79ed1c903278f2db077f4b80f";
  String? _cityName;
  var _apiUrl;

  void setCityName(String cityName){
    _cityName= cityName;
    _apiUrl= Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$_apiKey');
  }

  Uri get apiUrl => _apiUrl;
  String? get cityName => _cityName;

  // Example method to fetch user data from an API 
   Future<Map<String, dynamic>> fetchWeather() async {
    String _weather = "Loading...";
    String _description = "";
    String _temperature = "";
    String _humidity="";
    String _pressure="";
    var response = await http.get(apiUrl!);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
        // _city_name=city_name; 
        _description = jsonData["weather"][0]["description"];
        _temperature = jsonData["main"]["temp"].toString();
        _humidity = jsonData["main"]["humidity"].toString();  
        _pressure= jsonData["main"]["pressure"].toString(); 
        _weather = jsonData['weather'][0]['main'];  

        return{
          'cityName': _cityName,
          'statusCode': response.statusCode,
          'description': _description,
          'temperature': _temperature,
          'humidity': _humidity,
          'pressure': _pressure,
          'weather': _weather,

        };
    } else {
      return{
        'statusCode': response.statusCode,
        'description': "Error fetching weather data.",
          'temperature': "",
          'humidity': "",
          'pressure': "",
          'weather': "",
      };
    }
  }
  }


