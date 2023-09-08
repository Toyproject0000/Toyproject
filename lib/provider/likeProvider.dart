import 'package:flutter/cupertino.dart';

class LikeProvider extends ChangeNotifier {
  
  bool likeState = false;

  void changeLike(){
    likeState = !likeState;
    notifyListeners();
  }
}