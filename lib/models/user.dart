class User{

  final String uid;

  User({this.uid});
}

class UserData {
  final String title,uid;
  final double price;
  final String path;
  final int seats;
  final int doors;
  final String fuel;
  final String brand;

  UserData({this.uid,this.title,this.price,this.path,this.seats,this.doors,this.fuel,this.brand});

}