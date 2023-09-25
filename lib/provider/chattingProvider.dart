import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class ChattingProvider extends ChangeNotifier {

  Widget chattingContent = Center(child: CircularProgressIndicator(color: Colors.blue),);
  List chattingContents = [];

  void upDataContent(sendUser, accpetUser) async {
    final data =  {
      'token' : jwtToken,
      'sendUser' : sendUser,
      'acceptUser' : accpetUser
    };
    final List respose = await ServerResponseJsonDataTemplate('/message/user' ,data);
    chattingContents = respose.reversed.toList();
    
    notifyListeners();
  }

  

}