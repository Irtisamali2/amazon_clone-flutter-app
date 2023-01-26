import 'package:amazon_clone_tutorial/Models/user.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier{
  User _user =User(id: '', 
  name: '', 
  email: '', 
  password: '', 
  address: '', 
  type: '', 
  token: '',
  cart: []);

  User get user => _user;

  void setUSer(String user){
    _user = User.fromJson(user);
    notifyListeners();
  }
  void setUserFromModel(User user){
    _user= user;
    notifyListeners();
  }
}