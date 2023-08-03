import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/server/Server.dart';

class ChangePhoneNumber extends StatefulWidget {
  const ChangePhoneNumber({super.key});

  static const routeName = '/ChangePhoneNumber';

  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  TextEditingController newNumberController = TextEditingController();
  TextEditingController authenticationNumber = TextEditingController();
  String? encryptionNumber;
  String authenticationdata = '';
  FocusNode _focusNode = FocusNode();
  bool sendError = false;

  Padding errorText = Padding(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
    child: Text(
      '인증번호가 맞지 않습니다. 다시 입력해주세요.',
      style: TextStyle(color: Colors.red),
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  void sendAuthenticationNumber() {
    final data = {'phoneNumber': newNumberController.text};
    final checkNumber = numberAuthentiaction();
    checkNumber.sendPhoneNumber(data).then((value) {
      setState(() {
        encryptionNumber = checkNumber.AuthenticationNumber!;
      });
      Flushbar(
        margin: EdgeInsets.symmetric(horizontal: 15),
        flushbarPosition: FlushbarPosition.TOP,
        duration: Duration(seconds: 2),
        message: '인증번호를 전송했습니다',
        messageSize: 15,
        borderRadius: BorderRadius.circular(4),
        backgroundColor: Colors.white,
        messageColor: Colors.black,
        boxShadows: [BoxShadow(color: Colors.black, blurRadius: 8)],
      ).show(context);
    });
  }

  void CheckAuthenticationNumber() async {
    if (encryptionNumber != null) {
      final data = {
        'rawNum': authenticationNumber.text,
        'num': encryptionNumber
      };
      final jsonData = await authenticationNumberCheck(data);
      if (jsonData != null) {
        Navigator.pop(context);
      } else {
        authenticationNumber.clear();
        setState(() {
          sendError = true;
        });
      }
    } else {
      Flushbar(
        margin: EdgeInsets.symmetric(horizontal: 15),
        flushbarPosition: FlushbarPosition.TOP,
        duration: Duration(seconds: 2),
        message: '올바른 인증번호를 입력하세요.',
        messageSize: 15,
        borderRadius: BorderRadius.circular(4),
        backgroundColor: Colors.white,
        messageColor: Colors.black,
        boxShadows: [BoxShadow(color: Colors.black, blurRadius: 8)],
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('전화번호 변경'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: Colors.blue,
                      controller: newNumberController,
                      decoration: InputDecoration(
                          hintText: '새로운 번호를 입력하시오',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        sendAuthenticationNumber();
                        FocusScope.of(context).requestFocus(_focusNode);
                      },
                      child: Text(
                        '인증번호 요청',
                        style: TextStyle(color: Colors.blue),
                        
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              focusNode: _focusNode,
              cursorColor: Colors.blue,
              controller: authenticationNumber,
              decoration: InputDecoration(
                hintText: '입증번호를 입력하시오',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if(sendError == true)
            errorText,
            ElevatedButton(
              onPressed: () {
                CheckAuthenticationNumber();
              },
              child: Text(
                '변경하기',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
