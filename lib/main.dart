import 'dart:async';

import 'package:car_bike_rental/screens/cars_overview.dart';
import 'package:car_bike_rental/services/auth.dart';
import 'package:car_bike_rental/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() {
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

