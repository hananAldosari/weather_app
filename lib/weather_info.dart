import 'dart:convert';
import 'package:http/http.dart' as http;  
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Weather extends StatefulWidget {

  final String city_name;
  const Weather({super.key, required this.city_name});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  final String _apiKey = "c691bac79ed1c903278f2db077f4b80f";
  String _weather = "Loading...";
  String _description = "";
  String _temperature = "";
  String _humidity="";
  String _pressure="";
  final String _wind="";
 
   _fetchWeather() async {
    var url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=${widget.city_name}&units=metric&appid=$_apiKey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        // _city_name=city_name; 
        _description = jsonData["weather"][0]["description"];
        _temperature = jsonData["main"]["temp"].toString();
        _humidity = jsonData["main"]["humidity"].toString();  
        _pressure= jsonData["main"]["pressure"].toString(); 
        _weather = jsonData['weather'][0]['main'];  
      });
    } else {
      setState(() {
        _description = "Error fetching weather data.";
        _temperature = "";
        _humidity="";
        _pressure="";
        _weather="";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  String getWeatherAnimation(String? mainCondition){
    if (mainCondition == 'null') return 'assets/clear.json';
    
    switch(mainCondition?.toLowerCase()){
      case'clouds':
      case'mist':
      case'smoke':
      case'haze':
      case'dust':
      case'fog':
        return 'assets/cloud.json';
      case'rain':
      case'drizzle':
      case'shower rain':
        return 'assets/rain.json';
      case'thunderstorm':
        return 'assets/thunderstorm';
      case'clear':
        return 'assets/clear.json';
      default:
        return 'assets/clear.json';
      
    }
  }

  
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE,').format(now); 
    String formattedTime = DateFormat('hh:mm a').format(now); 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 195, 208, 215),
      ),
      backgroundColor: const Color.fromARGB(255, 195, 208, 215),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text( 
                  widget.city_name,
                  style: const TextStyle(
                  fontSize: 25, 
                  fontWeight: FontWeight.w400 , 
                  color: Color.fromARGB(255, 59, 65, 68),
                  )
                ),
                Text(
                  "$formattedDate  $formattedTime",
                  style: const TextStyle(
                    fontSize: 20
                  ),
                ),
                const SizedBox(height: 50,),
                Lottie.asset(getWeatherAnimation(_weather), height: 150),
                const SizedBox(height: 50,),

                Text(
                  '$_temperature °C',
                  style: const TextStyle(fontSize: 30),
                ),
          
                Text(
                  _description,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 150,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.water_drop),
                        const Text("Humidity"),
                        Text(
                          '$_humidity %',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      child: const VerticalDivider(thickness: 1, color: Color.fromARGB(255, 121, 119, 119),)
                    ),
                    Column(
                      children: [
                        const Icon(Icons.thermostat),
                        const Text("Pressure"),
                        Text(
                          ' $_pressure Pa',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                ],
              ),
              ],
            ),
          )
        ),
      ),
    );
  }
}