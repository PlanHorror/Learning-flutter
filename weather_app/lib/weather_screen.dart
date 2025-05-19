import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/forecast_widget.dart';
import 'package:weather_app/weather_detail.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late double temperature;
  bool isLoading = true;
  String weatherDescription = '';
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    final apiKey = dotenv.env['WEATHER_SECRET'];
    final city = dotenv.env['CITY'] ?? 'London'; // Default city if not provided
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          temperature =
              double.parse(data['list'][0]['main']['temp'].toString()) -
              273.15; // Convert from Kelvin to Celsius
          weatherDescription = data['list'][0]['weather'][0]['description'];
          isLoading = false;
        });
        // Parse the JSON data
        // You can use jsonDecode(response.body) to extract the weather data
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '${temperature.toStringAsFixed(1)}°C',
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Icon(Icons.cloud, size: 100),
                                  Text(
                                    weatherDescription,
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Weather Forecast',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ForecastWidget(time: '12 PM', temperature: '25°C'),
                          ForecastWidget(time: '1 PM', temperature: '26°C'),
                          ForecastWidget(time: '2 PM', temperature: '27°C'),
                          ForecastWidget(time: '3 PM', temperature: '28°C'),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    Text(
                      'Weather Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        WeatherDetail(
                          label: 'Temperature',
                          icon: Icons.thermostat,
                          value: '25°C',
                        ),
                        WeatherDetail(
                          label: 'Humidity',
                          icon: Icons.water_drop,
                          value: '60%',
                        ),
                        WeatherDetail(
                          label: 'Wind Speed',
                          icon: Icons.air,
                          value: '10 km/h',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }
}
