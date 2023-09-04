import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/genderButton.dart';
import 'package:smart_dongne/component/myButton.dart';
import 'package:smart_dongne/component/myselfWidget.dart';
import 'package:smart_dongne/login_page/nickname_page.dart';
import 'package:smart_dongne/server/userId.dart';

class SocialLoginSetting extends StatefulWidget {
  const SocialLoginSetting({super.key});

  static const routeName = '/socialLoginUserSetting';

  @override
  State<SocialLoginSetting> createState() => _SocialLoginSettingState();
}

class _SocialLoginSettingState extends State<SocialLoginSetting> {
  bool man = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();


  void sendSocialUserData() async {
    if (nameController.text.isNotEmpty &&
      birthdayController.text.length == 8 &&
      phoneNumberController.text.length == 11){
        // create brithday type
        String birthdayType = birthdayController.text.substring(0, 4) +
        '-' +
        birthdayController.text.substring(4, 6) +
        '-' +
        birthdayController.text.substring(6, 8);
        //make user data
        final data = {
          'id': globalUserId,
          'root': LoginRoot,
          'name': nameController.text,
          'phoneNumber': phoneNumberController.text,
          'gender': man,
          'birth': birthdayType,
          'root' : LoginRoot,
        };
        Navigator.pushNamed(context, NickNameField.routeName, arguments: JoinArgument(data));
      }else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('본인 정보를 정확히 입력하시오.')));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          '설정',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          children: [
            Column(
              children: [
                MySelfWidget(
                    nameController: nameController,
                    birthdayController: birthdayController,
                    phoneNumberController: phoneNumberController),
                MyGenderButton(man: man),
                SizedBox(
                  height: 25,
                ),
                MyButton(text: '완료', onPresse: sendSocialUserData)
              ],
            ),
          ],
        ),
      ),
    );
  }
}