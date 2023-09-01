import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/authentication_TextFormfield.dart';

class FindPassword extends StatefulWidget {
  const FindPassword({super.key});
  static const routeName = '/finaPassword';


  @override
  State<FindPassword> createState() => _FindPasswordState();
}

class _FindPasswordState extends State<FindPassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController authenticationNumberController = TextEditingController();
  
  void requestAuthenticationCheck(){

  }

  void requsetAuthenticationNumber(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text('비밀번호 찾기'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            AuthenticationTextFormField(
              controller: emailController,
              hintText: '이메일',
              requestMethod: '인증번호 요청',
              sendData: requsetAuthenticationNumber,
      
            ),
            SizedBox(height: 10,),
            AuthenticationTextFormField(
              controller: authenticationNumberController,
              hintText: '인증번호',
              requestMethod: '인증번호 확인',
              sendData: requestAuthenticationCheck,
      
            ),
          ],
        ),
      ),
    );
  }
}