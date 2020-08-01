import 'package:car_bike_rental/constants/constant.dart';
import 'package:car_bike_rental/widgets/cars_grid.dart';
import 'package:flutter/material.dart';

class CarsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        child: Container(height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton.icon(onPressed: null, icon: Icon(Icons.directions_car,color: Colors.black,), label: Text('Rent',style: TextStyle(color: Colors.black),)),
                FlatButton.icon(onPressed: null, icon: Icon(Icons.search,color: Colors.black,), label: Text('Search',style: TextStyle(color: Colors.black),)),
                FlatButton.icon(onPressed: null, icon: Icon(Icons.file_upload,color: Colors.black), label: Text('Share',style: TextStyle(color: Colors.black),)),
                FlatButton.icon(onPressed: null, icon: Icon(Icons.person,color: Colors.black), label: Text('Profile',style: TextStyle(color: Colors.black),)),
              ],
            ),
        ),

      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('Car Bike Rental',style: SubHeading,),
      ),
      body: ListView(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Avaliable Cars',style: MainHeading,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarsGrid(),
            ),

          ],

      ),

    );
  }
}
