import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:smart_dongne/login_page/Social_login/social_login.dart';

import '../../server/Server.dart';

class MainViewModel {
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;

  MainViewModel(this._socialLogin);

  Future login() async {
    isLogined = await _socialLogin.login();
    if (isLogined) {
      user = await UserApi.instance.me();
      final data = {
        'id' : user!.kakaoAccount?.email,
        'root' : 'kakao'
      };
      return data;
    }
  }

  

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }
}