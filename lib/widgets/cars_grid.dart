import 'package:car_bike_rental/constants/constant.dart';
import 'package:car_bike_rental/models/cars.dart';
import 'package:car_bike_rental/screens/cars_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarsGrid extends StatefulWidget {

  @override
  _CarsGridState createState() => _CarsGridState();
}

class _CarsGridState extends State<CarsGrid> {
  cardetailsclass _cardetailsclass;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(

      physics: ScrollPhysics(),
      shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context,i){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  _cardetailsclass=cardetailsclass(title: allCars.cars[i].title,
                    brand: allCars.cars[i].brand,
                    fuel: allCars.cars[i].fuel,
                    price: allCars.cars[i].price,
                    path: allCars.cars[i].path,
                    gearbox: allCars.cars[i].gearbox,
                    color: allCars.cars[i].color,);
                });
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CarDetails(cardetailsclass:_cardetailsclass)));
              },
              child: Container(
                height: 100,
                
                margin: EdgeInsets.only(top:i.isEven?0:20,bottom: i.isEven?20:0),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26, blurRadius: 5, spreadRadius: 1)
                    ]),

                  child: Column(
                    children: [
                      Hero(
                          tag: allCars.cars[i].path,
                          child: Image.asset(allCars.cars[i].path)),
                      Text(allCars.cars[i].title,style: BasicHeading,),
                      Row(mainAxisAlignment:MainAxisAlignment.center,
                      children: [Text(allCars.cars[i].price.toString(),style: SubHeading,),Text('₹ per day'),],)


                    ],
                  ),
              ),
            ),
          );
        },
        itemCount: allCars.cars.length,
    );
  }
}
