import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
              Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  enabled: true,
                  child: Column(
                    children: [0,1,2,3,4,5,6,7,8,10,11].map((_) =>  Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        height: 160,
                        margin: EdgeInsets.only(top:15,bottom:15),
                        //decoration: BoxDecoration(color: Theme.of(context).primaryColor,),

                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(color: Theme.of(context).primaryColor,),
                              height: 160,width: 160,
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(height: 15,decoration: BoxDecoration(color: Theme.of(context).primaryColor,),),
                                  SizedBox(height: 10,),
                                  Container(height: 10,decoration: BoxDecoration(color: Theme.of(context).primaryColor,),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )).toList(),
                  )
                  ),
        ],
      ),
    );
  }
}

