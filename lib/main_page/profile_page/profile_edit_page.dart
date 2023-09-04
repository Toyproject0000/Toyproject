import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:smart_dongne/component/myShowDialog.dart';
import 'package:smart_dongne/server/chatServer.dart';
import 'package:smart_dongne/server/userId.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});
  static const routeName = '/profileEdit';

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController introductionController = TextEditingController();
  MyShowDialog? myShowDialog;

  FocusNode introductionFocusNdoe = FocusNode();
  bool nameCancelButton = false;
  bool introduction = false;
  bool keyboardActivation = false;
  String imagePath = '';
  String imageBeforeChange = '';

  //server data
  String userIntroduction = '';
  String userProfileImage = '';
  String userNickname = '';

  void introdutionCancelButton() {
    if (introductionController.text.isEmpty) {
      setState(() {
        introduction = false;
      });
    } else {
      setState(() {
        introduction = true;
      });
    }
  }

  void ChangedImage(changeImagePath){
    setState(() {
      imagePath = changeImagePath;
    });
  }

  // imageSelect Way
  // Future<void> pickImageOfGallery() async {
  //   final imagePicker = ImagePicker();
  //   final galleryFile =
  //       await imagePicker.pickImage(source: ImageSource.gallery);
  //   if (galleryFile != null) {
  //     final img = await _cropImage(imageFile: File(galleryFile.path));
  //     Navigator.pop(context);
  //     if (img == null) {
  //     } else {
  //       setState(() {
  //         imagePath = img.path;
  //       });
  //     }
  //   }
  // }

  // void SelectbasicImage() {
  //   setState(() {
  //     imagePath = '';
  //   });
  // }

  // Future<void> pickImageOfCamera() async {
  //   final imagePicker = ImagePicker();
  //   final cameraFile = await imagePicker.pickImage(source: ImageSource.camera);

  //   if (cameraFile != null) {
  //     final img = await _cropImage(imageFile: File(cameraFile.path));

  //     Navigator.pop(context);
  //     if (img == null) {
  //     } else {
  //       setState(() {
  //         imagePath = img.path;
  //       });
  //     }
  //   }
  // }

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
            fit: BoxFit
                .cover, // 이미지의 크기를 조절하여 CircleAvatar에 맞게 맞출지 결정 (필요에 따라 변경 가능)
          ).image);
    }
  }

  // Future<File?> _cropImage({required File imageFile}) async {
  //   CroppedFile? croppedImage =
  //       await ImageCropper().cropImage(sourcePath: imageFile.path);
  //   if (croppedImage == null) return null;
  //   return File(croppedImage.path);
  // }

  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)!.settings.arguments as ProfileEditArgument;

    // argument allocations
    userIntroduction = args.info;
    userProfileImage = args.imgLocation;
    userNickname = args.nickname;
    introductionController.text = userIntroduction;

    // showDialog instance
    myShowDialog = MyShowDialog(context: context, changeImagePath: ChangedImage);
    super.didChangeDependencies();
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
                  userIntroduction == introductionController.text) {
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
              } else {
                final data = {
                  'userId': 'alsdnd336@naver.com',
                  'info': introductionController.text,
                  'token': jwtToken
                };
                final response = await ServerSendImageDataTemplate(
                    '/profile/set', data, imagePath);
                print(response);
                if (response != null) {
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
                          myShowDialog!.showMenuOfPicture();    
                        },
                        child: Text(
                          '사진 변경',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ))
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                userNickname,
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
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
                            introdutionCancelButton();
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

class ProfileEditArgument {
  final String info;
  final String imgLocation;
  final String nickname;

  ProfileEditArgument(
      {required this.info, required this.imgLocation, required this.nickname});
}
