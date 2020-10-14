import 'package:car_bike_rental/constants/constant.dart';
import 'package:car_bike_rental/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:car_bike_rental/services/auth.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final  AuthService _auth = AuthService();

  //final FirebaseAuth _auth2 = FirebaseAuth.instance;
  String email='',name='',userName='';
  FirebaseUser user;
  QuerySnapshot searchResultSnapshot;
  DatabaseService databaseService=DatabaseService();

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.getCurrentUserEmail();

    await databaseService.getUserInfo(user.email).then((snapshot) {
        searchResultSnapshot = snapshot;
        print(searchResultSnapshot.documents.length);
        setState(() {
          email = user.email;
          name=searchResultSnapshot.documents[0].data["name"];
          userName=searchResultSnapshot.documents[0].data["userName"];
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
        actions: [
          FlatButton.icon(onPressed:  () async{await _auth.signOut();}, icon: Icon(Icons.person), label: Text('Logout')),
        ],
      ),
      bottomNavigationBar: bottomBar(context, 5),
      body:  Padding(
        padding: EdgeInsets.fromLTRB(30, 40,30,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child: Icon(Icons.person,size: 50,),),
            Divider(height: 60.0,color: Colors.grey[800],),
            Text(
              'Name',
              style: TextStyle(color: Colors.grey,letterSpacing: 2.0),
            ),
            SizedBox(height: 10.0,),
            Text(
              name,
              style: TextStyle(letterSpacing: 2.0,fontSize: 20),
            ),
            SizedBox(height: 30.0,),
            Text(
              'Username',
              style: TextStyle(color: Colors.grey,letterSpacing: 2.0),
            ),
            SizedBox(height: 10.0,),
            Text(
              userName,
              style: TextStyle(letterSpacing: 2.0,fontSize: 20),
            ),
            SizedBox(height: 30.0,),
            Row(
              children: <Widget>[
                Icon(Icons.email),
                SizedBox(width: 10.0,),
                Text(email,style: TextStyle(fontSize: 15.0,letterSpacing: 1.0),)
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
