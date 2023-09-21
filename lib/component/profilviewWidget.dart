import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileviewWidget extends StatelessWidget {
  final jsonDataofprofile;
  const ProfileviewWidget({required this.jsonDataofprofile ,super.key});

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
            padding: EdgeInsets.fromLTRB(0, 12, 0, 20),
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
        ],
      ),
    );
  }
}


