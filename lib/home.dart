import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lottie/lottie.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/service/api_service.dart';
import 'package:weather_app/weather_info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController city_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 195, 208, 215),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: BlocListener<WeatherBloc, WeatherState>(
              listener: (context, state) {
                if(state is HandleTextState){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage))
                  );
                }else if(state is WeatherInfoState){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Weather(city_name: city_controller.text), // Pass the city_name here
                    ),
                  );
                }
              },
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Lottie.asset('assets/home.json'),
                        ),
                        Wrap(
                          children: [
                            const Text(
                              "Enter City to",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.blueGrey),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text("Wethaer Forecast",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.blueGrey[700])),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 60,
                          child: TextField(
                            controller: city_controller,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    String cityName = city_controller.text;
                                    context.read<WeatherBloc>().add(SearchPressedEvent(cityName));
                                  },
                                  icon: const Icon(Icons.search)),
                              hintText: "city name",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 97, 116, 131),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    )
            ),
          ),
        )),
      ),
    );
  }
}
