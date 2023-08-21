import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:smart_dongne/main_page/setpage.dart';
import '../../server/Server.dart';

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
  String imagePath = '';
  String imageBeforeChange = '';

  //server data
  late String userNickName;
  late String userIntroduction;
  late String userProfileImage;

  void showMenuOfPicture(context) {
    showModalBottomSheet(
        context: context,
        builder: ((context) => Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      pickImageOfCamera();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.photo_camera_rounded),
                          SizedBox(width: 18),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Camera',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    )),
                                Text('카메라로 사진찍기',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      decoration: TextDecoration.none,
                                    ))
                              ]),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      pickImageOfGallery();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.image),
                          SizedBox(width: 20),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Gallery',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    )),
                                Text('갤러리에서 사진 가져오기',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      decoration: TextDecoration.none,
                                    ))
                              ]),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      imagePath = '';
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.account_circle),
                          SizedBox(width: 20),
                          Text('기본사진 설정',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              )),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            )));
  }

  void nameTextCancelButton(controller) {
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

  Future<void> pickImageOfGallery() async {
    final imagePicker = ImagePicker();
    final galleryFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (galleryFile != null) {
      final img = await _cropImage(imageFile: File(galleryFile.path));
      Navigator.pop(context);
      if (img == null) {
      } else {
        setState(() {
          imagePath = img.path;
        });
      }
    }
  }

  Future<void> pickImageOfCamera() async {
    final imagePicker = ImagePicker();
    final cameraFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (cameraFile != null) {
      final img = await _cropImage(imageFile: File(cameraFile.path));

      Navigator.pop(context);
      if (img == null) {
      } else {
        setState(() {
          imagePath = img.path;
        });
      }
    }
  }

  Widget imageSetting() {
    if (imagePath != '') {
      return CircleAvatar(
          radius: 80, backgroundImage: FileImage(File(imagePath!)));
    } else {
      return CircleAvatar(
          radius: 80,
          backgroundColor: Colors.grey,
          backgroundImage: Image.asset(
            'image/basicprofile.png',
            width: 100, // 이미지의 가로 크기 조절
            height: 100, // 이미지의 세로 크기 조절
            fit: BoxFit.cover, // 이미지의 크기를 조절하여 CircleAvatar에 맞게 맞출지 결정 (필요에 따라 변경 가능)
          ).image);
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void getProfileViewData() async {
    final email = {'id': 'alsdnd336@naver.com'};
    final response = await profileViewData(email);
    final jsonData = jsonDecode(response);
    userNickName = jsonData['nickname'];
    userIntroduction = jsonData['info'];
    userProfileImage = jsonData['imgLocation'];
    nameTextController.text = userNickName;
    introductionController.text = userIntroduction;
    imagePath = userProfileImage;
    if (imagePath != '') {
      imageBeforeChange = imagePath!;
    }
    setState(() {});
  }

  @override
  void initState() {
    getProfileViewData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
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
            onPressed: () async {
              if (imagePath == imageBeforeChange &&
                  userIntroduction == introductionController.text &&
                  userNickName == nameTextController.text) {
                if (nameTextController.text == '') {
                  Flushbar(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    flushbarPosition: FlushbarPosition.TOP,
                    duration: Duration(seconds: 2),
                    message: '닉네임을 입력해주세요.',
                    messageSize: 15,
                    borderRadius: BorderRadius.circular(4),
                    backgroundColor: Colors.white,
                    messageColor: Colors.black,
                    boxShadows: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8,
                      ),
                    ],
                  ).show(context);
                } else {
                  Flushbar(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    flushbarPosition: FlushbarPosition.TOP,
                    duration: Duration(seconds: 2),
                    message: '변경사항을 입력해주세요.',
                    messageSize: 15,
                    borderRadius: BorderRadius.circular(4),
                    backgroundColor: Colors.white,
                    messageColor: Colors.black,
                    boxShadows: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8,
                      ),
                    ],
                  ).show(context);
                }
              } else {
                final data = {
                  'userId': 'alsdnd336@naver.com',
                  'info': introductionController.text,
                  'nickname': nameTextController.text,
                };
                final response = await profileEdit(data, imagePath);
                if(response != null){
                  Navigator.pop(context, 'editIt');
                }
              }
            },
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
                    imageSetting(),
                    TextButton(
                        onPressed: () {
                          showMenuOfPicture(context);
                        },
                        child: Text(
                          '사진 변경',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ))
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                '닉네임',
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(40),
                          ],
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            nameTextCancelButton(nameTextController);
                          },
                          maxLines: null,
                          controller: nameTextController,
                          focusNode: nameFocusNode,
                          style: TextStyle(fontSize: 16, color: Colors.black),
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(200),
                          ],
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
    );
  }
}
