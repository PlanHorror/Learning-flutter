import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  final String day;
  final String time;
  final String temperature;
  final String icon;

  const ForecastWidget({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: 80,

          child: Column(
            children: [
              Text(day, style: TextStyle(fontSize: 12)),
              Text(time, style: TextStyle(fontSize: 12)),
              SizedBox(height: 5),
              Icon(
                icon == 'Clouds'
                    ? Icons.cloud
                    : icon == 'Rain'
                    ? Icons.umbrella
                    : icon == 'Clear'
                    ? Icons.wb_sunny
                    : Icons.sunny,
                size: 35,
              ),
              SizedBox(height: 5),
              Text(temperature, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
