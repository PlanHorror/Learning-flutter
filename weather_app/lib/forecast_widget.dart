import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  final String time;
  final String temperature;
  const ForecastWidget({
    super.key,
    required this.time,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: 80,
          height: 80,

          child: Column(
            children: [
              Text(time, style: TextStyle(fontSize: 12)),
              Icon(Icons.cloud, size: 35),
              Text(temperature, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
