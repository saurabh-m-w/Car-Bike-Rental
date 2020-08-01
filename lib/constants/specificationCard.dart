import 'package:flutter/material.dart';

import 'constant.dart';

class SpecificCard extends StatelessWidget {
  final String name1;
  final String name2;
  SpecificCard({this.name1,this.name2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            name1,
            style: BasicHeading,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            name2,
            style: SubHeading,
          ),
        ],
      ),
    );
  }
}
