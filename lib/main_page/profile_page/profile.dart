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
  List userPosts = [];
  ScrollController _controller = ScrollController();

  String dropDownValue = '최신순';
  void ChangePostOrder(String order){
    dropDownValue = order;
  }

  late List<Widget> FinishedWidgetList;
  Widget? BuildFinshWidget;

  Future<void> callProfileData() async {
    // bring Profile data
    final email = {'id': globalUserId, 'token': jwtToken, 'root': LoginRoot};
    final response = await ServerResponseJsonDataTemplate('/profile', email);
    setState(() {
      jsonDataofprofile = response[0];
      userPosts = jsonDataofprofile['posts'];
    });
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
    _controller.addListener(_onScrollEnd);
  }

  @override
  void dispose() {
    _controller.removeListener(_onScrollEnd);
    _controller.dispose();
    super.dispose();
  }

  void _onScrollEnd() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      print('실행 준비 완료');
    }
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
      body: RefreshIndicator(
        onRefresh: callProfileData,
        child: ListView.builder(
          itemCount: userPosts.length + 1,
          itemBuilder: (context, index){
            if(userPosts.isEmpty){
              return Column(
                children: [
                  ProfileviewWidget(jsonDataofprofile: jsonDataofprofile,),
                  Center(child: Text('게시물이 없습니다.', style: TextStyle(color: Colors.black),),)
                ],
              );
            } else {
              if (index < userPosts.length){
                if(index == 0){
                  return Column(
                    children: [
                      ProfileviewWidget(jsonDataofprofile: jsonDataofprofile,),
                      PostingWidget(data: userPosts[index]),
                    ],
                  );
                }
                return PostingWidget(data: userPosts[index]);
              }else {
                return Center(child: CircularProgressIndicator(color: Colors.blue),);
              }
            }

          }
      ),
      ),
          
    );
  }
}