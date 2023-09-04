import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/home_page/Content_page.dart';

class PostingWidget extends StatelessWidget {
  const PostingWidget({
  required this.data,
  super.key});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    print(data);
    final contentsDate = data['date'];
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
                data['userImg'] != '' ? CircleAvatar(
                  backgroundImage: FileImage(File(data['userImg'])),
                ) : CircleAvatar(
                  backgroundImage: Image.asset('image/basicprofile.png',fit: BoxFit.cover).image,
                  backgroundColor: Colors.grey,
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
              Navigator.pushNamed(context, ShowaContents.routeName,
                  arguments: ContentArguments(data['contents'], data['userId'], data['id'],));
            },
            child: AspectRatio(
              aspectRatio: 4 / 4,
              // child: Image.file(
              //   File(data['imgLocation']),
              //   fit: BoxFit.cover,
              // ),
              child: data['imgLocation'] == '' ? 
                Image.asset('image/basiccover.jpg', fit: BoxFit.cover,) : Image.file(
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
}


