import 'package:car_bike_rental/services/database.dart';
import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  final String chatRoomId;
  final String currentUserName;
  Conversation({this.chatRoomId,this.currentUserName});


  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  TextEditingController messagecontroller=TextEditingController();
  DatabaseService databaseService=DatabaseService();
  Stream chatMessagesStream;

  Widget chatMessageList(){
      return  StreamBuilder(
        stream: chatMessagesStream,
        builder: (context,snapshot){
          return snapshot.hasData? ListView.builder(
            itemCount: snapshot.data.documents.length,
              itemBuilder: (context,index){
              return  MessageTile(snapshot.data.documents[index].data["message"],snapshot.data.documents[index].data["sendBy"]==widget.currentUserName);
              }
          ):Container();
        },
      );
  }

  sendMessage(){
    if(messagecontroller.text.isNotEmpty){
      Map<String,dynamic> messageMap={
        "message":messagecontroller.text,
        "sendBy":widget.currentUserName,
        "time":DateTime.now().millisecondsSinceEpoch,
      };
      databaseService.addMessage(widget.chatRoomId, messageMap);
      messagecontroller.text="";
    }
  }

  @override
  void initState() {
    databaseService.getConversationMessages(widget.chatRoomId).then((val){
        setState(() {
          chatMessagesStream=val;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Conversation'),),
      body: Container(
        child: Stack(
          children: [
            chatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Container(

                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Expanded(

                        child: TextField(
                          controller: messagecontroller,


                          decoration: InputDecoration(
                              hintText: "Message ...",
                              fillColor: Colors.grey,
                              focusColor: Colors.grey,
                              hintStyle: TextStyle(
                                //color: Colors.white,
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)
                          ),

                        )),


                    SizedBox(width: 16,),
                    RawMaterialButton(
                      onPressed: () {
                        sendMessage();
                      },
                      elevation: 2.0,
                      fillColor: Colors.blueAccent,
                      child: Icon(
                        Icons.send,
                        size: 25.0,

                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class MessageTile extends StatelessWidget {
  final String message;
  final bool issendByme;
  MessageTile(this.message,this.issendByme);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.only(left: issendByme?0:24,right: issendByme?24:0),
      width: MediaQuery.of(context).size.width,
      alignment:issendByme?Alignment.centerRight:Alignment.centerLeft ,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        decoration: BoxDecoration(color: issendByme?Colors.blueAccent : Colors.grey,
          borderRadius: issendByme?BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomLeft: Radius.circular(23),
          ):BorderRadius.only(
              topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23),
            )

        ),
        child: Text(message,style: TextStyle(fontSize: 17,color: Colors.white),),
      ),
    );
  }
}
