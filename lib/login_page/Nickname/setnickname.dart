import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/authentication_TextFormfield.dart';
import 'package:smart_dongne/component/myButton.dart';
import 'package:smart_dongne/server/chatServer.dart';
import 'package:smart_dongne/server/userId.dart';

class NickNameSet extends StatefulWidget {
  const NickNameSet({super.key});

  static const routeName = '/nickname';
  @override
  State<NickNameSet> createState() => _NickNameSetState();
}

class _NickNameSetState extends State<NickNameSet> {
  String response = '';
  // user TextFormField Controller 
  TextEditingController _controller = TextEditingController();
  
  void onTap() async {
    if(_controller.text.isNotEmpty){
      final data = {'id' : globalUserId, 'nickname' : _controller.text};
      response = await ServerResponseOKTemplate('/nickname', data) as String;
      print(response);

    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthenticationTextFormField(
              controller: _controller,
              hintText: 'Enter your nickname..',
              requestMethod: '중복 확인',
              sendData: onTap,
            ),
            SizedBox(height: 5,),
            SizedBox(height: 5,),
            MyButton(text: '확인',)
          ],
        ),
      ),
    );
  }
}