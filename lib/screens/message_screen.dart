import 'package:car_bike_rental/screens/conversation.dart';
import 'package:car_bike_rental/services/auth.dart';
import 'package:car_bike_rental/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  DatabaseService databaseService=DatabaseService();
  FirebaseUser user;
  AuthService _auth=AuthService();
  QuerySnapshot resultsnapshot;
  String currentUserName='',currentName='';
  Stream chatroomStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatroomStream,
      builder: (context,snapshot){
        return snapshot.hasData? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index){
              return ChatRoomTile(snapshot.data.documents[index].data["chatRoomId"].toString()
              .replaceAll(currentUserName, "").replaceAll("_", ""),
                  snapshot.data.documents[index].data["chatRoomId"],
                currentUserName
              );
            }
        ):Container();
      },
    );
  }

  @override
  void initState() {
    initUser();
    super.initState();
  }

  initUser() async {
    user = await _auth.getCurrentUserEmail();

    await databaseService.getUserInfo(user.email).then((snapshot) {
      resultsnapshot = snapshot;
      setState(() {
        currentName=resultsnapshot.documents[0].data["name"];
        currentUserName=resultsnapshot.documents[0].data["userName"];
      });
    });

    databaseService.getChatRooms(currentUserName).then((snapshot){
      setState(() {
        chatroomStream=snapshot;
      });
    });
    print(currentUserName);
    print(resultsnapshot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Messages'),),
      body: Container(
        child: chatRoomList(),
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String UserName;
  final String ChatRoomId;
  final String CurrentUserName;
  ChatRoomTile(this.UserName,this.ChatRoomId,this.CurrentUserName);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Conversation(chatRoomId: ChatRoomId,currentUserName: CurrentUserName,)));
      },
      child: Container(
        color: Colors.grey,
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(40)
              ),

              child: Text(UserName.substring(0,1).toUpperCase()),
            ),
            SizedBox(width: 8,),
            Text(UserName,style: TextStyle(fontSize: 17),)
          ],
        ),
      ),
    );
  }
}
