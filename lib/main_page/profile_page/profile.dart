import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/profile_page/profile_edit_page.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/setting_page.dart';

import '../../server/Server.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? imagePath;
  dynamic jsonData;

  Widget imageSetting() {
    if (imagePath != null) {
      return CircleAvatar(radius: 80, backgroundImage: FileImage(imagePath!));
    } else {
      return CircleAvatar(
        radius: 80,
        backgroundColor: Colors.grey,
        child: Image.asset(
          'image/basicprofile.png',
          width: 100, // 이미지의 가로 크기 조절
          height: 100, // 이미지의 세로 크기 조절
          fit: BoxFit
              .cover, // 이미지의 크기를 조절하여 CircleAvatar에 맞게 맞출지 결정 (필요에 따라 변경 가능)
        ),
      );
    }
  }

  void callProfileData() async {
    final email = {'id': 'alsdnd336@naver.com'};
    final response = await profileData(email);
    setState(() {
      jsonData = jsonDecode(response);
    });
  }

  @override
  void initState() {
    super.initState();
    callProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return jsonData == null
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
              backgroundColor: Colors.grey,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('프로필'),
              backgroundColor: Colors.white,
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ProfileEdit.routeName,
                          arguments: UserInformation(jsonData['nickname'],
                              jsonData['info'], jsonData['imgLocation']));
                    },
                    child: Text('편집',
                        style: TextStyle(color: Colors.blue, fontSize: 20))),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, UserSetting.routeName);
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.grey[700],
                    ))
              ],
            ),
            body: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      imageSetting(),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jsonData['nickname'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              jsonData['info'] == null
                                  ? '소개글을 입력해주세요'
                                  : jsonData['info'],
                              maxLines: null,
                              textAlign: TextAlign.start,
                              style: jsonData['info'] == null
                                  ? TextStyle(fontSize: 15, color: Colors.grey)
                                  : TextStyle(
                                      fontSize: 15, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: '독자: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '198',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 25,
                              ),
                            ),
                          ]),
                        ),
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: '글쓴이: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '127',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 25,
                              ),
                            ),
                          ]),
                        )
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    color: Colors.grey,
                    height: 1,
                    thickness: 1,
                    indent: 5,
                    endIndent: 5,
                  ),
                ),
              ],
            ),
          );
  }
}
