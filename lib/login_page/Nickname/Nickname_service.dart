import 'package:flutter/cupertino.dart';
import 'package:smart_dongne/server/chatServer.dart';

class NickNameService extends ChangeNotifier {
  final String nickname;
  final String userID;

  NickNameService({required this.userID ,required this.nickname});

  void deplicateCheck() async {
    final data = {'id' : userID, 'nickname' : nickname};
    final response = await ServerResponseOKTemplate('/nickname', data);
    print(response);
  }
}