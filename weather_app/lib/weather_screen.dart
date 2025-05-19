import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/forecast_widget.dart';
import 'package:weather_app/weather_detail.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    final apiKey = dotenv.env['WEATHER_SECRET'];
    final city = dotenv.env['CITY'] ?? 'London'; // Default city if not provided
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Parse the JSON data
        // You can use jsonDecode(response.body) to extract the weather data
        return data;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrentWeather(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final currentWeather = snapshot.data!['list'][0];
        final currentTemp = currentWeather['main']['temp'];
        final weatherForecast = snapshot.data!['list'];
        final currentWindSpeed = currentWeather['wind']['speed'];
        final currentHumidity = currentWeather['main']['humidity'];
        final currentPressure = currentWeather['main']['pressure'];
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
                  setState(() {
                    // Refresh the weather data
                  });
                },
              ),
            ],
          ),
          body: Padding(
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
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Column(
                            children: [
                              Text(
                                '${(currentTemp - 273.15).toStringAsFixed(1)}°C',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Icon(Icons.cloud, size: 100),
                              Text('Cloudy', style: TextStyle(fontSize: 24)),
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       ForecastWidget(time: '12 PM', temperature: '25°C'),
                //       for(int i=0; i<5; i++)
                //       ForecastWidget(
                //         time: '${i + 1} PM',
                //         temperature: '${(currentTemp - 273.15 + i).toStringAsFixed(1)}°C',
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weatherForecast.length,
                    itemBuilder: (context, index) {
                      final forecastTime = DateTime.parse(
                        weatherForecast[index]['dt_txt'],
                      );
                      final forecastTemp =
                          '${(weatherForecast[index]['main']['temp'] - 273.15).toStringAsFixed(1)}°C';
                      return ForecastWidget(
                        time: DateFormat.Hm().format(forecastTime),
                        temperature: forecastTemp,
                      );
                    },
                  ),
                ),

                SizedBox(height: 20),
                Text(
                  'Weather Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    WeatherDetail(
                      label: 'Pressure',
                      icon: Icons.compress,
                      value: '$currentPressure hPa',
                    ),
                    WeatherDetail(
                      label: 'Humidity',
                      icon: Icons.water_drop,
                      value: '$currentHumidity%',
                    ),
                    WeatherDetail(
                      label: 'Wind Speed',
                      icon: Icons.air,
                      value: '$currentWindSpeed m/s',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
