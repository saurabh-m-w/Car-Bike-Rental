
import 'package:car_bike_rental/constants/constant.dart';
import 'package:car_bike_rental/constants/specificationCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class CarDetails extends StatefulWidget {
  final cardetailsclass;

  CarDetails({this.cardetailsclass});

  @override
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {



  String _valueChanged2 = '';
  String _valueToValidate2 = '';
  String _valueSaved2 = '';
  String _valueChanged1 = '';
  String _valueToValidate1 = '';
  String _valueSaved1 = '';
  DateTime date1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark, size: 30, color: Theme
                .of(context)
                .accentColor,),
          ),
          IconButton(
            icon: Icon(Icons.share, size: 30, color: Theme
                .of(context)
                .accentColor,),
          )
        ],
      ),

      body: ListView(
        shrinkWrap: true,

        children: [
          Text(widget.cardetailsclass.title, style: MainHeading,),
          Text(widget.cardetailsclass.brand, style: BasicHeading,),
          Hero(
              tag: widget.cardetailsclass.path,
              child: Image.asset(widget.cardetailsclass.path)),
          //Image.asset(widget.cardetailsclass.path),
          Text('      Start DateTime',style: BasicHeading,),
          DateTimePicker(

            type: DateTimePickerType.dateTime,
            dateMask: 'd MMMM, yyyy - HH:mm',
            initialValue: DateTime.now().toString(),
            icon: Icon(Icons.event,color: Colors.blue,),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),

            onChanged: (val) => setState(()=>_valueChanged1=val),
            onSaved: (val) => setState(() => _valueSaved1 = val),

          ),
          SizedBox(height: 20,),
          Text('      Return DateTime',style: BasicHeading,),
          DateTimePicker(

            type: DateTimePickerType.dateTime,
            dateMask: 'd MMMM, yyyy - HH:mm',
            initialValue: DateTime.now().toString(),
            icon: Icon(Icons.event,color: Colors.blue,),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            //dateLabelText: 'Return DateTime',
            onChanged: (val) => setState(()=>_valueChanged2=val),
            onSaved: (val) => setState(() => _valueSaved2 = val),

          ),
          SizedBox(height: 20),
          Text(
            'SPECIFICATIONS',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 10,),
          Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SpecificCard(
               name1: 'Color',
               name2:  widget.cardetailsclass.color,
             ),
             SpecificCard(
               name1: 'GearBox',
               name2:  widget.cardetailsclass.gearbox,
             ),
             SpecificCard(
               name1: 'Fuel',
               name2:  widget.cardetailsclass.fuel,
             ),
           ],

          ),

          SizedBox(height: 10),
          Container(
            height: 60,
            color: Theme.of(context).accentColor,

            child: RaisedButton(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Theme.of(context).accentColor,

              onPressed: null,
              child: Text(
                'Book Now',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          )


        ],
      ),
    );
  }
}


