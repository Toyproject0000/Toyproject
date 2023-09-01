import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:smart_dongne/component/my_Text_Form_Field.dart';
import 'package:smart_dongne/login_page/Social_login/kakao_login.dart';
import 'package:smart_dongne/login_page/Social_login/main_view_model.dart';
import 'package:smart_dongne/login_page/TermsofService/agreement.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/login_page/find_password.dart';
import 'package:smart_dongne/main_page/setpage.dart';
import 'package:smart_dongne/server/userId.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool stayLoggedIn = false;

  String userEmail = '';
  String userPassword = '';
  bool loginError = false;

  void upDateEmailAndPassword() {}

  void sendIdandPassword() async {
    final data = {
      'id': emailController.text,
      'password': passwordController.text,
      'root': 'local'
    };
    final response = await loginSendData('/login', data);
    if (response != null && response != '닉네임 설정 안됨') {
      final jsonData = jsonDecode(response);
      jwtToken = jsonData['token'];
      globalNickName = jsonData['nickname'];
      globalUserId = jsonData['id'];
      Navigator.pushNamed(context, SetPage.routeName);
    } else if (response == '닉네임 설정 안됨') {
    } else {
      setState(() {
        loginError = true;
      });
    }
  }

  void socialLogin(email, root) async {
    final data = {'id': email, 'root': root};
    final response = await loginSendData('/socialLogin', data);
    if (response == null) {
      globalUserId = email;
      LoginRoot = root;
      Navigator.pushNamed(context, UserConsent.routeName);
    } else if (response == '닉네임 설정 안됨') {
      
    } else {
      final jsonData = jsonDecode(response);
      jwtToken = jsonData['token'];
      globalUserId = jsonData['id'];
      globalNickName = jsonData['nickname'];
      Navigator.pushNamed(context, SetPage.routeName);
    }
  }

  // auto Login lmplementation
  void upDateEmailandPassword() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('useremail', userEmail);
    pref.setString('userPassword', userPassword);
  }

  void LoginNaver() async {
    NaverLoginResult result = await FlutterNaverLogin.logIn();
    socialLogin(result.account.email, 'naver');
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            MyTextFormField(
                              controller: emailController,
                              hintText: '아이디',
                              obscureText: false,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MyTextFormField(
                              controller: passwordController,
                              hintText: '비밀번호',
                              obscureText: true,
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
                            if (loginError == true)
                              Text(
                                '아이디 혹은 비밀번호가 잘못됐습니다.',
                                style: TextStyle(color: Colors.red),
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            // 로그인 버튼
                            ElevatedButton(
                              onPressed: () {
                                if (emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  sendIdandPassword();
                                } else {
                                  null;
                                }
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
                                    LoginNaver();
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
                                  onTap: () async {
                                    // kakaoAccountServer();
                                    final data = await viewModel.login();
                                    socialLogin(data, 'kakao');
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
