import 'package:flutter/material.dart';
import 'package:smart_dongne/login_page/find_password.dart';
import 'package:smart_dongne/login_page/find_password_2.dart';
import 'package:smart_dongne/login_page/join_membership_page.dart';
import 'package:smart_dongne/login_page/login_page.dart';
import 'package:smart_dongne/login_page/setnickname.dart';
import 'package:smart_dongne/main_page/writing_page/cover.dart';
import 'package:smart_dongne/main_page/profile_page/profile_edit_page.dart';
import 'package:smart_dongne/main_page/writing_page/writing_page_final.dart';
import 'package:smart_dongne/main_page/setpage.dart';

import 'login_page/find_id.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        Joinmembership.routeName: (context) => Joinmembership(),
        FindPassword.routeName: (context) => FindPassword(),
        SetPage.routeName: (context) => SetPage(),
        NickName.routeName: (context) => NickName(),
        ProfileEdit.routeName: (context) => ProfileEdit(),
        FindId.routeName: (context) => FindId(),
        LastSetting.routeName: (context) => LastSetting(),
        CoverPage.routeName: (context) => CoverPage(),
        NewPassWord.routeName: (context) => NewPassWord(),
      },
    );
  }
}
