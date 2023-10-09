import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:smart_dongne/login_page/social_login_setting.dart';
import 'package:smart_dongne/login_page/TermsofService/agreement.dart';
import 'package:smart_dongne/login_page/TermsofService/termsofservice.dart';
import 'package:smart_dongne/login_page/find_password.dart';
import 'package:smart_dongne/login_page/join_membership_page.dart';
import 'package:smart_dongne/login_page/login_page.dart';
import 'package:smart_dongne/login_page/nickname_page.dart';
import 'package:smart_dongne/main_page/chatting_page/chatting_searchmode.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/Account_management.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/setting_page.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/userName_change.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/cutoff.dart';
import 'package:smart_dongne/main_page/profile_page/notification_page/likeandpost.dart';
import 'package:smart_dongne/main_page/profile_page/notification_page/notification_page.dart';
import 'package:smart_dongne/main_page/profile_page/notification_page/reader_page.dart';
import 'package:smart_dongne/main_page/writing_page/cover.dart';
import 'package:smart_dongne/main_page/profile_page/profile_edit_page.dart';
import 'package:smart_dongne/main_page/setpage.dart';
import 'package:smart_dongne/provider/JoinArgeement.dart';
import 'package:smart_dongne/provider/LoginMaintenance.dart';
import 'package:smart_dongne/provider/chattingProvider.dart';
import 'package:smart_dongne/provider/comment_provider.dart';
import 'package:smart_dongne/provider/likeProvider.dart';
import 'package:smart_dongne/provider/setPageData.dart';
import 'package:smart_dongne/provider/writingSettingProvider.dart';
import 'login_page/TermsofService/personalinformaition.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  KakaoSdk.init(nativeAppKey: 'ca6e54286fb5cc0bc83d0320f4cb60d8');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => LoginMaintenance()),
        ChangeNotifierProvider(
            create: (BuildContext context) => JoinArgeement()),
        ChangeNotifierProvider(
            create: (BuildContext context) => SetPageProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => WritingSettingProvider(
                disclosure: '모두 공개',
                enableComments: false,
                likeNumber: false)),
        ChangeNotifierProvider(create: (BuildContext context) => ChattingProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => LikeProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => CommentProvider())
      ],
      child: const MyApp(),
    ),
  );
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
        NickNameField.routeName: (context) => NickNameField(),
        FindPassword.routeName: (context) => FindPassword(),
        SetPage.routeName: (context) => SetPage(),
        ProfileEdit.routeName: (context) => ProfileEdit(),
        CoverPage.routeName: (context) => CoverPage(),
        ChatSearchMode.routeName: (context) => ChatSearchMode(),
        UserSetting.routeName: (context) => UserSetting(),
        AccountManagement.routeName: (context) => AccountManagement(),
        UserNameChange.routeName: (context) => UserNameChange(),
        AccountNotification.routeName: (context) => AccountNotification(),
        LikeAndPost.routeName: (context) => LikeAndPost(),
        ReaderNotification.routeName: (context) => ReaderNotification(),
        Cutoff.routeName: (context) => Cutoff(),
        SocialLoginSetting.routeName: (context) => SocialLoginSetting(),
        TermsofService.routeName: (context) => TermsofService(),
        PersonalInformation.routeName: (context) => PersonalInformation(),
        UserConsent.routeName: (context) => UserConsent(),
      },
    );
  }
}
