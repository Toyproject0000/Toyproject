import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/Account_management.dart';
import 'package:smart_dongne/main_page/profile_page/notification_page/notification_page.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({super.key});

  static const routeName = '/userSetting';

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text('설정', style: TextStyle(fontSize: 18, color: Colors.black),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, AccountManagement.routeName);
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.person, size: 35,),
                  SizedBox(width: 15,),
                  Text('계정관리', style: TextStyle(fontSize: 20),)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, AccountNotification.routeName);
            },
            
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.notifications, size: 35,),
                  SizedBox(width: 15,),
                  Text('알림', style: TextStyle(fontSize: 20),)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){},
            
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.error_outline, size: 35,),
                  SizedBox(width: 15,),
                  Text('차단한 계정', style: TextStyle(fontSize: 20),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}