import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:smart_dongne/component/authentication_TextFormfield.dart';
import 'package:smart_dongne/component/genderButton.dart';
import 'package:smart_dongne/component/myButton.dart';
import 'package:smart_dongne/component/my_Text_Form_Field.dart';
import 'package:smart_dongne/component/myselfWidget.dart';
import 'package:smart_dongne/login_page/nickname_page.dart';
import 'package:smart_dongne/server/Server.dart';


class Joinmembership extends StatefulWidget {
  const Joinmembership({Key? key}) : super(key: key);

  static const routeName = '/join';

  @override
  State<Joinmembership> createState() => _JoinmembershipState();
}

class _JoinmembershipState extends State<Joinmembership> {
  TextEditingController textController = TextEditingController();
  bool authenticationSuccessful = false;
  bool successfulidentification = false;

  // textEditingController
  TextEditingController emailController = TextEditingController();
  TextEditingController authenticationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
  TextEditingController userbirthdayController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  
  String userEmail = '';
  String userNicName = '';

  String? authenticationNumber;
  String? perfectPassWord;
  bool? manButton;

  void _tryValidation() async {
    // if (successfulidentification) {
      if (passWordCheck()) {
        if (MySelfInformationCheck()) {
          // birthday create a type 
          String birthdayType = userbirthdayController.text.substring(0, 4) + '-' + userbirthdayController.text.substring(4, 6) + '-' + userbirthdayController.text.substring(6, 8);
          final data = {
            'id' : userEmail,
            'password' : passwordCheckController.text,
            'name' : userNameController.text,
            'gender' : manButton,
            'phoneNumber' : userPhoneNumberController.text,
            'birth' : birthdayType,
            'root' : 'local'
          };
          Navigator.pushNamed(context, NickNameField.routeName,
            arguments: JoinArgument(data),
          );
        }
      }
    // } else {
    //   Flushbar(
    //     margin: EdgeInsets.symmetric(horizontal: 15),
    //     flushbarPosition: FlushbarPosition.TOP,
    //     duration: Duration(seconds: 2),
    //     message: '본인인증을 하시오.',
    //     messageSize: 15,
    //     borderRadius: BorderRadius.circular(4),
    //     backgroundColor: Colors.white,
    //     messageColor: Colors.black,
    //     boxShadows: [BoxShadow(color: Colors.black, blurRadius: 8)],
    //   ).show(context);
    // }
  }

  void _emailValidation() async {
    final email = {'id': emailController.text};
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 15),
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 2),
      message: '해당 이메일로 인증번호를 보냈습니다.',
      messageSize: 15,
      borderRadius: BorderRadius.circular(4),
      backgroundColor: Colors.white,
      messageColor: Colors.black,
      boxShadows: [BoxShadow(color: Colors.black, blurRadius: 8)],
    ).show(context);
    await ServerResponseOKTemplate('/authentication', email);
    userEmail = emailController.text;
  }

  bool MySelfInformationCheck() {
    if (userNameController.text.isNotEmpty &&
        userPhoneNumberController.text.length == 11 &&
        userbirthdayController.text.length == 8) {
      return true;
    } else {
      Flushbar(
        margin: EdgeInsets.symmetric(horizontal: 15),
        flushbarPosition: FlushbarPosition.TOP,
        duration: Duration(seconds: 2),
        message: '본인정보를 정확히 입력해주세요.',
        messageSize: 15,
        borderRadius: BorderRadius.circular(4),
        backgroundColor: Colors.white,
        messageColor: Colors.black,
        boxShadows: [BoxShadow(color: Colors.black, blurRadius: 8)],
      ).show(context);
      return false;
    }
  }

  void ChangeGender(bool man){
    manButton = man;
  }

  void authenticationCheck() async {
    final data = {'id': userEmail, 'num': authenticationController.text};
    final response =
        await ServerResponseOKTemplate('/authentication-check', data);
    if (response != null) {
      userEmail = emailController.text;
      setState(() {
        authenticationSuccessful = true;
        successfulidentification = true;
      });
    } else {
      Flushbar(
        margin: EdgeInsets.symmetric(horizontal: 15),
        flushbarPosition: FlushbarPosition.TOP,
        duration: Duration(seconds: 2),
        message: '인증번호가 올바르지 않습니다..',
        messageSize: 15,
        borderRadius: BorderRadius.circular(4),
        backgroundColor: Colors.white,
        messageColor: Colors.black,
        boxShadows: [BoxShadow(color: Colors.black, blurRadius: 8)],
      ).show(context);
    }
  }

  bool passWordCheck() {
    if (passwordCheckController.text == passwordController.text) {
      return true;
    } else {
      Flushbar(
        margin: EdgeInsets.symmetric(horizontal: 15),
        flushbarPosition: FlushbarPosition.TOP,
        duration: Duration(seconds: 2),
        message: '비밀번호가 일치하지 않습니다.',
        messageSize: 15,
        borderRadius: BorderRadius.circular(4),
        backgroundColor: Colors.white,
        messageColor: Colors.black,
        boxShadows: [BoxShadow(color: Colors.black, blurRadius: 8)],
      ).show(context);
      passwordCheckController.clear();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '회원가입',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                AuthenticationTextFormField(
                    hintText: '이메일',
                    requestMethod: '인증번호 요청',
                    controller: emailController,
                    sendData: _emailValidation),
                SizedBox(
                  height: 5,
                ),
                AuthenticationTextFormField(
                  hintText: '인증번호',
                  requestMethod: '인증번호 확인',
                  controller: authenticationController,
                  sendData: authenticationCheck,
                ),
                if (authenticationSuccessful == true)
                  Text(
                    '인증번호가 맞습니다.',
                    style: TextStyle(color: Colors.green),
                  ),
                SizedBox(
                  height: 3,
                ),

                MyTextFormField(
                    controller: passwordController,
                    hintText: '비밀번호',
                    obscureText: true),
                SizedBox(
                  height: 3,
                ),
                MyTextFormField(
                    controller: passwordCheckController,
                    hintText: '비밀번호 체크',
                    obscureText: true),

                SizedBox(
                  height: 33,
                ),
                // myself information
                MySelfWidget(
                    nameController: userNameController,
                    phoneNumberController: userPhoneNumberController,
                    birthdayController: userbirthdayController),

                MyGenderButton(ChangeGender: ChangeGender, currentGender: null,),
                SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: '회원 가입하기',
                  onPresse: _tryValidation
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}