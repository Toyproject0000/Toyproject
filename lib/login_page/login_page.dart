import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/component/my_Text_Form_Field.dart';
import 'package:smart_dongne/login_page/Social_login/kakao_login.dart';
import 'package:smart_dongne/login_page/Social_login/main_view_model.dart';
import 'package:smart_dongne/login_page/TermsofService/agreement.dart';
import 'package:smart_dongne/provider/LoginMaintenance.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/login_page/find_password.dart';
import 'package:smart_dongne/main_page/setpage.dart';
import 'package:smart_dongne/server/userId.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/';
  static bool autoLogin = false;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // id, password storge valiable
  static final storage = FlutterSecureStorage();
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  final viewModel = MainViewModel(KakaoLogin());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginMaintenance _loginMaintenance = LoginMaintenance();

  bool stayLoggedIn = false;

  String userEmail = '';
  String userPassword = '';

  void sendIdandPassword(data) async {
    final response = await loginSendData('/login', data);
    if (response != null) {
      final jsonData = jsonDecode(response);
      jwtToken = jsonData['token'];
      globalNickName = jsonData['nickname'];
      globalUserId = jsonData['id'];
      LoginRoot = 'local';
      if (Provider.of<LoginMaintenance>(context, listen: false)
              .loginMaintenance ==
          true) {
        emailpasswordSave(
            emailController.text, 'local', passwordController.text,);
      }
      Navigator.pushReplacementNamed(context, SetPage.routeName);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('이메일 혹은 비밀번호가 틀렸습니다.')));
    }
  }

  void socialLogin(data) async {
    final response = await loginSendData('/socialLogin', data);

    if (response == null) {
      // go to join page
      
      globalUserId = data['id'];
      LoginRoot = data['root'];
      Navigator.pushNamed(context, UserConsent.routeName);
    } else {
      final jsonData = jsonDecode(response);
      jwtToken = jsonData['token'];
      globalUserId = jsonData['id'];
      globalNickName = jsonData['nickname'];
      LoginRoot = data['root'];
      emailpasswordSave(jsonData['id'], data['root'], null);
      if (mounted) {
        Navigator.pushReplacementNamed(context, SetPage.routeName);
      }
    }
  }

  void LoginNaver() async {
    NaverLoginResult result = await FlutterNaverLogin.logIn();
    if (result.errorMessage == '') {
      final data = {'id': result.account.email, 'root': 'naver'};

      socialLogin(data);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    super.initState();
  }

  _asyncMethod() async {
    userInfo = await storage.read(key: 'login');
    if (userInfo != null) {
      var userData = jsonDecode(userInfo);
      if (userData['root'] == 'local') {
        sendIdandPassword(userData);
      } else {
        socialLogin(userData);
      }
    } else {
      FlutterNativeSplash.remove();
      print('로그인이 필요합니다');
    }
  }

  void emailpasswordSave(email, root, String? password) async {
    final data = password == null
        ? {'id': email, 'root': root}
        : {'id': email, 'password': password, 'root': root};
    await storage.write(key: 'login', value: jsonEncode(data));
    await storage.write(
      key: "id",
      value: email,
    );
    await storage.write(
      key: "password",
      value: password,
    );
    await storage.write(
      key: "root",
      value: root,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _loginMaintenance = Provider.of<LoginMaintenance>(context, listen: false);
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
                                  Consumer(
                                    builder: (context, provider, child) {
                                      return IconButton(
                                        onPressed: () {
                                          _loginMaintenance
                                              .loginMaintenanceOnpress();
                                        },
                                        icon: Icon(
                                          Icons.check_circle,
                                          size: 20,
                                          color: Provider.of<LoginMaintenance>(
                                                          context)
                                                      .loginMaintenance ==
                                                  false
                                              ? Colors.grey
                                              : Colors.blue,
                                        ),
                                      );
                                    },
                                  ),
                                  Text(
                                    '로그인 상태를 유지',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // 로그인 버튼
                            ElevatedButton(
                              onPressed: () {
                                if (emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  final data = {
                                    'id': emailController.text,
                                    'password': passwordController.text,
                                    'root': 'local'
                                  };
                                  sendIdandPassword(data);
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
                                    final kakaoEmail = await viewModel.login();
                                    if (kakaoEmail != null) {
                                      final data = {
                                        'id': kakaoEmail,
                                        'root': 'kakao'
                                      };
                                      socialLogin(data);
                                    }
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
