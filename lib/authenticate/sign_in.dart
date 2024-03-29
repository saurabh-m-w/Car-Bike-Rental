


import 'package:car_bike_rental/constants/constant.dart';
import 'package:car_bike_rental/services/auth.dart';
import 'package:car_bike_rental/widgets/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final  Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email='';
  String password = '';
  String error='';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(backgroundColor: Colors.blue,elevation: 0.0,title: Text('Sign In'),actions: <Widget>[
        FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text('Register'))
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

                 SizedBox(height: 20.0,),
                 TextFormField(
                   decoration: textInputDecoration.copyWith(hintText: 'Email'),
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
                   child: Text('Sign in',style: TextStyle(color: Colors.white),),
                   onPressed: () async {
                     if(_formkey.currentState.validate()){
                       setState(() {
                         loading=true;
                       });
                        dynamic result =await _auth.signInWithEmailAndPassword(email, password);
                       if(result==null){
                         setState(() {
                           error='Could Not Sign In with those credentials';
                           loading=false;
                         });
                       }
                     }
                   },
                 ),
                 SizedBox(height: 12.0,),
                 Text(
                   error,
                   style: TextStyle(color: Colors.red,fontSize: 14.0),
                 )
               ],
             ),
            ),

          ),
        ],
      ),
    );
  }
}
