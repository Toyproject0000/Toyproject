import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WritingSettingProvider extends ChangeNotifier {

  String disclosure;
  bool enableComments;
  bool likeNumber;

  List<String> disclosureList = ['모두 공개', '독자만 공개', '비공개'];

  WritingSettingProvider({
    required this.disclosure,
    required this.enableComments,
    required this.likeNumber
  });

  void selectDisclosure(String selectdisclosure) {
    disclosure = selectdisclosure;
    notifyListeners();
  }

  void commentActivationState(bool state){
    enableComments = state;
    notifyListeners();
  }

  void selectlikeNumber(bool state){
    likeNumber = state;
    notifyListeners();
  }
}