import 'package:b16_api/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  UserModel _model = UserModel();

  void setUser(UserModel val) {
    _model = val;
    notifyListeners();
  }

  UserModel getUser() => _model;
}
