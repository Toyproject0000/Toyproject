import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/login_page/find_password_2.dart';
import 'package:another_flushbar/flushbar.dart';

import '../server/Server.dart';

class FindPassword extends StatefulWidget {
  const FindPassword({Key? key}) : super(key: key);
  static const routeName = '/findpassword';

  @override
  State<FindPassword> createState() => _FindPasswordState();
}

class _FindPasswordState extends State<FindPassword> {
  bool iDpass = false;

  final _formkey = GlobalKey<FormState>();
  String userEmail = '';
  final _formKey2 = GlobalKey<FormState>();
  final _numberKey = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();

  //cancel Button
  bool emailCancel = false;
  bool userNameCancel = false;
  bool authenticationNumberCancel = false;

  // Server로 보내는 값들
  String userAuthticationNumber = '';
  String userName = '';
  String userNumber = '';
  String encryption = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController authenticationController = TextEditingController();

  bool emailError = false;
  bool userCheckError = false;

  void changeScreen() {
    setState(() {
      iDpass = true;
    });
  }

  void _tryValidation() async {
    final isValid = _formkey.currentState!.validate();

    _formkey.currentState!.save();
    var data = {'id': userEmail};

    FindPasswordServer server = FindPasswordServer();
    final jsonData = await server.sendEmail(data, changeScreen);
    if (jsonData == null) {
      setState(() {
        emailError = true;
      });
    }
  }

  void _tryValidationOfname() async {
    _formKey2.currentState!.save();
    var data = {'name': userName, 'phoneNumber': userNumber, 'id': userEmail};
    var authenticationData = {
      'rawNum': userAuthticationNumber,
      'num': encryption
    };

    FindPasswordServer server = FindPasswordServer();

    final checkJsonData = await server.checkdata(data);
    final authenticationJsonData =
        await authenticationNumberCheck(authenticationData);

    // null 을 통해 위쪽으로 스낵바

    if (checkJsonData == null || authenticationJsonData == null) {
      setState(() {
        userCheckError = true;
      });
    } else if (checkJsonData != null && authenticationJsonData != null) {
      Navigator.pushNamed(context, NewPassWord.routeName, arguments: EmailArgument(userEmail));
    }
  }
      
  void authenticationNumber() {
    final isValid = _numberKey.currentState!.validate();
    if (isValid) {
      _numberKey.currentState!.save();
      var data = {'phoneNumber': userNumber};
      final authentication = numberAuthentiaction();
      authentication.sendPhoneNumber(data).then((value) {
        encryption = authentication.AuthenticationNumber!;
        // authenticaiton transform
        Flushbar(
          margin: EdgeInsets.symmetric(horizontal: 15),
          flushbarPosition: FlushbarPosition.TOP,
          duration: Duration(seconds: 2),
          message: '인증번호를 전송했습니다.' ,
          messageSize: 15,
          borderRadius: BorderRadius.circular(4),
          backgroundColor: Colors.white,
          messageColor: Colors.black,
          boxShadows: [
            BoxShadow(color: Colors.black, blurRadius: 8)
          ],
        ).show(context);
      });
    }
  }
  
  void checkEmailTextCancelButton(text){
    if(text != ''){
      setState(() {
        emailCancel = true;
      });
    } else {
      setState(() {
        emailCancel = false;
      });
    }
  }

  void userNameTextCancelButton(text){
    if(text != ''){
      setState(() {
        userNameCancel = true;
      });
    } else {
      setState(() {
        emailCancel = false;
      });
    }
  }

  void authenticationTextCancelButton(text){
    if(text != ''){
      setState(() {
        authenticationNumberCancel = true;
      });
    } else {
      setState(() {
        authenticationNumberCancel = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            '비밀번호 찾기',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: iDpass == false
            ? GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Smart DongNe',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            '비밀번호를 찾고자하는 아이디를 입력해주세요',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4)
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: emailController,
                                  key: ValueKey(1),
                                  validator: (value) {
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userEmail = value!;
                                  },
                                  onChanged: (text){
                                    checkEmailTextCancelButton(text);
                                  },
                                  decoration: InputDecoration(

                                      focusedBorder: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.blue,
                                      ),
                                      border: InputBorder.none,
                                      hintText: '이메일'),
                                ),
                              ),
                              Visibility(
                                visible: emailCancel,
                                child: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: (){
                                    emailController.clear();
                                    setState(() {
                                      emailCancel = false;
                                    });
                                  },
                                )
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        if (emailError == true)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 7),
                            child: Text(
                              '입력하신 이메일이 정보가 틀렸습니다. 입력 하신 내용을 다시 확인해주세요',
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            ),
                          ),
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _tryValidation();
                          },
                          child: Text(
                            '다음',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: Size(double.infinity, 48),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height * 0.3,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2.0),
                ),
                child: Form(
                  key: _formKey2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1
                            )
                          )
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                onSaved: (value) {
                                  userName = value!;
                                },
                                onChanged: (text){
                                  userNameTextCancelButton(text);
                                },
                                controller: nameController,
                                decoration: InputDecoration(
                                    hintText: '이름을 입력하시오',
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                              ),
                            ),
                            Visibility(
                              visible: userNameCancel,
                              child: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: (){
                                  nameController.clear();
                                  setState(() {
                                    userNameCancel = false;
                                  });
                                },
                              )
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Form(
                                key: _numberKey,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: numberController,
                                  validator: (value) {
                                    if (value!.isEmpty || value.length > 11) {
                                      return '번호를 올바르게 입력하시오';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userNumber = value!;
                                  },
                                  decoration: InputDecoration(
                                      hintText: '전화번호를 입력하시오',
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1.0)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1.0))),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                authenticationNumber();
                                FocusScope.of(context).requestFocus(_focusNode);
                              },
                              child: Text(
                                '인증번호 전송',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1
                            )
                          )
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                focusNode: _focusNode,
                                keyboardType: TextInputType.number,
                                controller: authenticationController,
                                onSaved: (value) {
                                  userAuthticationNumber = value!;
                                },
                                onChanged: (text){
                                  authenticationTextCancelButton(text);
                                },
                                decoration: InputDecoration(
                                    hintText: '인증번호를 입력하시오',
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                              ),
                            ),
                            Visibility(
                              visible: authenticationNumberCancel,
                              child: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: (){
                                  authenticationController.clear();
                                  setState(() {
                                    authenticationNumberCancel = false;
                                  });
                                },
                              )
                            )
                          ],
                        ),
                      ),
                      if (userCheckError)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '입력하신 이메일이 정보가 틀렸습니다. 입력 하신 내용을 다시 확인해주세요',
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _tryValidationOfname();
                          },
                          child: Text('다음'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.white,
                            textStyle: TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(2), // 버튼의 모서리를 둥글게 설정
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}
