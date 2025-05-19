import 'package:flutter/material.dart';

class WeatherDetail extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  const WeatherDetail({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontSize: 18)),

        const SizedBox(height: 5),
        Text(value, style: const TextStyle(fontSize: 24)),
      ],
    );
  }
}
