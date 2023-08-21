// import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/profile_page/profile_edit_page.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/setting_page.dart';

import '../../server/Server.dart';
import '../home_page/Content_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? imagePath;
  dynamic jsonData;
  dynamic jsonDataofprofile;
  List? userPosts;

  String dropDownValue = '최신순';
  List<String> dropDownList = ['최신순', '오래된 순'];

  late List<Container> FinishedWidgetList;
  Column? BuildFinshWidget;

  Widget imageSetting() {
    if (jsonDataofprofile['imgLocation'] != '') {
      return CircleAvatar(radius: 80, backgroundImage: FileImage(File(jsonDataofprofile['imgLocation'])));
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

  Container MakeaPosting(data) {
    final contentsDate = data['date'];
    final PostingContent = data['contents'];
    return Container(
      child: Column(
        children: [
          Divider(
            color: Colors.black,
            height: 0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Text(data['nickname'], style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Text(
                  '제목:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  data['title'],
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ShowaContents.routeName,
                  arguments: ContentArguments(PostingContent));
            },
            child: AspectRatio(
              aspectRatio: 4 / 4,
              child: Image.file(
                File(data['imgLocation']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.all(7),
              child: Row(
                children: [Text(contentsDate.substring(0, 10))],
              )),
        ],
      ),
    );
  }

  Future<void> callProfileData() async {
    final email = {'id': 'alsdnd336@naver.com'};
    final response = await profileData(email);
    jsonData = jsonDecode(response);
    jsonDataofprofile = jsonData[0];
    userPosts = jsonDataofprofile['posts'];
    FinishedWidgetList =
        userPosts!.map<Container>((data) => MakeaPosting(data)).toList();
    BuildFinshWidget = Column(children: FinishedWidgetList);
    setState(() {});
  }

  

  @override
  void initState() {
    callProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return jsonData == null ? Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    ) : Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('프로필'),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () async {
                final EditPageResponse = await Navigator.pushNamed(context, ProfileEdit.routeName);
                if(EditPageResponse != null){
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
                        jsonDataofprofile['info'] == null
                            ? '소개글을 입력해주세요'
                            : jsonDataofprofile['info'],
                        maxLines: null,
                        textAlign: TextAlign.start,
                        style: jsonDataofprofile['info'] == null
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButton<String>(
                value: dropDownValue,
                icon: Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue){
                  setState(() {
                    dropDownValue = newValue!;
                  });
                },
                items: [
                  DropdownMenuItem<String>(
                    value: dropDownList[0],
                    child: Text(dropDownList[0]),
                    onTap: (){
                      setState(() {
                        BuildFinshWidget = Column(children :FinishedWidgetList);
                      });
                    }, 
                  ),
                  DropdownMenuItem<String>(
                    value: dropDownList[1],
                    child: Text(dropDownList[1]),
                     onTap: (){
                        Iterable<Container> reversedNumbers = FinishedWidgetList.reversed;
                      setState(() {
                        BuildFinshWidget = Column(children: reversedNumbers.toList(),);
                      });
                    },
                  ),
                ],  
              )
            ],
          ),
          BuildFinshWidget == null ? Center(child: CircularProgressIndicator(
            color: Colors.blue,
            backgroundColor: Colors.grey,
          ),) : BuildFinshWidget!,
        ],
      ),
    );
  }
}
