import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SocialLoginSetting extends StatefulWidget {
  const SocialLoginSetting({super.key});

  static const rotueName = '/socialLoginUserSetting';

  @override
  State<SocialLoginSetting> createState() => _SocialLoginSettingState();
}

class _SocialLoginSettingState extends State<SocialLoginSetting> {
  List<String> genderList = ['남성', '여성'];
  int GenderIsMan = 0;
  TextEditingController _controller = TextEditingController();

  void sendDataServer(){
    final bool UserGender = GenderIsMan == 0 ? true : false;
    final data = {
      'id' : 'email',
      'gender' : UserGender,
    };
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
              if(_controller.text.length == 8 ){
                sendDataServer();
              }else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 5),
                  content: Text(
                    '내용을 형식에 맞게 입력해주세요.',
                    style: TextStyle(fontSize: 14),
                  ),
                  backgroundColor: Colors.blue[400],
                ));
              }
            },
            child: Text('완료', style: TextStyle(color: Colors.blue, fontSize: 20),)
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              maxLength: 8,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly // 숫자만 입력 가능하도록 설정
              ],
              obscureText: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: '생년월일 8자리를 입력하시오',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('성별을 입력하시오', style: TextStyle(color: Colors.grey[800]),)
              ],
            ),
            SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}
