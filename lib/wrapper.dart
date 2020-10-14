import 'dart:async';

import 'package:car_bike_rental/screens/cars_overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';
import 'models/user.dart';


class Wrapper extends StatefulWidget {

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    Duration(seconds: 1);

    if(user==null)
      return Authenticate();
    else
      return MyApp();

  }
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
