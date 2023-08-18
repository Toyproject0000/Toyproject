import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:smart_dongne/login_page/Social_login/social_login_setting.dart';
import 'package:smart_dongne/login_page/TermsofService/termsofservice.dart';
import 'package:smart_dongne/login_page/TermsofService/userContent.dart';
import 'package:smart_dongne/login_page/find_password.dart';
import 'package:smart_dongne/login_page/find_password_2.dart';
import 'package:smart_dongne/login_page/join_membership_page.dart';
import 'package:smart_dongne/login_page/login_page.dart';
import 'package:smart_dongne/login_page/setnickname.dart';
import 'package:smart_dongne/main_page/chatting_page/chatting_searchmode.dart';
import 'package:smart_dongne/main_page/home_page/Content_page.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/Account_management.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/setting_page.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/userName_change.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/userWithdrawal.dart';
import 'package:smart_dongne/main_page/profile_page/notification_page/cutoff.dart';
import 'package:smart_dongne/main_page/profile_page/notification_page/likeandpost.dart';
import 'package:smart_dongne/main_page/profile_page/notification_page/notification_page.dart';
import 'package:smart_dongne/main_page/profile_page/notification_page/reader_page.dart';
import 'package:smart_dongne/main_page/home_page/search_bar.dart';
import 'package:smart_dongne/main_page/writing_page/cover.dart';
import 'package:smart_dongne/main_page/profile_page/profile_edit_page.dart';
import 'package:smart_dongne/main_page/writing_page/writing_page_final.dart';
import 'package:smart_dongne/main_page/setpage.dart';
import 'login_page/TermsofService/personalinformaition.dart';
import 'login_page/find_id.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'ca6e54286fb5cc0bc83d0320f4cb60d8');
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
        ChatSearchMode.routeName: (context) => ChatSearchMode(), 
        UserSetting.routeName: (context) => UserSetting(),
        AccountManagement.routeName: (context) => AccountManagement(),
        UserNameChange.routeName: (context) => UserNameChange(),
        UserWithDrawal.rotueName: (context) => UserWithDrawal(),
        AccountNotification.routeName: (context) => AccountNotification(),
        LikeAndPost.routeName: (context) => LikeAndPost(),
        ReaderNotification.routeName: (context) => ReaderNotification(),
        Cutoff.routeName: (context) => Cutoff(),
        Search_Page_bar.routeName: (context) => Search_Page_bar(),
        ShowaContents.routeName: (context) => ShowaContents(),
        SocialLoginSetting.rotueName: (context) => SocialLoginSetting(),
        TermsofService.routeName: (context) => TermsofService(),
        PersonalInformation.routeName: (context) => PersonalInformation(),
        UserConsent.routeName: (context) => UserConsent(),
      },
    );
  }
}
