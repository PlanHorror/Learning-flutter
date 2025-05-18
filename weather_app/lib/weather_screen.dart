import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
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
                            '25°C',
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 5,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 100,
                        height: 100,

                        child: Column(
                          children: [
                            Text('Monday', style: TextStyle(fontSize: 18)),
                            Icon(Icons.cloud, size: 50),
                            Text('22°C'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            Text('Tuesday', style: TextStyle(fontSize: 18)),
                            Icon(Icons.cloud, size: 50),
                            Text('24°C'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            Text('Wednesday', style: TextStyle(fontSize: 18)),
                            Icon(Icons.cloud, size: 50),
                            Text('26°C'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            Text('Thursday', style: TextStyle(fontSize: 18)),
                            Icon(Icons.cloud, size: 50),
                            Text('28°C'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            Text('Friday', style: TextStyle(fontSize: 18)),
                            Icon(Icons.cloud, size: 50),
                            Text('30°C'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            Text('Saturday', style: TextStyle(fontSize: 18)),
                            Icon(Icons.cloud, size: 50),
                            Text('32°C'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Placeholder(fallbackHeight: 150),
          ],
        ),
      ),
    );
  }
}
