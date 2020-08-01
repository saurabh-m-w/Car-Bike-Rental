import 'package:flutter/material.dart';

const MainHeading = TextStyle(
    fontWeight: FontWeight.bold,fontSize: 25
);

const SubHeading = TextStyle(
    fontWeight: FontWeight.bold,fontSize: 20
);
const BasicHeading = TextStyle(
    fontSize: 15
);

class cardetailsclass{
  final String title;
  final String color;
  final double price;
  final String gearbox;
  final String fuel;
  final String path;
  final String brand;

  cardetailsclass({this.title,this.price,this.path,this.color,this.gearbox,this.fuel,this.brand});


}