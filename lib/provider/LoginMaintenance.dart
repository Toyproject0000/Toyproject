import 'package:flutter/cupertino.dart';

class LoginMaintenance extends ChangeNotifier {

  bool loginMaintenance = false;

  void loginMaintenanceOnpress(){
    loginMaintenance = !loginMaintenance;
    notifyListeners();
  }
}