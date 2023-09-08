import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/myButton.dart';
import 'package:smart_dongne/component/my_Text_Form_Field.dart';
import 'package:smart_dongne/login_page/login_page.dart';
import 'package:smart_dongne/server/Server.dart';

class NickNameField extends StatefulWidget {
  const NickNameField({super.key});
  static const routeName = '/nickname';

  @override
  State<NickNameField> createState() => _NickNameFieldState();
}

class _NickNameFieldState extends State<NickNameField> {
  TextEditingController nicknameController = TextEditingController();
  late Map<String, dynamic> SignUpdata;
  bool responseError = false;

  void SignUp() async {
    SignUpdata['nickname'] = nicknameController.text;
    print(SignUpdata);
    final response = await ServerResponseOKTemplate('/join', SignUpdata);
    if(response != null){
      Navigator.popUntil(context, ModalRoute.withName(LoginScreen.routeName));
    }
  }

  void duplicateResponse(Text content, Widget? onTap) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: content,
            actions: onTap == null ? null : [onTap],
          );
        });
  }

  void duplicateCheck() async {
    final data = {'id': SignUpdata['email'], 'nickname': nicknameController.text};
    final response = await ServerResponseOKTemplate('/nickname', data);
    if (response != null) {
      duplicateResponse(
          Text(
            '닉네임을 ${nicknameController.text} 로 설정하시겠습니까?',
            style: TextStyle(color: Colors.black),
          ),
          TextButton(onPressed: (){
            SignUp();
          }, child: Text('확인', style: TextStyle(color: Colors.blue),)));
    } else {
      duplicateResponse(
          Text(
            '해당 닉네임은 이미 존재하는 닉네임 입니다.',
            style: TextStyle(color: Colors.red),
          ),
          null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as JoinArgument;
    SignUpdata = args.data;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '닉네임 설정',
          style: TextStyle(color: Colors.black),
        ),
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
            SizedBox(
              height: 10,
            ),
            if (responseError)
              Column(
                children: [
                  Text(
                    '이미 사용 중인 닉네임 입니다.',
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            MyButton(text: '확인', onPresse: duplicateCheck),
          ],
        ),
      ),
    );
  }
}

class JoinArgument {

  final Map<String, dynamic> data;

  JoinArgument(this.data);
}
