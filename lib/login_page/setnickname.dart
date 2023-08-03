import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/setpage.dart';
import 'package:http/http.dart' as http;
import 'package:smart_dongne/server/Server.dart';

class NickName extends StatefulWidget {
  const NickName({Key? key}) : super(key: key);
  static const routeName = '/nickname';

  @override
  State<NickName> createState() => _NickNameState();
}

class _NickNameState extends State<NickName> {
  String nickName = '';
  final _formKey = GlobalKey<FormState>();
  bool setable = false;
  TextEditingController nickNameController = TextEditingController();
  bool? nickNameError;
  String? userEmail;

  // 닉네임 중복 확인
  Text firstMessage = Text(
    '닉네임은 중복될 수 없으며 2글자 이상 작성해주세요',
    style: TextStyle(color: Colors.grey, fontSize: 13),
  );
  Text RedumdancyMessage = Text(
    '이미 사용중인 닉네임 입니다.',
    style: TextStyle(color: Colors.red, fontSize: 13),
  );
  Text successMessage = Text(
    '사용가능한 닉네임 입니다.',
    style: TextStyle(color: Colors.green, fontSize: 13),
  );
  String? userNickName;

  void sendDataJoinServer() {
    if (nickNameError == false) {
      if (userNickName == nickNameController.text) {
        final data = {'id': userEmail,'nickname': userNickName};

        final jsonData= nickNameSetUp(data);
        if(jsonData == 'ok'){
          Navigator.pushNamed(context, SetPage.routeName);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          content: Text('중복확인을 해주세요.'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text('닉네임을 입력하시오'),
      ));
    }
  }

  void checkNickName() async {
    final args = await ModalRoute.of(context)!.settings.arguments as ArgumentEmail;
    userEmail = args.userEmail;
    final data = {'id': userEmail, 'nickname': nickNameController.text};

    final checkData = checkNickNameServer(data);
    if (checkData != null) {
      setState(() {
        nickNameError = false;
        userNickName = nickNameController.text;
      });
    } else {
      setState(() {
        nickNameError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('닉네임 설정'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  checkNickName();
                },
                child: Text(
                  '중복확인',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: nickNameController,
                  decoration: InputDecoration(
                    hintText: '닉네임 설정',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey, // 하단 테두리 색상을 grey로 설정
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          
          nickNameError == true
              ? RedumdancyMessage
              : nickNameError == null
                  ? firstMessage
                  : successMessage,
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  sendDataJoinServer();
                },
                child: Text(
                  '설정',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(3), // 테두리를 둥글게 하려면 원하는 값으로 변경
                  ),
                  primary: Colors.blue, // 배경색을 파란색으로 변경
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class ArgumentEmail {
  final String userEmail;

  ArgumentEmail(this.userEmail);
}
