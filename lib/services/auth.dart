import 'package:car_bike_rental/models/user.dart';
import 'package:car_bike_rental/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth  _auth = FirebaseAuth.instance;
  //sign in anon

  User _userFromFirebaseUser(FirebaseUser user)
  {
    return user !=null ? User(uid: user.uid):null;
  }
  Stream<User> get user{
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map((_userFromFirebaseUser));
  }

   Future getCurrentUserEmail()async{
    FirebaseUser user= await _auth.currentUser();
    return user;
  }

  Future signInAnon() async {
     try{
       AuthResult result = await _auth.signInAnonymously();
       FirebaseUser user = result.user;
       return _userFromFirebaseUser(user);
     } catch(e){
        print(e.toString());
        return null;
     }
  }
  //sign in with email password
  Future signInWithEmailAndPassword(String email,String password) async{
    try{

      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user =result.user;

      //await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
      //return _userFromFirebaseUser(user);
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register email password

  Future registerWithEmailAndPassword(String email,String password) async{
    try{
        AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        FirebaseUser user =result.user;
        //await DatabaseService(uid: user.uid).updateUserData('new car',100, 'pune',4,4,'diesel','bmw');
        return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //signout

  Future signOut() async{
   try{
        return await _auth.signOut();
   }
   catch(e){
      print(e.toString());
      return null;
   }
  }
}