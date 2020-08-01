import 'package:car_bike_rental/constants/constant.dart';
import 'package:car_bike_rental/widgets/cars_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        child: Container(height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  elevation: 0,
                  onPressed: (){},
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
                  onPressed: (){},
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
                  onPressed: (){},
                  color: Colors.blueAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.message),
                      Text('Messages')
                    ],
                  ),
                ),
                RaisedButton(

                  onPressed: (){},
                  color: Colors.blueAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle),
                      Text('Profile')
                    ],
                  ),
                ),

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
