import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/chatting_page/ChatBubbleWidget.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class ChattingProvider extends ChangeNotifier {

  Widget chattingContent = Center(child: CircularProgressIndicator(color: Colors.blue),);

  void upDataContent(sendUser, accpetUser) async {
    final data =  {
      'token' : jwtToken,
      'sendUser' : sendUser,
      'acceptUser' : accpetUser
    };
    final List response = await ServerResponseJsonDataTemplate('/message/user' ,data);
    print(response);
    final List<Widget> MessageList = response.map<Widget>((data) => ChatBubbleWidget(acceptUser: accpetUser, jsonData: data,)).toList();
    chattingContent =  ListView(
      keyboardDismissBehavior : ScrollViewKeyboardDismissBehavior.onDrag,
      reverse: true, children : MessageList);
    
    notifyListeners();
  }

  

}