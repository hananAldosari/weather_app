import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  
import 'dart:convert';

import 'package:lottie/lottie.dart';
import 'package:weather_app/weather_info.dart';  

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController city_controller = TextEditingController();
  String _apiKey = "c691bac79ed1c903278f2db077f4b80f";

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: const Color.fromARGB(255, 195, 208, 215),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Lottie.asset('assets/home.json'),
                  ),
        
                  Wrap(
                    children: [
                      Text(
                        "Enter City to", 
                        style:TextStyle(
                          fontSize:25, 
                          fontWeight: FontWeight.w300,
                          color: Colors.blueGrey
                          ) 
                        ,),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Wethaer Forecast",
                          style:TextStyle(
                            fontSize:30,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.blueGrey[700]
                            ) 
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 60,
                    child: TextField(
                      controller: city_controller,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async{
                            String city_name = city_controller.text; 
                            var url = Uri.parse(
                            'http://api.openweathermap.org/data/2.5/weather?q=${city_name}&units=metric&appid=$_apiKey');
                            var response = await http.get(url);
                            if (city_name.isNotEmpty) {
                              if (response.statusCode == 200){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Weather(city_name: city_name), // Pass the city_name here
                                ),
                              );
                            }else if (response.statusCode == 404) {
                              // City not found
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('City not found. Please enter a valid city name.')),
                              );
                            } else {
                              // Other errors
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Something went wrong. Please try again.')),
                              );
                            }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Please enter a city name')),
                              );
                            }
                          },
                          icon: Icon( Icons.search)
                          ),
                        hintText: "Search city",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color.fromARGB(255, 97, 116, 131),)
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
