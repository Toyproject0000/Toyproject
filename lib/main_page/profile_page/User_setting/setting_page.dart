import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/login_page/Social_login/kakao_login.dart';
import 'package:smart_dongne/login_page/Social_login/main_view_model.dart';
import 'package:smart_dongne/login_page/login_page.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/Account_management.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/cutoff.dart';
import 'package:smart_dongne/main_page/profile_page/notification_page/notification_page.dart';
import 'package:smart_dongne/provider/setPageData.dart';
import 'package:smart_dongne/server/userId.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({super.key});

  static const routeName = '/userSetting';

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  final viewModel = MainViewModel(KakaoLogin());
  late SetPageProvider _setPageProvider;


  void accountSetInitialization(){
      final storage = FlutterSecureStorage();
      storage.delete(key: 'login');
      LoginRoot = '';
      globalNickName = '';
      globalUserId = '';
      _setPageProvider.ChangeScreen(0);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);

  }

  void logOut() async {
    if (LoginRoot == 'naver')  {
      await FlutterNaverLogin.logOutAndDeleteToken();
      accountSetInitialization();
    } else if (LoginRoot == 'kakao') {
      viewModel.logout();
      accountSetInitialization();
    } else if (LoginRoot == 'local') {
      accountSetInitialization();
    }
  }

  @override
  Widget build(BuildContext context) {
    _setPageProvider = Provider.of<SetPageProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          '설정',
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AccountManagement.routeName);
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 35,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '계정관리',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AccountNotification.routeName);
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications,
                    size: 35,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '알림',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Cutoff.routeName);
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 35,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '차단한 계정',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                '로그아웃 하시겠습니까??',
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => logOut(),
                                    child: Text(
                                      '다음',
                                      style: TextStyle(color: Colors.blue),
                                    ))
                              ],
                            );
                          });
                    },
                    child: Text(
                      '로그아웃',
                      style: TextStyle(color: Colors.grey),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
