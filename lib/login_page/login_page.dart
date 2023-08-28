import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/login_page/Social_login/kakao_login.dart';
import 'package:smart_dongne/login_page/Social_login/main_view_model.dart';
import 'package:smart_dongne/login_page/TermsofService/agreement.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/login_page/find_password.dart';
import 'package:smart_dongne/main_page/setpage.dart';
import 'package:smart_dongne/server/userId.dart';
import 'Social_login/naver_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/';
  static bool autoLogin = false;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final viewModel = MainViewModel(KakaoLogin());
  bool termsofservice = false;
  bool personalInfomation = false;
  bool allconsend = false;

  bool stayLoggedIn = false;

  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';
  bool loginError = true;

  void upDateEmailAndPassword() {}

  void _tryValidation() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid == true) {
      _formKey.currentState!.save();
      var data = {
        'id': userEmail,
        'password': userPassword,
        'root' : 'local'
      };
      final response = await loginSendData(data, context);
      final jsonData = jsonDecode(response);
      if (response != null) {
        globalUserId = jsonData['id'];
        jwtToken = jsonData['token'];
        globalNickName = jsonData['nickname'];
        Navigator.pushNamed(context, SetPage.routeName);
      } else {
        loginCheck();
      }
    }
  }

  void loginCheck() {
    setState(() {
      loginError = false;
    });
  }

  // auto Login lmplementation
  void upDateEmailandPassword() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('useremail', userEmail);
    pref.setString('userPassword', userPassword);
  }

  void setData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      StayLogin stayLoginInstance = StayLogin();
      stayLoginInstance.userEmail = pref.getString('useremail');
      stayLoginInstance.userPassword = pref.getString('userPassword');
    } catch (e) {
      print('에러 : $e');
    }
  }

  void kakaoAccountServer() async {
    final data = await viewModel.login();
    globalUserId = data['id'];
    LoginRoot = data['root'];
    Navigator.pushNamed(context, UserConsent.routeName);
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
                      height: 430,
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
                                    return '이메일 형식에 맞게 작성해주세요.';
                                  } else if (!value.contains('@')) {
                                    return '이메일 형식에 맞게 작성해주세요.';
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
                                    return '비밀번호가 틀렸습니다.';
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
                                      onPressed: () {
                                        setState(() {
                                          stayLoggedIn = !stayLoggedIn;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.check_circle,
                                        size: 20,
                                        color: stayLoggedIn == false
                                            ? Colors.grey
                                            : Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      '로그인 상태를 유지',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // 로그인 버튼
                              ElevatedButton(
                                onPressed: () {
                                  _tryValidation();
                                  // Navigator.pushNamed(
                                  //     context, SetPage.routeName);
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
                          LoginRoot = 'local';
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
