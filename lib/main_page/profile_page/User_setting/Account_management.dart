import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_dongne/component/genderButton.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/userWithdrawal.dart';

class AccountManagement extends StatefulWidget {
  const AccountManagement({super.key});
  static const routeName = '/userSetting/accountManagement';

  @override
  State<AccountManagement> createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {
  bool changeData = false;
  bool nameChange = false;
  bool birthdayChange = false;
  bool genderChange = false;

  bool man = true;
  List<String> options = ['남성', '여성'];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  late String currentOption;

  void togetServerData() async {

  }

  void ChangeGender(bool data){
    man = data;
  }
  
  @override
  void initState() {
    super.initState();
    currentOption = options[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('계정 정보'),
        actions: [
          TextButton(
              onPressed: () {
                if (changeData == false) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text(
                      '변경사항을 입력해주세요.',
                      style: TextStyle(fontSize: 15),
                    ),
                  ));
                }
              },
              child: Text(
                '저장',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '기본 정보',
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('이름', style: TextStyle(fontSize: 15, color: Colors.black),),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey
                      )
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1
                      ),
                    )
                  ),
                  cursorColor: Colors.blue,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('생년월일', style: TextStyle(fontSize: 15, color: Colors.black),),
                TextFormField(
                  maxLength: 8,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // 숫자만 허용
                  ],
                  controller: _birthdayController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey
                      )
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1
                      ),
                    )
                  ),
                  cursorColor: Colors.blue,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('성별', style: TextStyle(fontSize: 15, color: Colors.black),),
                SizedBox(height: 10,),
                MyGenderButton(ChangeGender: ChangeGender, currentGender: man,)
              ],
            ),

            SizedBox(
              height: 30,
            ),
            
            InkWell(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserWithDrawal())
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.outbond_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '계정 탈퇴하기',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
