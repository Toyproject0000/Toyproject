import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});
  static const routeName = '/profileEdit';

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController introductionController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode introductionFocusNdoe = FocusNode();
  bool nameCancelButton = false;
  bool introduction = false;

  void nameTextCencelButton(controller) {
    if (controller.text.isEmpty) {
      setState(() {
        nameCancelButton = false;
      });
    } else {
      setState(() {
        nameCancelButton = true;
      });
    }
  }

  void introdutionCancelButton(controller) {
    if (controller.text.isEmpty) {
      setState(() {
        introduction = false;
      });
    } else {
      setState(() {
        introduction = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('프로필 편집'),
        leading: TextButton(
          child:
              Text('취소', style: TextStyle(color: Colors.black, fontSize: 16)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            child:
                Text('완료', style: TextStyle(color: Colors.blue, fontSize: 16)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('image/personicon.png'),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          '사진 변경',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ))
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                '사용자 이름',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      child: EditableText(
                          onChanged: (text) {
                            nameTextCencelButton(nameTextController);
                          },
                          maxLines: null,
                          controller: nameTextController,
                          focusNode: nameFocusNode,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          cursorColor: Colors.blue,
                          backgroundCursorColor: Colors.blue),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.cancel,
                          color: nameCancelButton == true
                              ? Colors.black
                              : Colors.white,
                        ))
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 1,
                  indent: 1,
                  endIndent: 1,
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                '소개글',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      child: EditableText(
                          onChanged: (text) {
                            introdutionCancelButton(introductionController);
                          },
                          maxLines: null,
                          controller: introductionController,
                          focusNode: introductionFocusNdoe,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          cursorColor: Colors.blue,
                          backgroundCursorColor: Colors.blue),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.cancel,
                          color: introduction == true
                              ? Colors.black
                              : Colors.white,
                        )),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 1,
                  indent: 1,
                  endIndent: 1,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
