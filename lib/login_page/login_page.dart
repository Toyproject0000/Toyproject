import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/login_page/Social_login/kakao_login.dart';
import 'package:smart_dongne/login_page/Social_login/main_view_model.dart';
import 'package:smart_dongne/login_page/TermsofService/userContent.dart';
import 'package:smart_dongne/login_page/setnickname.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/login_page/find_password.dart';
import 'package:smart_dongne/main_page/setpage.dart';
import 'Social_login/naver_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final viewModel = MainViewModel(KakaoLogin());
  bool termsofservice = false;
  bool personalInfomation = false;
  bool allconsend = false;

  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';
  bool loginError = true;

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      var data = {
        'id': userEmail,
        'password': userPassword,
      };
      loginSendData(data, context, loginCheck);
    }
  }

  void loginCheck() {
    setState(() {
      loginError = false;
    });
  }

  void kakaoAccountServer() async {
    final data = await viewModel.login();
    final kakaoServer = JoinMemdership();
    final jsonData = kakaoServer.sendData(data);
    if (jsonData == null) {
      Navigator.pushNamed(context, NickName.routeName);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(top: 70),
                  child: Text(
                    'Writer',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 140,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      width: MediaQuery.of(context).size.width - 50,
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    loginError = false;
                                  } else if (!value.contains('@')) {
                                    loginError = false;
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
                                  hintText: '아이디',
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    loginError = false;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  userPassword = value!;
                                },
                                onChanged: (value) {
                                  userPassword = value;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    hintText: '비밀번호'),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.check_circle, size: 20),
                                    ),
                                    Text(
                                      '로그인 상태를 유지',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              if (loginError == false)
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    '아이디(로그인 전용 아이디) 또는 비밀번호를 잘못 입력했습니다.'
                                    '입력하신 내용을 다시 확인해주세요.',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              // 로그인 버튼
                              ElevatedButton(
                                onPressed: () {
                                  // _tryValidation();
                                  Navigator.pushNamed(
                                      context, SetPage.routeName);
                                  // Navigator.pushNamed(context, SocialLoginSetting.rotueName);
                                },
                                child: Text(
                                  '로그인',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  minimumSize: Size(double.infinity, 48),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  '소셜 로그인',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[600]),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      login_naver();
                                    },
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('image/naverButton.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      kakaoAccountServer();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.yellow,
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('image/kakao.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TextButton(
                      //   onPressed: () {
                      //     Navigator.pushNamed(context, FindId.routeName);
                      //   },
                      //   child: Text(
                      //     '아이디 찾기',
                      //     style: TextStyle(
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      // ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, FindPassword.routeName);
                        },
                        child: Text(
                          '비밀번호 찾기',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //     context, Joinmembership.routeName);
                          // Navigator.pushNamed(context, TermsofService.routeName);
                          // Navigator.pushNamed(context, PersonalInformation.routeName);
                          Navigator.pushNamed(context, UserConsent.routeName);
                        },
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
