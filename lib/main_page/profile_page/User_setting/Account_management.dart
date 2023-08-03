import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/phoneNumberChange.dart';
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
  late Row _genderWidget;

  TextEditingController _nameController = TextEditingController();
  late TextFormField _nameTextFormField;
  TextEditingController _birthdayController = TextEditingController();
  late TextFormField _birthdayTextFormField;
  late String currentOption;
  
  @override
  void initState() {
    super.initState();
    currentOption = options[0];
    _nameTextFormField = TextFormField(
      controller: _nameController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0)),
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
    );
    _birthdayTextFormField = TextFormField(
      maxLength: 8,
      controller: _birthdayController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0)),
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    _genderWidget = Row(
      children: [
        Expanded(
          child: RadioListTile(
            value: options[0],
            groupValue: currentOption,
            title: Text(options[0]),
            onChanged: (value){
              setState(() {
                currentOption = value!;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile(
            value: options[1],
            groupValue: currentOption,
            title: Text(options[1]),
            onChanged: (value){
              setState(() {
                currentOption = value!;
              });
            },
          ),
        )
      ],
    );

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
            nameChange == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('이름'),
                          Text(
                            'userName',
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              nameChange = !nameChange;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                          ))
                    ],
                  )
                : _nameTextFormField,
            SizedBox(
              height: 25,
            ),
            birthdayChange == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('생년월일'),
                          Text(
                            'birthday',
                            style: TextStyle(fontSize: 22),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              birthdayChange = !birthdayChange;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                          ))
                    ],
                  )
                : _birthdayTextFormField,
            SizedBox(
              height: 25,
            ),
            genderChange == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('성별'),
                          Text(
                            'userGender',
                            style: TextStyle(fontSize: 22),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              genderChange = true;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                          ))
                    ],
                  )
                : _genderWidget,
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('전화번호'),
                    Text(
                      'userNumber',
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {
                      final newPassword = Navigator.pushNamed(context, ChangePhoneNumber.routeName);
                    },
                    icon: Icon(
                      Icons.edit,
                    ))
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Divider(
              height: 1,
              color: Colors.black,
              thickness: 1,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, UserWithDrawal.rotueName);
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
