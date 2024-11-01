import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/home.dart';
import 'package:weather_app/service/api_service.dart';

class Weather extends StatefulWidget {
  final String city_name;
  const Weather({super.key, required this.city_name});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == 'null') return 'assets/clear.json';

    switch (mainCondition?.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunderstorm';
      case 'clear':
        return 'assets/clear.json';
      default:
        return 'assets/clear.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();
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
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
             if(state is WeatherInfoState){
               return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.city_name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 59, 65, 68),
                      )),
                  Text(
                    "$formattedDate  $formattedTime",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Lottie.asset(getWeatherAnimation(state.weather), height: 150),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    '${state.temperature} °C',
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(
                    state.description,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.water_drop),
                          const Text("Humidity"),
                          Text(
                            '${state.humidity} %',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: 30,
                          child: const VerticalDivider(
                            thickness: 1,
                            color: Color.fromARGB(255, 121, 119, 119),
                          )),
                      Column(
                        children: [
                          const Icon(Icons.thermostat),
                          const Text("Pressure"),
                          Text(
                            ' ${state.pressure} Pa',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
             }else{
              return SizedBox.shrink();
             }
            },
          ),
        )),
      ),
    );
  }
}
