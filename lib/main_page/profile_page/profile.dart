// import 'dart:collection';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/postingWidget.dart';
import 'package:smart_dongne/component/profilviewWidget.dart';
import 'package:smart_dongne/main_page/profile_page/profile_edit_page.dart';
import 'package:smart_dongne/main_page/profile_page/User_setting/setting_page.dart';
import 'package:smart_dongne/server/Server.dart';
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
  void ChangePostOrder(String order){
    dropDownValue = order;
  }

  late List<Widget> FinishedWidgetList;
  Widget? BuildFinshWidget;

  void callProfileData() async {
    // bring Profile data
    final email = {'id': globalUserId, 'token': jwtToken, 'root': LoginRoot};
    final response = await ServerResponseJsonDataTemplate('/profile', email);
    setState(() {
      jsonDataofprofile = response[0];
      userPosts = jsonDataofprofile['posts'];
    });

    if (userPosts!.isEmpty) {      
      setState(() {
        BuildFinshWidget = Center(
          child: Text('게시물이 없습니다.', style: TextStyle(color: Colors.black),),
        );
      });
    } else {
      setState(() {
        FinishedWidgetList = userPosts!
            .map<Widget>((data) => PostingWidget(data: data))
            .toList();
        BuildFinshWidget = Column(children: FinishedWidgetList);
      });
    }
  }

  void PostsSortOrder(index){
    if(index == 0){
      setState(() {
        BuildFinshWidget = Column(children: FinishedWidgetList);
      });
    }else {
      Iterable<Widget> reversedNumbers =
          FinishedWidgetList.reversed;
      setState(() {
        BuildFinshWidget = Column(
          children: reversedNumbers.toList(),
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
    return jsonDataofprofile == null ? Center(
      child: CircularProgressIndicator(color: Colors.blue),) : Scaffold(
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
          ProfileviewWidget(jsonDataofprofile: jsonDataofprofile,),
          SortOrderWidget(changeSort: PostsSortOrder),
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