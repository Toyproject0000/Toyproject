import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_dongne/login_page/setnickname.dart';
import 'package:smart_dongne/main_page/setpage.dart';

import '../server/Server.dart';

class Joinmembership extends StatefulWidget {
  const Joinmembership({Key? key}) : super(key: key);

  static const routeName = '/join';

  @override
  State<Joinmembership> createState() => _JoinmembershipState();
}

class _JoinmembershipState extends State<Joinmembership> {
  final _formKey = GlobalKey<FormState>();
  final _numberKey = GlobalKey<FormState>();

  TextEditingController textController = TextEditingController();

  String userEmail = '';
  String userPassword = '';
  String userName = '';
  String? phoneNumber;
  String dateofBirth = '';

  String? authenticationNumber;
  String? perfectPassWord;
  bool manButton = false;
  bool womanButton = false;
  String encryptionNumber = '';
  final _focusNode = FocusNode();

  void _tryValidation() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        var data = {
          'id': userEmail,
          'password': userPassword,
          'name': userName,
          'gender': manButton,
          'phoneNumber': phoneNumber,
          
        };

        var authenticationdata = {
          'rawNum': authenticationNumber,
          'num': encryptionNumber,
        };

        JoinMemdership server = JoinMemdership();
        final String? answer = await server.sendData(data);
        final String? numberAnswer = await server.authenticationNumberCheck(authenticationdata, context);
        if (answer == null && numberAnswer == null){
          Navigator.pushNamed(context, NickName.routeName, arguments: ArgumentEmail(userEmail));
        } else if(numberAnswer != null){
          Flushbar(
          margin: EdgeInsets.symmetric(horizontal: 15),
          flushbarPosition: FlushbarPosition.TOP,
          duration: Duration(seconds: 2),
          message: '인증번호가 맞지 않습니다.' ,
          messageSize: 15,
          borderRadius: BorderRadius.circular(4),
          backgroundColor: Colors.white,
          messageColor: Colors.red,
          boxShadows: [
            BoxShadow(color: Colors.black, blurRadius: 8)
          ],
        ).show(context);
        } else {
          Flushbar(
          margin: EdgeInsets.symmetric(horizontal: 15),
          flushbarPosition: FlushbarPosition.TOP,
          duration: Duration(seconds: 2),
          message: '이미 가입된 사용자 입니다.' ,
          messageSize: 15,
          borderRadius: BorderRadius.circular(4),
          backgroundColor: Colors.white,
          messageColor: Colors.black,
          boxShadows: [
            BoxShadow(color: Colors.black, blurRadius: 8)
          ],
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

  void _NumberValidation() {
    final NumberValid = _numberKey.currentState!.validate();
    if (NumberValid) {
      _numberKey.currentState!.save();
      final data = {'phoneNumber': phoneNumber};
      final authentication = numberAuthentiaction();
      authentication.sendPhoneNumber(data).then((value) {
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
        setState(() {
          encryptionNumber = authentication.AuthenticationNumber!;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
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
                    TextFormField(
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
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintText: '이메일'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8 || !value.contains(RegExp(r'[!@#$%^&*()<>?":{}|<>]'))) {
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
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 60,
                      
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _numberKey,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 11) {
                                    Flushbar(
                                      margin: EdgeInsets.symmetric(horizontal: 15),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      duration: Duration(seconds: 2),
                                      message: '전화번호를 올바르게 입력하시오.' ,
                                      messageSize: 15,
                                      borderRadius: BorderRadius.circular(4),
                                      backgroundColor: Colors.white,
                                      messageColor: Colors.black,
                                      boxShadows: [
                                        BoxShadow(color: Colors.black, blurRadius: 8)
                                      ],
                                    ).show(context);
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  phoneNumber = value!;
                                },
                                onChanged: (value) {
                                  phoneNumber = value;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: '전화번호'),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _NumberValidation();
                              FocusScope.of(context).requestFocus(_focusNode);
                            },
                            child: Text(
                              '인증번호 요청',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 6) {
                          return '인증번호를 올바르게 입력하시오.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        authenticationNumber = value!;
                      },
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: '인증번호 6자리를 입력해주세요.',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
