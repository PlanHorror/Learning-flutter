import 'package:flutter/material.dart';

class WeatherDetail extends StatelessWidget {
  const WeatherDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,

      children: [
        Column(
          children: [
            Icon(Icons.thermostat, size: 40),
            Text('Temperature'),
            Text('25°C'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.water_drop, size: 40),
            Text('Humidity'),
            Text('60%'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.air, size: 40),
            Text('Wind Speed'),
            Text('10 km/h'),
          ],
        ),
      ],
    );
  }
}
