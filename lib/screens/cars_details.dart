
import 'package:car_bike_rental/constants/constant.dart';
import 'package:car_bike_rental/constants/specificationCard.dart';
import 'package:car_bike_rental/screens/conversation.dart';
import 'package:car_bike_rental/services/auth.dart';
import 'package:car_bike_rental/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;


class CarDetails extends StatefulWidget {
  final cardetailsclass;


  CarDetails({this.cardetailsclass});

  @override
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {

  DateTime _startdate=DateTime.now();
  DateTime _enddate=DateTime.now().add(Duration(days:1));
  double price;
  String name='',userName=' ';
  String currentuserEmail='',currentuserUserName=' ';
  int d1;
  final  AuthService _auth = AuthService();

  Future daterangepicker(BuildContext context) async{
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate:_startdate,
        initialLastDate: _enddate,
        firstDate: _startdate,
        lastDate: new DateTime(2050)
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        _startdate=picked[0];
        _enddate=picked[1];
        d1=_enddate.day-_startdate.day;
      });
    }
  }

  QuerySnapshot searchResultSnapshot;
  DatabaseService databaseService=DatabaseService();


  sendMessage(String currentUserName,String userName,BuildContext context){
    List<String> users = [currentUserName,userName];

    String chatRoomId = getChatRoomId(currentUserName,userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };
    databaseService.addChatRoom(chatRoom, chatRoomId);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Conversation(chatRoomId: chatRoomId,currentUserName: currentUserName,)));
  }


  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
   FirebaseUser user = await _auth.getCurrentUserEmail();

    await databaseService.getUserInfo(widget.cardetailsclass.userEmail).then((snapshot) {
      searchResultSnapshot = snapshot;
      print(searchResultSnapshot.documents.length);
      setState(() {
        name=searchResultSnapshot.documents[0].data["name"];
        userName=searchResultSnapshot.documents[0].data["userName"];
        currentuserEmail=user.email;
      });
    });
   await databaseService.getUserInfo(currentuserEmail).then((snapshot) {
     searchResultSnapshot = snapshot;
     print(searchResultSnapshot.documents.length);
     setState(() {
       currentuserUserName=searchResultSnapshot.documents[0].data["userName"];
     });
   });
   print(userName+' '+currentuserUserName);
  }


  @override
  Widget build(BuildContext context) {
    price=widget.cardetailsclass.price;
    d1=(_enddate.day-_startdate.day)*price.toInt();
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(

          height: 60,
          color: Colors.white,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Total:₹${d1}\n ₹${price}/day  ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(width: 10,),
              RaisedButton(
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.blue,
                onPressed: userName==currentuserUserName?null:(){sendMessage(currentuserUserName, userName,context);},
                child: Text(
                  'Book Now',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),


      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
            return<Widget>[
              SliverAppBar(
                expandedHeight: 250.0,
                actions: [
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.bookmark_border, size: 30, color: Theme
                        .of(context)
                        .accentColor,),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.share, size: 30, color: Theme
                        .of(context)
                        .accentColor,),
                  )
                ],
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget.cardetailsclass.title),
                  background: Hero(
                      tag: widget.cardetailsclass.imgUrl,
                      child: Image.network(widget.cardetailsclass.imgUrl,width: double.infinity,height: 100,fit: BoxFit.fill,)),
                ),
              )
            ];
        },
        body: ListView(


          children: [
            Text('    '+widget.cardetailsclass.title, style: MainHeading,),
            Text('      '+widget.cardetailsclass.brand, style: BasicHeading,),
            Divider(thickness: 2,),
            SizedBox(height: 20,),
            Text('      Select DateTime',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.calendar_today,size: 28,),
                Column(
                  children: [
                    Text('  Start Date: ${DateFormat('dd/MM/yyyy').format(_startdate).toString()}',style: TextStyle(fontSize: 18),),
                    SizedBox(height: 5,),
                    Text('  End Date: ${DateFormat('dd/MM/yyyy').format(_enddate).toString()}',style: TextStyle(fontSize: 18),),
                  ],
                ),
                GestureDetector(onTap:()async{ await daterangepicker(context);},child: Text('       change',style: TextStyle(color: Colors.blue,fontSize: 18),))
              ],
            ),
            Divider(thickness: 2,),
            SizedBox(height: 15,),
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(Icons.location_on),
                SizedBox(width: 5,),
                Text('Location:',style: TextStyle(fontSize: 18),),
                SizedBox(width: 5,),
                Text(widget.cardetailsclass.location,style: TextStyle(fontSize: 15),)
              ],
            ),
            Divider(thickness: 2,),
            SizedBox(height: 15,),
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(Icons.contact_mail),
                SizedBox(width: 5,),
                Text('UploadedBy:',style: TextStyle(fontSize: 15),),
                SizedBox(width: 5,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.cardetailsclass.userEmail,style: TextStyle(fontSize: 15),),
                    SizedBox(height: 5,),
                    Text(name,style:TextStyle(fontSize: 15),)
                  ],
                )
              ],
            ),

            SizedBox(height: 15,),
            Divider(thickness: 2,),
            SizedBox(height: 20,),
            Text(
              '     SPECIFICATIONS',
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 20,),
            Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               SpecificCard(
                 name1: Icon(Icons.event_seat,size: 40,),
                 name2:  widget.cardetailsclass.seats.toString()+' seats',
               ),
               SpecificCard(
                 name1: Icon(Icons.view_carousel,size: 40,),
                 name2:  widget.cardetailsclass.doors.toString()+' doors',
               ),
               SpecificCard(
                 name1: Icon(Icons.ev_station,size: 40,),
                 name2:  widget.cardetailsclass.fuel,
               ),
             ],

            ),

            SizedBox(height: 10),



          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

