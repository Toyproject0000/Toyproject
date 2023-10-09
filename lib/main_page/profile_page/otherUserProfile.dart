import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/postingWidget.dart';
import 'package:smart_dongne/component/profilviewWidget.dart';
import 'package:smart_dongne/main_page/UserReportandCutoff.dart';
import 'package:smart_dongne/main_page/chatting_page/chatting_Content.dart';
import 'package:smart_dongne/main_page/profile_page/subscribileWidget.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class OtherUserProfile extends StatefulWidget {
  final String id;
  final String root;
  final String nickname;

  const OtherUserProfile(
      {required this.id,
      required this.root,
      required this.nickname,
      super.key});

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  // need
  dynamic jsonDataofprofile;
  dynamic userPosts;
  List<Widget> FinishedWidgetList = [];
  Widget? BuildFinshWidget;
  UserReportAndCutoff? userReportAndCutoff;
  ScrollController _controller = ScrollController();

  // 원래는  null 넣을 자리
  bool subscibing = true;

  // call server data
  Future<void> callProfileData() async {
    // bring Profile data
    final email = {'id': widget.id, 'token': jwtToken, 'root': widget.root};
    final response = await ServerResponseJsonDataTemplate('/profile', email);
    setState(() {
      jsonDataofprofile = response[0];
      userPosts = jsonDataofprofile['posts'];
      // 구독 중인지 아닌지 넣는 자리
    });
  }

  void UserSubscription(bool boolData) async {
    final data = {
      'token': jwtToken,
      'followingUserId': globalUserId,
      'followingUserRoot': LoginRoot,
      'followedUserId': widget.id,
      'followedUserRoot': widget.root
    };
    String address = boolData != false ? '/follow/add' : '/follow/remove';
    String responseValue = boolData != false ? '구독이 추가되었습니다.' : '구독이 취소되었습니다.';
    final response = await ServerResponseOKTemplate(address, data);
    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(responseValue), duration: Duration(seconds: 1)));
    }
  }

  void _onScrollEnd() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      print('실행 준비 완료');
    }
  }


  @override
  void initState() {
    callProfileData();
    _controller.addListener(_onScrollEnd);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_onScrollEnd);
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    userReportAndCutoff = UserReportAndCutoff(context);
    return jsonDataofprofile == null
        ? Center(
            child: CircularProgressIndicator(color: Colors.blue),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios),
              ),
              backgroundColor: Colors.white,
              elevation: 1,
              title: Text(widget.nickname,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              actions: [
                PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              onTap: () => userReportAndCutoff!
                                  .makeReportReason(widget.id, widget.root),
                              child: Text('신고')),
                          PopupMenuItem(
                              onTap: () => userReportAndCutoff!
                                  .userCutOff(widget.id, widget.root),
                              child: Text('차단'))
                        ])
              ],
            ),
            body: RefreshIndicator(
              onRefresh: callProfileData,
              child: ListView.builder(
                  itemCount: userPosts.length + 1,
                  itemBuilder: (context, index) {
                    if (userPosts.isEmpty) {
                      return Column(
                        children: [
                          SubsribileWidget(
                              boolfactor: subscibing,
                              onTap: UserSubscription),
                          ProfileviewWidget(
                            jsonDataofprofile: jsonDataofprofile,
                          ),
                          Center(
                            child: Text(
                              '게시물이 없습니다.',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      );
                    } else {
                      if (index < userPosts.length) {
                        if (index == 0) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //subScript button
                                    SubsribileWidget(
                                        boolfactor: subscibing,
                                        onTap: UserSubscription),
                                    // messagePageMove button
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChattingContent(
                                                        sendUser:
                                                            globalNickName,
                                                        acceptUser:
                                                            widget.nickname
                                                            )));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                20,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black,
                                        ),
                                        child: Text(
                                          '메세지 보내기',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ProfileviewWidget(
                                jsonDataofprofile: jsonDataofprofile,
                              ),
                              PostingWidget(data: userPosts[index]),
                            ],
                          );
                        }
                        return PostingWidget(data: userPosts[index]);
                      } else {
                        return Center(
                          child: CircularProgressIndicator(color: Colors.blue),
                        );
                      }
                    }
                  }),
            ),
          );
  }
}
