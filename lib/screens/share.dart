import 'package:car_bike_rental/constants/constant.dart';
import 'package:car_bike_rental/screens/cars_details.dart';
import 'package:car_bike_rental/screens/share_car.dart';
import 'package:car_bike_rental/services/auth.dart';
import 'package:car_bike_rental/widgets/loading_shimmer_effect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class GetData extends StatefulWidget {
  @override
  _GetDataState createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {

  cardetailsclass _cardetailsclass;
  final  AuthService _auth = AuthService();
  final Firestore fb = Firestore.instance;

  Future<QuerySnapshot> getImages() async{
    user = await _auth.getCurrentUserEmail();
    return await fb.collection("carlist").where('userEmail',isEqualTo: user.email.toString()).getDocuments();
  }


  String email='';
  FirebaseUser user;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listed by you'),),
      bottomNavigationBar:bottomBar(context,2),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: FutureBuilder(
            future:  getImages(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              _cardetailsclass=cardetailsclass(title: snapshot.data.documents[index].data["title"],
                                  brand: snapshot.data.documents[index].data["brand"],
                                  fuel: snapshot.data.documents[index].data["fuel"],
                                  price: snapshot.data.documents[index].data["price"],
                                  imgUrl: snapshot.data.documents[index].data["imgurl"],
                                  location: snapshot.data.documents[index].data["location"],
                                  seats: snapshot.data.documents[index].data["seats"],
                                  doors: snapshot.data.documents[index].data["doors"],
                                  userEmail: snapshot.data.documents[index].data["userEmail"]
                              );
                            });
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CarDetails(cardetailsclass:_cardetailsclass)));
                          },
                          child: Container(
                            height: 160,
                            margin: EdgeInsets.only(top:15,bottom:15),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 5, spreadRadius: 1)
                                ]),

                            child: Row(
                              children: [
                                Hero(
                                    tag: snapshot.data.documents[index].data["imgurl"],
                                    child: Image.network(snapshot.data.documents[index].data["imgurl"],height: 160,width: 160,fit: BoxFit.fill,)),
                                SizedBox(width: 10,),
                                Column(mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                      Text(snapshot.data.documents[index].data["title"],style: SubHeading,),
                                      SizedBox(height: 10,),
                                      Text(snapshot.data.documents[index].data["price"].toString()+'₹ per day',style: BasicHeading,),
                                    ]),


                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Center(child: Text("No data"));
              }
              return LoadingList();
            },
          ),
        ),
      ),

      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        child: Icon(Icons.add),

        visible: true,
        curve: Curves.bounceIn,

        children: [
          SpeedDialChild(
          child: Icon(Icons.directions_car, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShareCar()));},
          label: 'List Your Car',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.directions_bike, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => print('SECOND CHILD'),
          label: 'List Your Bike',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        /*SpeedDialChild(
            child: Icon(Icons.keyboard_voice, color: Colors.white),
            backgroundColor: Colors.blue,
            onTap: () => print('THIRD CHILD'),
            labelWidget: Container(
            color: Colors.blue,
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(6),
            child: Text('Custom Label Widget'),
          )
        )*/
    ],
      ),

    );
  }
}
