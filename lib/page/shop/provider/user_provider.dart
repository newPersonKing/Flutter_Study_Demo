
import 'package:first_flutter_app/page/shop/model/user_entity.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {

  UserEntity _user;
  UserEntity get user => _user;
  
  void setUser(UserEntity user) {
    _user = user;
    notifyListeners();
  }
}