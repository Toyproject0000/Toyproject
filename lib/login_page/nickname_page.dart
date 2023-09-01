import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/myButton.dart';
import 'package:smart_dongne/component/my_Text_Form_Field.dart';
import 'package:smart_dongne/server/chatServer.dart';

class NickNameField extends StatefulWidget {
  const NickNameField({super.key});
  static const routeName = '/nickname';

  @override
  State<NickNameField> createState() => _NickNameFieldState();
}

class _NickNameFieldState extends State<NickNameField> {
  TextEditingController nicknameController = TextEditingController();
  late final dynamic args;

  bool responseError = false;


  void duplicateCheck() async {
    final data = {
      'id' : args.email,
      'nickname' : nicknameController.text
    };
    final response = await ServerResponseOKTemplate('/nickname', data);
    if(response != null){

    }else {
      setState(() {
        responseError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as JoinArgument;
    return Scaffold(
      appBar: AppBar(
        title: Text('닉네임 설정', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
        child: Column(
          children: [
            MyTextFormField(
                controller: nicknameController,
                hintText: '닉네임 입력',
                obscureText: false),
            SizedBox(height: 10,),
            if(responseError)
            Column(
              children: [
                Text('이미 사용 중인 닉네임 입니다.', style: TextStyle(color: Colors.red),),
                SizedBox(height: 10,),
              ],
            ),
            MyButton(
              text: '확인',
              onPresse: duplicateCheck
            ),
          ],
        ),
      ),
    );
  }
}

class JoinArgument {
  final String email;
  final String password;
  final String name;
  final String phonenumber;
  final bool gender;

  JoinArgument(
      {required this.email,
      required this.password,
      required this.name,
      required this.phonenumber,
      required this.gender});
}
