import 'package:car_bike_rental/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference carCollection= Firestore.instance.collection('carlist');

  Future updateUserData(String imgurl,String title,double price,String location,int seats,int doors,String fuel,String brand,String userEmail) async {
    return await carCollection.document(uid).setData({
      'imgurl':imgurl,
      'title':title,
      'price':price,
      'location':location,
      'seats':seats,
      'doors':doors,
      'fuel':fuel,
      'brand':brand,
      'userEmail':userEmail,
    });
  }

  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) {
    return Firestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .getDocuments();
  }
  getUserInfoByUsername(String username){
    return Firestore.instance
        .collection("users")
        .where("userName", isEqualTo: username)
        .getDocuments();
  }
  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addMessage(String chatRoomId, chatMessageData){

    Firestore.instance.collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
      print(e.toString());
    });
  }

  getConversationMessages(chatRoomId)async{
    return await Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time")
        .snapshots();
  }

  getChatRooms(String itIsMyName) async {
    return await Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
/*
  List<CarItem> _brewListFromSnapshot(QuerySnapshot snapshot){
      return snapshot.documents.map((doc){
        return CarItem(
          title: doc.data['title'] ?? '',
          price: doc.data['price'] ?? 0,
          path: doc.data['sugars'] ?? '0',
          seats: doc.data['seats']??0,
          doors: doc.data['doors']??0,
          fuel: doc.data['fuel']??'0',
          brand: doc.data['brand']??'0',
        );
      }).toList();
  }*/

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
      return UserData(
        uid: uid,
        title: snapshot.data['name'],
        price: snapshot.data['price '],
        path: snapshot.data['path'],
        seats: snapshot.data['seats'],
        doors: snapshot.data['doors'],
        fuel: snapshot.data['fuel'],
        brand: snapshot.data['brand'],

      );
  }

 /* Stream<List<CarItem>> get carslist{
    return carCollection.snapshots()
    .map(_brewListFromSnapshot);
  }*/

  Stream<UserData> get userData {
    return carCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}