import 'dart:convert';
import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
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
  Future<Map<String, dynamic>>? data;
  List<Map<String, dynamic>> _cities = [];
  Map<String, dynamic>? _selectedCity;
  List<String> tempUnits = ['Celsius', 'Fahrenheit', 'Kelvin'];
  late String tempUnit;

  Future<void> loadCities() async {
    final jsonString = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/json/cities.json');
    final List<dynamic> cityList = jsonDecode(jsonString);
    setState(() {
      _cities = cityList.cast<Map<String, dynamic>>();
      _selectedCity = _cities.first; // default
      data = getCurrentWeather(_selectedCity!['id'].toString());
    });
  }

  @override
  void initState() {
    super.initState();
    tempUnit = tempUnits[0];
    loadCities();
  }

  Future<Map<String, dynamic>> getCurrentWeather(String cityId) async {
    final apiKey = dotenv.env['WEATHER_SECRET'];
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?id=$cityId&appid=$apiKey';

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
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final currentWeather = snapshot.data!['list'][0];
        final currentTemp = currentWeather['main']['temp'];
        final currentWeatherDescription = currentWeather['weather'][0]['main'];
        final weatherForecast = snapshot.data!['list'];
        final currentWindSpeed = currentWeather['wind']['speed'];
        final currentHumidity = currentWeather['main']['humidity'];
        final currentPressure = currentWeather['main']['pressure'];
        return Scaffold(
          // backgroundColor: Colors.black,
          appBar: AppBar(
            leading: Container(
              alignment: Alignment.center,
              child: DropdownButton<String>(
                value: tempUnit,
                underline: Container(),
                icon: const Icon(Icons.arrow_drop_down, size: 16),
                isDense: true,
                // Use shorter representations of temperature units
                items: [
                  DropdownMenuItem(
                    value: 'Celsius',
                    child: Text('°C', style: TextStyle(fontSize: 14)),
                  ),
                  DropdownMenuItem(
                    value: 'Fahrenheit',
                    child: Text('°F', style: TextStyle(fontSize: 14)),
                  ),
                  DropdownMenuItem(
                    value: 'Kelvin',
                    child: Text('K', style: TextStyle(fontSize: 14)),
                  ),
                ],
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      tempUnit = newValue;
                    });
                  }
                },
              ),
            ),
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
                    data = getCurrentWeather(_selectedCity!['id'].toString());
                    print(_selectedCity);
                  });
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                                  tempUnit == 'Celsius'
                                      ? '${(currentTemp - 273.15).toStringAsFixed(1)}°C'
                                      : tempUnit == 'Fahrenheit'
                                      ? '${((currentTemp - 273.15) * 9 / 5 + 32).toStringAsFixed(1)}°F'
                                      : '${currentTemp.toStringAsFixed(1)}K',

                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Icon(
                                  currentWeatherDescription == 'Clouds'
                                      ? Icons.cloud
                                      : currentWeatherDescription == 'Rain'
                                      ? Icons.umbrella
                                      : currentWeatherDescription == 'Clear'
                                      ? Icons.wb_sunny
                                      : Icons.sunny,
                                  size: 100,
                                ),
                                Text(
                                  currentWeatherDescription.toString(),
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
                  SizedBox(
                    width: double.infinity,
                    child: DropdownSearch<Map<String, dynamic>>(
                      items: (String filter, LoadProps? props) async {
                        return _cities.where((city) {
                          return city['name'].toLowerCase().contains(
                            filter.toLowerCase(),
                          );
                        }).toList();
                      },
                      itemAsString:
                          (Map<String, dynamic>? city) => city?['name'] ?? '',
                      onChanged: (Map<String, dynamic>? selectedCity) {
                        if (selectedCity != null) {
                          // Close dropdown first, wait longer to ensure animation completes
                          Future.delayed(Duration(milliseconds: 300), () {
                            if (!mounted) return;

                            // First update just the selected city
                            setState(() {
                              _selectedCity = selectedCity;
                            });

                            // Then trigger the data fetch separately
                            Future.delayed(Duration(milliseconds: 100), () {
                              if (!mounted) return;
                              setState(() {
                                data = getCurrentWeather(
                                  selectedCity['id'].toString(),
                                );
                              });
                            });
                          });
                        }
                      },
                      compareFn: (a, b) => a['id'] == b['id'],
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(hintText: 'Search city'),
                        ),
                      ),
                      decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: "Select a City",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      selectedItem: _selectedCity,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Weather Forecast',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: weatherForecast.length,
                      itemBuilder: (context, index) {
                        final forecastTime = DateTime.parse(
                          weatherForecast[index]['dt_txt'],
                        );
                        final forecastTemp =
                            tempUnit == 'Celsius'
                                ? '${(weatherForecast[index]['main']['temp'] - 273.15).toStringAsFixed(1)}°C'
                                : tempUnit == 'Fahrenheit'
                                ? '${((weatherForecast[index]['main']['temp'] - 273.15) * 9 / 5 + 32).toStringAsFixed(1)}°F'
                                : '${weatherForecast[index]['main']['temp'].toStringAsFixed(1)}K';
                        return ForecastWidget(
                          time: DateFormat.Hm().format(forecastTime),
                          temperature: forecastTemp,
                          icon: weatherForecast[index]['weather'][0]['main'],
                          day: DateFormat.EEEE().format(forecastTime),
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
          ),
        );
      },
    );
  }
}
