import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/server/Server.dart';

class UserWithDrawal extends StatefulWidget {
  const UserWithDrawal({super.key});
  static const rotueName = '/userSetting/accountManagement/withdrawal';

  @override
  State<UserWithDrawal> createState() => _UserWithDrawalState();
}

class _UserWithDrawalState extends State<UserWithDrawal> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool errorData = false;
  final Text ErrorMessage = Text('아이디 혹은 비밀번호가 틀렸습니다. 정보를 다시 입력해주세요.',
      style: TextStyle(color: Colors.red));

  void sendDataServer() {
    final data = {
      'id': idController.text,
      'password': passwordController.text,
    };

    final accountRemove = AccountRemove(data);
    if (accountRemove != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '회원 탈퇴 완료',
              style: TextStyle(color: Colors.black, fontSize: 25),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.spaceAround, // 액션 버튼 정렬 방식 설정
          );
        },
      );
    } else {
      setState(() {
        errorData = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('계장 탈퇴'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              controller: idController,
              decoration: InputDecoration(
                hintText: '아이디를 입력하시오.',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              ),
            ),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: '비밀번호를 입력하시오.',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            errorData == false
                ? Text(
                    '계정을 삭제하시면 한달 동안 같은 이메일로 가입할 수 없습니다.',
                    style: TextStyle(color: Colors.grey),
                  )
                : ErrorMessage,
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                sendDataServer();
              },
              child: Text(
                '탈퇴하기',
                style: TextStyle(color: Colors.grey),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
