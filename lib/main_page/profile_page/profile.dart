// import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/postingWidget.dart';
import 'package:smart_dongne/main_page/profile_page/profile_edit_page.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/setting_page.dart';
import 'package:smart_dongne/server/chatServer.dart';
import 'package:smart_dongne/server/userId.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? imagePath;
  dynamic jsonDataofprofile;
  List? userPosts;

  String dropDownValue = '최신순';
  List<String> dropDownList = ['최신순', '오래된 순'];

  late List<Widget> FinishedWidgetList;
  Widget? BuildFinshWidget;

  Widget imageSetting() {
    if (jsonDataofprofile['imgLocation'] != '') {
      return CircleAvatar(
          radius: 80,
          backgroundImage: FileImage(File(jsonDataofprofile['imgLocation'])));
    } else {
      return CircleAvatar(
        radius: 80,
        backgroundColor: Colors.grey,
        backgroundImage: Image.asset(
          'image/basicprofile.png',
          width: 100, // 이미지의 가로 크기 조절
          height: 100, // 이미지의 세로 크기 조절
          fit: BoxFit
              .cover, // 이미지의 크기를 조절하여 CircleAvatar에 맞게 맞출지 결정 (필요에 따라 변경 가능)
        ).image,
      );
    }
  }

  Future<void> callProfileData() async {
    // bring Profile data
    final email = {'id': globalUserId, 'token': jwtToken, 'root': LoginRoot};
    final response = await ServerResponseJsonDataTemplate('/profile', email);

    jsonDataofprofile = response[0];
    userPosts = jsonDataofprofile['posts'];
    if (userPosts != []) {
      setState(() {
        FinishedWidgetList = userPosts!
            .map<Widget>((data) => PostingWidget(data: data))
            .toList();
        BuildFinshWidget = Column(children: FinishedWidgetList);
      });
    } else {
      setState(() {
        BuildFinshWidget = Center(
          child: Text('게시물이 없습니다.'),
        );
      });
    }
  }

  @override
  void initState() {
    callProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return jsonDataofprofile == null
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: Container(),
              title: Text('프로필'),
              centerTitle: true,
              backgroundColor: Colors.white,
              actions: [
                TextButton(
                    onPressed: () async {
                      final EditPageResponse = await Navigator.pushNamed(
                          context, ProfileEdit.routeName,
                          arguments: ProfileEditArgument(
                              imgLocation: jsonDataofprofile['imgLocation'],
                              info: jsonDataofprofile['info'],
                              nickname: jsonDataofprofile['nickname']));
                      if (EditPageResponse != null) {
                        callProfileData();
                      }
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
                            jsonDataofprofile['nickname'],
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
                              jsonDataofprofile['info'] == ''
                                  ? '소개글을 입력해주세요'
                                  : jsonDataofprofile['info'],
                              maxLines: null,
                              textAlign: TextAlign.start,
                              style: jsonDataofprofile['info'] == ''
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
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
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
                              text: jsonDataofprofile['follower'].toString(),
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
                              text: jsonDataofprofile['following'].toString(),
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 25,
                              ),
                            ),
                          ]),
                        )
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton<String>(
                      value: dropDownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: dropDownList[0],
                          child: Text(dropDownList[0]),
                          onTap: () {
                            setState(() {
                              BuildFinshWidget =
                                  Column(children: FinishedWidgetList);
                            });
                          },
                        ),
                        DropdownMenuItem<String>(
                          value: dropDownList[1],
                          child: Text(dropDownList[1]),
                          onTap: () {
                            Iterable<Widget> reversedNumbers =
                                FinishedWidgetList.reversed;
                            setState(() {
                              BuildFinshWidget = Column(
                                children: reversedNumbers.toList(),
                              );
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
                BuildFinshWidget == null
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                          backgroundColor: Colors.grey,
                        ),
                      )
                    : BuildFinshWidget!
              ],
            ),
          );
  }
}
