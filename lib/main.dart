import 'package:car_bike_rental/screens/cars_overview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.blue
      ),
      home: CarsOverviewScreen(),
    );
  }
}
