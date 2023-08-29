import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_dongne/component/my_Text_Form_Field.dart';
import 'package:smart_dongne/component/myselfWidget.dart';
import 'package:smart_dongne/login_page/setnickname.dart';
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
    // 생년월일이 빠져 있음.
    final data = {
      'id': globalUserId,
      'root': LoginRoot,
      'name': nameController.text,
      'phoneNumber': phoneNumberController.text,
      'gender' : man
    };
    final response = await ServerResponseOKTemplate('/join', data);
    if (response != null) {
      Navigator.pushNamed(context, NickName.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          '이미 가입된 회원입니다.',
          style: TextStyle(fontSize: 14),
        ),
        backgroundColor: Colors.blue[400],
      ));
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
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                '완료',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ))
        ],
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
                if(errorResponse == true)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text('정보를 정확히 입력해주세요.', style: TextStyle(color: Colors.red),),
                ),
                SizedBox(height: 25,),
                InkWell(
                  onTap: (){
                    if(nameController.text != 0 && birthdayController == 8 && phoneNumberController == 11 ){
                      sendSocialUserData();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue
                    ),
                    child: Center(
                      child: Text(
                        '다음', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), 
                        )
                      ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
