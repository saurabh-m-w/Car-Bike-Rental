import 'dart:io';
import 'package:car_bike_rental/constants/constant.dart';
import 'package:car_bike_rental/models/user.dart';
import 'package:car_bike_rental/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class ShareCar extends StatefulWidget {
  @override
  _ShareCarState createState() => _ShareCarState();
}

class _ShareCarState extends State<ShareCar> {

  final _key=GlobalKey<FormState>();
  final _key2=GlobalKey<ScaffoldState>();


  File _image;
  final picker = ImagePicker();

  String title;
  double price;
  String path;
  int seats;
  int doors;
  String fuel;
  String brand;
  String location;
  String userEmail;

  final FirebaseAuth _auth2 = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth2.currentUser();
    setState(() {
      userEmail=user.email;
    });
  }


  Future<void> showLoadingDialog(BuildContext context,bool isloading) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(

                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    isloading?Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    ):Text("Successfully uploaded....",style: TextStyle(color: Colors.blueAccent),)
                  ]));
        });
  }

  Future openGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });

  }




  @override
  Widget build(BuildContext context) {

    final user =Provider.of<User>(context);

    return Scaffold(
      key: _key2,
      appBar: AppBar(title: Text('Host your car'),),
      bottomNavigationBar: bottomBar(context,2),
      body: Container(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(


              children: [
                _image==null?Container(height: 250,width: 250,color: Colors.white70,child: Center(child: Text('No Image Selected')),):Image.file(_image,width: 250, height: 250,fit: BoxFit.cover,) ,


                RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: (){
                    openGallery();
                  },
                  child: Text('Select Image'),

                ),
                SizedBox(height: 10,),
                TextFormField(

                  validator: (val)=> val.isEmpty?'Enter title':null,
                  decoration: textdecoration.copyWith(hintText:'Title', labelText:'Title'),
                  onChanged: (val){
                    setState(() {
                      title=val;
                    });
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (val)=> val.isEmpty?'Enter location':null,
                  decoration: textdecoration.copyWith(hintText:'Location', labelText:'Location'),
                  onChanged: (val){
                    setState(() {
                      location=val;
                    });
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (val)=> val.isEmpty?'Enter price':null,
                  decoration: textdecoration.copyWith(hintText:'Price', labelText:'Price per day'),
                  keyboardType: TextInputType.number,

                  onChanged: (val){
                    setState(() {
                      price=double.parse(val);
                    });
                  },

                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (val)=> val.isEmpty?'Enter seats':null,
                  decoration: textdecoration.copyWith(hintText:'No of Seats', labelText:'Seats'),
                  keyboardType: TextInputType.number,
                  onChanged: (val){
                    setState(() {
                      seats=int.parse(val);
                    });
                  },

                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (val)=> val.isEmpty?'Enter no of doors':null,
                  decoration: textdecoration.copyWith(hintText:'No of Doors', labelText:'Doors'),
                  keyboardType: TextInputType.number,
                  onChanged: (val){
                    setState(() {
                      doors=int.parse(val);
                    });
                  },

                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (val)=> val.isEmpty?'Enter fuel':null,
                  decoration: textdecoration.copyWith(hintText:'Fuel', labelText:'Fuel'),
                  onChanged: (val){
                    setState(() {
                      fuel=val;
                    });
                  },

                ),
                SizedBox(height: 10,),

                TextFormField(

                  validator: (val)=> val.isEmpty?'Enter brand':null,
                  decoration: textdecoration.copyWith(hintText:'Brand', labelText:'car brand'),
                  onChanged: (val){
                    setState(() {
                      brand=val;
                    });
                  },

                ),
                SizedBox(height: 10,),
                RaisedButton(
                  child: Text('Share'),
                  color: Colors.blueAccent,
                  onPressed: ()async{
                    FocusScope.of(context).requestFocus(FocusNode());
                    if(_key.currentState.validate() && _image!=null){
                      showLoadingDialog(context,true);
                      String imgname=basename(_image.path);
                      StorageReference firebasestorageref=FirebaseStorage.instance.ref().child(imgname);
                      StorageUploadTask uploadTask=firebasestorageref.putFile(_image);
                      StorageTaskSnapshot taskSnapshot= await uploadTask.onComplete;
                      if(taskSnapshot.error==null){
                        final String imgurl=await taskSnapshot.ref.getDownloadURL();
                        await DatabaseService(uid:user.uid).updateUserData(imgurl,title, price, location, seats, doors, fuel, brand,userEmail);
                        Navigator.of(_key2.currentState.context,rootNavigator: true).pop();

                        Duration(microseconds: 100);
                        _key2.currentState.showSnackBar(SnackBar(content: Text('successfully uploaded'),));
                      }
                      else{
                        print('error');
                      }


                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
