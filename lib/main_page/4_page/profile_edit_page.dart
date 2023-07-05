import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

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
  bool keyboardActivation = false;
  File? imagePath;

  void showMenuOfPicture(context) {
    print('showMenuOfpicture 실행');
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            margin: EdgeInsets.only(bottom: 50.0),
            height: MediaQuery.of(context).size.height * 0.24,
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.grey))),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      '프로필 사진 설정',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          '앨범에서 사진 선택',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          '카메라로 사진 찍기',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          '취소',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final cameraFile = await imagePicker.pickImage(source: ImageSource.camera);
    final galleryFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (cameraFile != null) {
      setState(() {
        imagePath = File(cameraFile.path);
      });
    }
    if (galleryFile != null) {
      setState(() {
        imagePath = File(galleryFile.path);
      });
    }
    // widget.addImageFunc(File(imagePath!));
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).addListener(() {
      if (nameFocusNode.hasFocus || introductionFocusNdoe.hasFocus) {
        // KeyPad가 나타날 때 실행할 코드
        setState(() {
          keyboardActivation = true;
        });
      } else {
        // KeyPad가 사라질 때 실행할 코드
        setState(() {
          keyboardActivation = false;
        });
      }
    });

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
      body: Column(
        children: [
          Expanded(
            child: Padding(
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
                              onPressed: () {
                                showMenuOfPicture(context);
                              },
                              child: Text(
                                '사진 변경',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
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
                                keyboardType: TextInputType.text,
                                onChanged: (text) {
                                  nameTextCencelButton(nameTextController);
                                },
                                maxLines: null,
                                controller: nameTextController,
                                focusNode: nameFocusNode,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                cursorColor: Colors.blue,
                                backgroundCursorColor: Colors.blue),
                          ),
                          IconButton(
                              onPressed: () {
                                if (nameCancelButton == true) {
                                  nameTextController.clear();
                                  setState(() {
                                    nameCancelButton = false;
                                  });
                                }
                              },
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
                                  introdutionCancelButton(
                                      introductionController);
                                },
                                maxLines: null,
                                controller: introductionController,
                                focusNode: introductionFocusNdoe,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                cursorColor: Colors.blue,
                                backgroundCursorColor: Colors.blue),
                          ),
                          IconButton(
                              onPressed: () {
                                if (introduction == true) {
                                  introductionController.clear();
                                  setState(() {
                                    introduction = false;
                                  });
                                }
                              },
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
          ),
          if (keyboardActivation == true)
            Container(
              color: Colors.grey[200],
              height: 40,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (!nameFocusNode.hasFocus) {
                              FocusScope.of(context)
                                  .requestFocus(nameFocusNode);
                            }
                          },
                          child: Icon(
                            Icons.arrow_upward_rounded,
                            color: Colors.blue,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (!introductionFocusNdoe.hasFocus) {
                              FocusScope.of(context)
                                  .requestFocus(introductionFocusNdoe);
                            }
                          },
                          child:
                              Icon(Icons.arrow_downward, color: Colors.blue)),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: Text(
                        '완료',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ),
        ],
      ),
    );
  }
}
