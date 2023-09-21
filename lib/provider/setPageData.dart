import 'package:flutter/cupertino.dart';
import 'package:smart_dongne/main_page/chatting_page/chatting.dart';
import 'package:smart_dongne/main_page/home_page/home_page.dart';
import 'package:smart_dongne/main_page/profile_page/profile.dart';
import 'package:smart_dongne/main_page/writing_page/writing_page.dart';

class SetPageProvider extends ChangeNotifier {

  int currentIndex = 0;


  List<Widget> screens = [
    HomePage(),
    WritingPage(contents: null, postsId: null),
    Chatting(),
    ProfilePage(),
  ];

  void ChangeScreen(int index) {
    currentIndex = index;
    notifyListeners();
  }

}