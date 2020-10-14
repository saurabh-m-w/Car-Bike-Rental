
import 'package:car_bike_rental/constants/constant.dart';
import 'package:car_bike_rental/screens/search_screen.dart';
import 'package:car_bike_rental/widgets/cars_grid_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        backgroundColor: Theme.of(context).primaryColor,
        bottomNavigationBar:bottomBar(context,1),

        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return<Widget>[
                SliverAppBar(
                  actions: [
                    IconButton(icon: Icon(Icons.search),onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchScreen()));
                    },)
                  ],
                  bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.directions_car,color: Colors.blue,)),
                    Tab(icon: Icon(Icons.directions_bike,color: Colors.blue,)),
                  ],
                ),

                  expandedHeight: 250.0,
                  floating: false,
                  title: Text('Carbike Rental'),
                  pinned:true,

                  flexibleSpace: FlexibleSpaceBar(

                    centerTitle: true,

                    background: Image.asset("assets/appbarback.jpg",fit: BoxFit.cover,),
                  ),
                ),
              ];
          },
          body: TabBarView(
            children: [
              ListView(

                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Avaliable Cars',style: MainHeading,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: carsGridFirebase(),
                    ),

                  ],

              ),
              Icon(Icons.directions_bike)
            ],
          ),
        ),
      ),
    );
  }
}
