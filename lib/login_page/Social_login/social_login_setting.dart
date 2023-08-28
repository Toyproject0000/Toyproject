import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  List<String> genderList = ['남성', '여성'];
  int GenderIsMan = 0;
  final formKey = GlobalKey<FormState>();
  bool responseError = false;
  List<String> userDataList = ['','',''];
  List<Icon> IconList = [Icon(Icons.person), Icon(Icons.phone), Icon(Icons.calendar_month_rounded)];
  List<String> hintTextList = ['이름', '전화번호', '생년월일(8자리)'];
  
  void sendSocialUserData(String name, String phoneNumber, String birth) async {
    final bool UserGender = GenderIsMan == 0 ? true : false;
    final data = {
      'id' : globalUserId,
      'root' : LoginRoot,
      'name' : name,
      'phoneNumber' : phoneNumber,
      'gender' : UserGender
    };
    print(data);
    final response = await ServerResponseOKTemplate('/join', data);
    if(response != null){
      Navigator.pushNamed(context, NickName.routeName);
    }else{
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

  void _tryValidation(){
    final isValid = formKey.currentState!.validate();
    if(isValid){
      formKey.currentState!.save();
      sendSocialUserData(userDataList[0], userDataList[1], userDataList[2]);
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
            onPressed: (){
              _tryValidation();
            },
            child: Text('완료', style: TextStyle(color: Colors.blue, fontSize: 20),)
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  for(int i = 0; i < 3; i++ )
                  TextFormField(
                    inputFormatters: i != 0 ? [FilteringTextInputFormatter.digitsOnly] : null,
                    decoration: InputDecoration(
                      hintText: hintTextList[i],
                      prefixIcon: IconList[i],
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1
                        )
                      ),
                      focusColor: Colors.grey,
                    ),
                    validator: (value){
                      if(i == 0){
                        if(value!.isEmpty){
                          return '이름을 작성해주세요';
                        }
                        return null;
                      }else if(i == 1){
                        if(value!.length < 11){
                          return '전화번호를 올바르게 작성해주세요.';
                        }
                        return null;
                      }else{
                        if(value!.length < 8){
                          return '생년 월일 8자리를 입력해주세요';
                        }
                        return null;
                      }
                    },
                    onSaved: (value){
                      userDataList[i] = value!;
                    },
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: ToggleSwitch(
                minWidth: double.infinity,
                initialLabelIndex: 0,
                cornerRadius: 5.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                labels: genderList,
                icons: [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
                activeBgColors: [
                  [Colors.blue],
                  [Colors.blue]
                ],
                onToggle: (index) {
                  GenderIsMan = index!;
                },
              ),
            ),
            SizedBox(height: 15,),
            if(responseError == true)
            Text('형식을 올바르게 작성해주세요', style: TextStyle(color: Colors.red),)
          ],
        ),
      ),
    );
  }
}
