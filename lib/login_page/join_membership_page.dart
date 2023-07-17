import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_dongne/login_page/setnickname.dart';

import '../Server.dart';

class Joinmembership extends StatefulWidget {
  const Joinmembership({Key? key}) : super(key: key);

  static const routeName = '/join';

  @override
  State<Joinmembership> createState() => _JoinmembershipState();
}

class _JoinmembershipState extends State<Joinmembership> {
  final _formKey = GlobalKey<FormState>();
  final _numberKey = GlobalKey<FormState>();
  final _numberKey2 = GlobalKey<FormState>();

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

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        var data = {
          'id': userEmail,
          'password': userPassword,
          'name': userName,
          'gender': manButton,
        };
        ServerConnection server = ServerConnection(context);
        server.sendData(data);
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
      authentication.sendPhoneNumber(data);
    }
  }

  void _NumberValidation2() {
    _numberKey2.currentState!.save();

    final authentication = numberAuthentiaction();
    authentication.authenticationNumberCheck(authenticationNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                      if (value!.isEmpty) {
                        return '이메일을 입력하시오';
                      } else if (!value.contains('@')) {
                        return '이메일 형식을 입력하시오';
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
                      if (value!.isEmpty || value.length < 8) {
                        return '8글자 이상을 입력하시오';
                      } else if (!value
                          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return '비멀번호는 숫자,문자,특수기호를 포함한 형식으로 작성해주세요';
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
                        return '비밀번호가 일치하지 않습니다';
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
                      if (value!.isEmpty || value.length < 2) {
                        return '2글자 이상을 입력하시오';
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
                      if (value!.isEmpty || value.length < 8) {
                        return '생년월일 8자리를 입력하시오';
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
                                  return '전화번호를 올바르게 입력하시오';
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
                          },
                          child: Text(
                            '인증번호 요청',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
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
                        children: [
                          Expanded(
                            child: Form(
                              key: _numberKey2,
                              child: TextFormField(
                                onSaved: (value) {
                                  authenticationNumber = value!;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '인증번호 입력하기'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              if (phoneNumber != null) {
                                _NumberValidation2();
                              } else {
                                // 스낵바로 전화번호 입력하라고 하기
                              }
                            },
                            child: Text(
                              '인증번호 확인',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      )),
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
