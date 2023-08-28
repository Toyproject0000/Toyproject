import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:smart_dongne/login_page/setnickname.dart';
import 'package:smart_dongne/main_page/setpage.dart';
import 'package:smart_dongne/server/chatServer.dart';
import 'package:smart_dongne/server/userId.dart';

import '../server/Server.dart';

class Joinmembership extends StatefulWidget {
  const Joinmembership({Key? key}) : super(key: key);

  static const routeName = '/join';

  @override
  State<Joinmembership> createState() => _JoinmembershipState();
}

class _JoinmembershipState extends State<Joinmembership> {

  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();

  TextEditingController textController = TextEditingController();
  bool authenticationSuccessful = false;

  String userEmail = '';
  String userPassword = '';
  String userName = '';
  String? phoneNumber;
  String dateofBirth = '';
  String userPhoneNumber = '';

  String? authenticationNumber;
  String? perfectPassWord;
  bool manButton = false;
  bool womanButton = false;
  final _focusNode = FocusNode();

  TextEditingController authenticationController = TextEditingController();

  void MessageCompleted() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('회원가입이 완료됬습니다.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: Text(
                    '완료',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          );
        });
  }

  void _tryValidation() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        var joinData = {
          'id': userEmail,
          'password': userPassword,
          'name': userName,
          'gender': manButton,
          'phoneNumber': userPhoneNumber,
          'root' : LoginRoot,
        };
        final joinResponse = await ServerResponseOKTemplate('/join', joinData);
        if (joinResponse != null) {
          MessageCompleted();
        } else {
          Flushbar(
            margin: EdgeInsets.symmetric(horizontal: 15),
            flushbarPosition: FlushbarPosition.TOP,
            duration: Duration(seconds: 2),
            message: '이미 가입된 사용자 입니다.',
            messageSize: 15,
            borderRadius: BorderRadius.circular(4),
            backgroundColor: Colors.white,
            messageColor: Colors.black,
            boxShadows: [BoxShadow(color: Colors.black, blurRadius: 8)],
          ).show(context);
        }
      } catch (e) {
        print(e);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please check your email and password'),
              backgroundColor: Colors.blue,
            ),
          );
        }
      }
    }
  }

  void _emailValidation() async {
    final isValid = _emailKey.currentState!.validate();
    if (isValid) {
      _emailKey.currentState!.save();
      final email = {'id': userEmail};
      final response = await ServerResponseOKTemplate('/authentication', email);
      if (response != null) {
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
      }
    }
  }

  void authenticationCheck() async {
    final data = {'id' : userEmail, 'num' : authenticationController.text};
    final response = await ServerResponseOKTemplate('/authentication-check', data);
    if(response != null){
      setState(() {
        authenticationSuccessful = true;
      });
    }else{
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
            child: Form(
              key: _formKey,
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
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Form(
                      key: _emailKey,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return '이메일을 바르게 적어주세요';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userEmail = value!;
                              },
                              onChanged: (value) {
                                userEmail = value;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  focusedBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  hintText: '이메일'),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                _emailValidation();
                                FocusScope.of(context).requestFocus(_focusNode);
                              },
                              child: Text(
                                '인증번호 요청',
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: authenticationController,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: '인증번호 입력',
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            authenticationCheck();
                          },
                          child: Text('인증번호 확인', style: TextStyle(color: Colors.blue),))
                      ],
                    ),
                  ),
                  if(authenticationSuccessful == true)
                  Text('인증번호가 맞습니다.', style: TextStyle(color: Colors.green),),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.length < 8 ||
                          !value.contains(RegExp(r'[!@#$%^&*()<>?":{}|<>]'))) {
                        return '비밀번호는 영문과 특수문자를 합쳐 8글자 이상으로 적어주세요.';
                      }
                      perfectPassWord = value; // 수정해야햄
                      return null;
                    },
                    onChanged: (value) {
                      userPassword = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: '비밀번호'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != perfectPassWord) {
                        return '비밀번호가 틀립니다.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      userPassword = value;
                    },
                    onSaved: (value) {
                      userPassword = value!;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: '비밀번호 확인'),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 2) {
                        return '이름을 올바른 형식으로 적어주세요.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userName = value!;
                    },
                    onChanged: (value) {
                      userName = value;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: '이름'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.length < 8) {
                        return '생년월일 8자리를 적어주세요.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      dateofBirth = value!;
                    },
                    onChanged: (value) {
                      dateofBirth = value;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: '생년월일(8자리)'),
                  ),
                  Container(
                    height: 60,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                manButton = true;
                                womanButton = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  manButton ? Colors.blue : Colors.white,
                            ),
                            child: Text(
                              '남성',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                manButton = false;
                                womanButton = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    womanButton ? Colors.blue : Colors.white),
                            child: Text(
                              '여성',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.length < 11) {
                        return '전화번호 형식을 올바르게 적어주세요.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userPhoneNumber = value!;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: '전화번호'),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(double.infinity, 48),
                      ),
                      child: Text(
                        '회원 가입하기',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        _tryValidation();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
