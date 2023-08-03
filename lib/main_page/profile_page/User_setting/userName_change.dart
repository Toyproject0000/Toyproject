import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserNameChange extends StatefulWidget {
  const UserNameChange({super.key});

  static const routeName = '/userSetting/accountManagement/userName';

  @override
  State<UserNameChange> createState() => _UserNameChangeState();
}

class _UserNameChangeState extends State<UserNameChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('계정 정보'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('이름')
          ],
        ),
      ),
    );
  }
}