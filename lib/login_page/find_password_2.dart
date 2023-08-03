import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../server/Server.dart';

class NewPassWord extends StatefulWidget {
  const NewPassWord({super.key});

  static const routeName = '/newPassword';

  @override
  State<NewPassWord> createState() => _NewPassWordState();
}

class _NewPassWordState extends State<NewPassWord> {
  String newPassword = '';
  String newPasswordCheck = '';
  late String userEmail;

  Text explanationColumn = Text(
    '비밀번호는 영문, 특수문자, 숫자를 적절히 섞어 8자리 이상으로 작성해주세요.',
    style: TextStyle(fontSize: 14, color: Colors.grey),
  );

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();

  void sendNewPassword() {
    newPassword = newPasswordController.text;
    newPasswordCheck = checkPasswordController.text;

    if (newPassword.length >= 8 &&
        newPassword == newPasswordCheck &&
        newPassword.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) &&
        newPassword.contains(RegExp(r'[0-9]'))) {
      // 이쪽에서 데이터 보내기
      final data = {
        'id': userEmail,
        'password': newPasswordCheck,
      };
      final passwordServer = FindPasswordServer();
      passwordServer.setupPassword(data, context);
    } else if (newPassword != newPasswordCheck) {
      checkPasswordController.clear();
      setState(() {
        explanationColumn = Text(
          '비밀번호가 맞지 않습니다. 비밀번호를 다시 한번 확인해주세요.',
          style: TextStyle(color: Colors.red, fontSize: 14),
        );
      });
    } else if (!newPassword.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ||
        !newPassword.contains(RegExp(r'[0-9]'))) {
      setState(() {
        explanationColumn = Text(
          '비밀번호 형식은 특수문자와 영문, 숫자를 적절히 섞어서 8글자 이상으로 적어주세요',
          style: TextStyle(color: Colors.red, fontSize: 14),
        );
      });
    } else {
      setState(() {
        explanationColumn = Text(
          '비밀번호 형식은 특수문자와 영문, 숫자를 적절히 섞어서 8글자 이상으로 적어주세요',
          style: TextStyle(color: Colors.red, fontSize: 14),
        );
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as EmailArgument;
    userEmail = args.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          '비밀번호 재설정',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '새로운 비밀번호를 입력해 주세요',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  TextFormField(
                    obscureText: true,
                    controller: newPasswordController,
                    decoration: InputDecoration(
                      hintText: '새로운 비밀번호를 입력하시오',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: checkPasswordController,
                    decoration: InputDecoration(
                      hintText: '비밀번호 확인',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  explanationColumn,
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  '비밀번호 변경',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  sendNewPassword();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue, onPrimary: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailArgument {
  final String email;

  EmailArgument(this.email);
}
