import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/login_page/find_password_2.dart';

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

  // Server로 보내는 값들
  String userAuthticationNumber = '';
  String userName = '';
  String userNumber = '';
  String encryption = '';

  void changeScreen() {
    setState(() {
      iDpass = true;
    });
  }

  void _tryValidation() {
    final isValid = _formkey.currentState!.validate();
    if (isValid) {
      _formkey.currentState!.save();
      var data = {'id': userEmail};

      FindPasswordServer server = FindPasswordServer();
      server.sendEmail(data, changeScreen);
    }
  }

  void _tryValidationOfname() async {
    final isValid = _formKey2.currentState!.validate();
    if (isValid) {
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
      print(checkJsonData);
      print(authenticationJsonData);

      // null 을 통해 위쪽으로 스낵바

      // if (checkJsonData == null) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     duration: Duration(seconds: 5),
      //     content: Text('입력하신 내용이 맞지 않습니다.'),
      //   ));
      // }
      if (authenticationJsonData == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 5),
          content: Text('인증번호가 맞지 않습니다.'),
        ));
      } else if (checkJsonData != null && authenticationJsonData != null) {
        Navigator.pushNamed(context, NewPassWord.routeName);
      }
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
                        TextFormField(
                          key: ValueKey(1),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '이메일을 작성해주세요';
                            } else if (!value.contains('@')) {
                              return '이메일 형식으로 작성해주세요';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userEmail = value!;
                          },
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintText: '이메일'),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        ElevatedButton(
                          onPressed: () {
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
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '이름을 입력해주세요';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          userName = value!;
                        },
                        decoration: InputDecoration(
                            hintText: '이름을 입력하시오',
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey, width: 1.0))),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Form(
                                key: _numberKey,
                                child: TextFormField(
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
                              },
                              child: Text(
                                '인증번호 전송',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.length < 6) {
                            return '인증번호를 바르게 입력하시오';
                          }
                        },
                        onSaved: (value) {
                          userAuthticationNumber = value!;
                        },
                        decoration: InputDecoration(
                            hintText: '인증번호를 입력하시오',
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey, width: 1.0))),
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _tryValidationOfname();

                            // 임시
                            // Navigator.pushNamed(context, NewPassWord.routeName);
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
