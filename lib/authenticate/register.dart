

import 'package:car_bike_rental/services/auth.dart';
import 'package:car_bike_rental/services/database.dart';
import 'package:car_bike_rental/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:car_bike_rental/constants/constant.dart';
class Register extends StatefulWidget {
  final  Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final DatabaseService databaseService=DatabaseService();
  final AuthService _auth = AuthService();
  DatabaseService dbaseService=DatabaseService();
  QuerySnapshot userNameSnapshot;
  final _formkey = GlobalKey<FormState>();
  String name='';
  String username='';
  String email='';
  String password = '';
  String error='';
  bool loading = false,uniqueUserName=false;

    uniqueusername(String userName)async{
      print(userName);
    await dbaseService.getUserInfoByUsername(userName).then((snapshot){
      userNameSnapshot=snapshot;
      print(userNameSnapshot.documents.length);
      if(userNameSnapshot.documents.length!=0){
         setState(() {
           uniqueUserName=true;
         });
      }
      else{
       setState(() {
         uniqueUserName=false;
       });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(backgroundColor: Colors.blue,elevation: 0.0,title: Text('Sign Up'),actions: <Widget>[
        FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text('Sign In'))
      ],),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[

                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Username',),
                    validator: (val)=>   uniqueUserName||val.isEmpty? 'Enter valid username':null,
                    autovalidate: true,
                    autofocus: true,
                    onChanged: (val){
                      uniqueusername(val);
                      },
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Name',),
                    validator: (val)=>  val.isEmpty ? 'Enter an name':null,

                    onChanged: (val){setState(() {
                      name=val;
                    });},
                  ),

                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email',),
                    validator: (val)=>  val.isEmpty ? 'Enter an Email':null,

                    onChanged: (val){setState(() {
                      email=val;
                    });},
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val)=>  val.length<6   ? 'Enter Password 6+ char long':null,
                    obscureText: true,
                    onChanged: (val){setState(() {
                      password=val;
                    });},
                  ),
                  SizedBox(height: 20.0,),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text('Register',style: TextStyle(color: Colors.white),),
                    onPressed: () async {
                      if(_formkey.currentState.validate()){
                        setState(() {
                          loading=true;
                        });
                        dynamic  result=await _auth.registerWithEmailAndPassword(email, password);
                        if(result==null){
                          setState(() {
                            error='please supply valid email';
                            loading=false;
                          });
                        }else{
                          Map<String,String> userDataMap={
                            'userName':username,
                            'name':name,
                            'userEmail':email,
                          };
                          databaseService.addUserInfo(userDataMap);
                        }
                      }
                      },
                  ),
                  SizedBox(height: 12.0,),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red,fontSize: 14.0),
                  ),
                ],
              ),
            ),

          ),
        ],
      ),
    );
  }
}
