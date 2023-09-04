import 'package:flutter/cupertino.dart';

class JoinArgeement extends ChangeNotifier {

  bool AllargeeMent = false;
  bool termsargeement = false;
  bool personalinformaitionArgeement = false;

  void onPresstermsargeement(){
    termsargeement = !termsargeement;
    if(termsargeement == true && personalinformaitionArgeement == true){
      AllargeeMent = true;
    }else {
      AllargeeMent = false;
    }
    notifyListeners();
  }

  void onPresspersonalinformaitionArgeement() {
    personalinformaitionArgeement = !personalinformaitionArgeement;
    if(termsargeement == true && personalinformaitionArgeement == true){
      AllargeeMent = true;
    }else {
      AllargeeMent = false;
    }
    notifyListeners();
  }

  void onPresseAllargeeMent(){
    AllargeeMent = !AllargeeMent;
    termsargeement = AllargeeMent;
    personalinformaitionArgeement = AllargeeMent;
    notifyListeners();
  }
}