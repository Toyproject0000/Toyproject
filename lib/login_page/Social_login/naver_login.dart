import 'package:flutter_naver_login/flutter_naver_login.dart';

void login_naver () async {
    NaverLoginResult result = await FlutterNaverLogin.logIn();
    // result.account.email
    
  }