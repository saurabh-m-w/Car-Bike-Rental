import 'package:car_bike_rental/screens/cars_details.dart';
import 'package:car_bike_rental/screens/cars_overview.dart';
import 'package:car_bike_rental/screens/message_screen.dart';
import 'package:car_bike_rental/screens/profile.dart';
import 'package:car_bike_rental/screens/share.dart';
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

const textInputDecoration = InputDecoration(
  hintText: 'Password',
  fillColor:  Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2.0)),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink,width: 2.0)),
);


Widget bottomBar(context,i)=>BottomAppBar(
  color: Colors.blueAccent,
  child: Container(height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          elevation: 0,

          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>CarsOverviewScreen()));
          },
          color: Colors.blueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search),
              Text('Search')
            ],
          ),
        ),
        RaisedButton(
          elevation: 0,
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>GetData()));
          },
          color: Colors.blueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.directions_car),
              Text('Share')
            ],
          ),
        ),
        RaisedButton(
          elevation: 0,
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MessageScreen()));
          },
          color: Colors.blueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.message),
              Text('Messages')
            ],
          ),
        ),
        Expanded(
          child: RaisedButton(

            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) =>Profile()));
            },
            color: Colors.blueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_circle),
                Text('Profile')
              ],
            ),
          ),
        ),

      ],
    ),
  ),

);


class cardetailsclass{
  final String title;
  final int seats;
  final double price;
  final int doors;
  final String fuel;
  final String imgUrl;
  final String location;
  final String brand;
  final String userEmail;

  cardetailsclass({this.title,this.price,this.imgUrl,this.location,this.seats,this.doors,this.fuel,this.brand,this.userEmail});


}

const textdecoration=InputDecoration(
  hintText: 'Title',
  labelText: 'Title',
  labelStyle: TextStyle(color: Colors.grey,fontSize: 20),
  fillColor:  Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,width: 2.0)),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink,width: 2.0)),
);