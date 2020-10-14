import 'package:car_bike_rental/constants/constant.dart';
import 'package:car_bike_rental/screens/cars_details.dart';
import 'package:car_bike_rental/widgets/loading_shimmer_effect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  cardetailsclass _cardetailsclass;
  final Firestore fb = Firestore.instance;
  Future<QuerySnapshot> getImages() {
    return fb.collection("carlist").where('location',isGreaterThanOrEqualTo: search).getDocuments();
  }


  String search='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextField(
        decoration: InputDecoration(
      fillColor: Colors.black.withOpacity(0.1),
          filled: true,
          prefixIcon: Icon(Icons.search),
          hintText: 'Search something ...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          contentPadding: EdgeInsets.zero
      ),
        autofocus: true,
        onChanged: (val){
          setState(() {
            search=val;
          });
        },
      ),),
      body: SingleChildScrollView(
        child: Column(
          children: [

        Container(
          padding: EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: getImages(),
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
                return Text("No data");
              }
              return LoadingList();
            },
          ),
        )
          ],
        ),
      ),
    );
  }
}
