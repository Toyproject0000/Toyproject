import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_dongne/component/myButton.dart';
import 'package:smart_dongne/component/my_Text_Form_Field.dart';
import 'package:smart_dongne/component/myselfWidget.dart';
import 'package:smart_dongne/login_page/nickname_page.dart';
import 'package:smart_dongne/server/chatServer.dart';
import 'package:smart_dongne/server/userId.dart';
import 'package:toggle_switch/toggle_switch.dart';

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

  //sever error
  bool errorResponse = false;

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
                Container(
                  height: 60,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              man = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: man ? Colors.blue : Colors.white,
                          ),
                          child: Text(
                            '남성',
                            style: TextStyle(
                              color: man ? Colors.white : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              man = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  man == false ? Colors.blue : Colors.white),
                          child: Text(
                            '여성',
                            style: TextStyle(
                                color: !man ? Colors.white : Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (errorResponse == true)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '정보를 정확히 입력해주세요.',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
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

class SocialRoot {
  final String root;

// if (nameController.text.isEmpty &&
//                         birthdayController.text.length == 8 &&
//                         phoneNumberController.text.length == 11) {
//                       sendSocialUserData();
//                     }
  SocialRoot(this.root);
}