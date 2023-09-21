import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/component/timeWidget.dart';
import 'package:smart_dongne/main_page/home_page/Content_page.dart';
import 'package:smart_dongne/main_page/profile_page/otherUserProfile.dart';
import 'package:smart_dongne/provider/setPageData.dart';
import 'package:smart_dongne/server/userId.dart';

class PostingWidget extends StatelessWidget {
  PostingWidget({required this.data, super.key});
  final Map<String, dynamic> data;

  void moveProfilePage(setPageProvider, context) {
    if (data['userId'] == globalUserId && data['root'] == LoginRoot) {
      setPageProvider.ChangeScreen(3);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtherUserProfile(
                    id: data['userId'],
                    root: data['root'],
                    nickname: data['nickname'],
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    SetPageProvider _setPageProvider = Provider.of<SetPageProvider>(context);
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
                GestureDetector(
                  onTap: () => moveProfilePage(_setPageProvider, context),
                  child: data['userImg'] != ''
                      ? CircleAvatar(
                          backgroundImage: FileImage(File(data['userImg'])),
                        )
                      : CircleAvatar(
                          backgroundImage: Image.asset('image/basicprofile.png',
                                  fit: BoxFit.cover)
                              .image,
                          backgroundColor: Colors.grey,
                        ),
                ),
                SizedBox(
                  width: 10,
                ),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ShowaContents(
                  contents: data['contents'],
                  id: data['id'],
                  userId: data['userId'],
                  userRoot: data['root'],
                );
              }));
            },
            child: AspectRatio(
              aspectRatio: 4 / 4,
              child: data['imgLocation'] == ''
                  ? Image.asset(
                      'image/basiccover.jpg',
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(data['imgLocation']),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.all(7),
              child: Row(
                children: [
                  TimeWidget(contentsTime: data['date']),
                ],
              )),
        ],
      ),
    );
  }
}
