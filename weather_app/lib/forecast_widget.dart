import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({super.key});

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
              Text('Monday', style: TextStyle(fontSize: 12)),
              Icon(Icons.cloud, size: 35),
              Text('22°C'),
            ],
          ),
        ),
      ),
    );
  }
}
