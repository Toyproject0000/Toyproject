import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_dongne/main_page/writing_page/cover.dart';
import 'package:smart_dongne/main_page/writing_page/writing_page.dart';

class LastSetting extends StatefulWidget {
  const LastSetting({super.key});

  static const routeName = '/LastSetting';

  @override
  State<LastSetting> createState() => _LastSettingState();
}

class _LastSettingState extends State<LastSetting> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  List<bool> ButtonColorList = [];
  Color backGroundColor = Color(0xFF98DFFF);
  String title = '';
  late String contents;

  bool buttonColor1 = false;
  bool buttonColor2 = false;
  bool buttonColor3 = false;
  bool buttonColor4 = false;
  Row? dropDownValue;
  bool commentvalue = false;
  bool numberoflike = false;
  int disclosureindex = 0;

  List<String> settingRange = [
    '모두 공개',
    '독자만 공개',
    '비공개',
  ];

  bool selectCover = false;

  String? imagePath;

  String? _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      return title;
    }
    return null;
  }

  Future<void> cameraImage() async {
    Navigator.pop(context);
    final imagePicker = ImagePicker();
    final pickerFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickerFile != null) {
      setState(() {
        imagePath = pickerFile.path;
        selectCover = true;
      });
      Navigator.pushNamed(context, CoverPage.routeName,
          arguments: ScreenArguments(imagePath!));
    }
  }

  void sendDateServer() {
    final titleString = _tryValidation();

    if (titleString == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text('제목을 입력해주세요.'),
      ));
    } else if (selectCover == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text('표지를 선택해 주세요.'),
      ));
    } else if (buttonColor1 == false &&
        buttonColor2 == false &&
        buttonColor3 == false &&
        buttonColor4 == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text('주제를 선택해주세요.'),
      ));
    } else {
      // 서버에 데이터 보내기
    }
  }

  Future<void> galleryImage() async {
    Navigator.pop(context);

    final imagePicker = ImagePicker();
    final pickerFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      setState(() {
        imagePath = pickerFile.path;
        selectCover = true;
      });

      Navigator.pushNamed(context, CoverPage.routeName,
          arguments: ScreenArguments(imagePath!));
    }
  }

  void showMenuOfPicture(context) {
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
              color: Colors.grey[300],
            ),
            margin: EdgeInsets.only(bottom: 50.0),
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    cameraImage();
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
                                  )),
                            ]),
                      ],
                    ),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    galleryImage();
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
                      Navigator.pop(context);
                      selectCover = true;
                      Navigator.pushNamed(context, CoverPage.routeName);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 20),
                          Text(
                            '기본제공 사진 설정',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  List<Row> disclosureList = [
    Row(
      children: [
        Icon(Icons.public),
        SizedBox(
          width: 15,
        ),
        Text('모두공개'),
      ],
    ),
    Row(
      children: [
        Icon(Icons.group_sharp),
        SizedBox(
          width: 15,
        ),
        Text('독자만 공개'),
      ],
    ),
    Row(
      children: [
        Icon(Icons.lock),
        SizedBox(
          width: 15,
        ),
        Text('비공개'),
      ],
    )
  ];

  @override
  void initState() {
    super.initState();
    dropDownValue = disclosureList[0];
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Contents;
    contents = args.content;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '새 게시물',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              sendDateServer();
            },
            child: Text(
              '완료',
              style: TextStyle(
                color: Colors.blue[600],
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1.0),
            )),
            child: Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return '제목을 입력해주세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    title = value!;
                  });
                },
                maxLength: 40,
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  hintText: '제목을 입력하시오.',
                  focusedBorder: InputBorder.none,
                ),
                cursorColor: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showMenuOfPicture(context);
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '표지 선택하기',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1.0),
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '주제선택',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            buttonColor1 = true;
                            buttonColor2 = false;
                            buttonColor3 = false;
                            buttonColor4 = false;
                          });
                        },
                        child: Text(
                          '소설',
                          style: TextStyle(
                              color: buttonColor1 == false
                                  ? Colors.grey
                                  : Colors.blue),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            buttonColor1 = false;
                            buttonColor2 = true;
                            buttonColor3 = false;
                            buttonColor4 = false;
                          });
                        },
                        child: Text(
                          '일기',
                          style: TextStyle(
                              color: buttonColor2 == false
                                  ? Colors.grey
                                  : Colors.blue),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            buttonColor1 = false;
                            buttonColor2 = false;
                            buttonColor3 = true;
                            buttonColor4 = false;
                          });
                        },
                        child: Text(
                          '동기부여',
                          style: TextStyle(
                              color: buttonColor3 == false
                                  ? Colors.grey
                                  : Colors.blue),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            buttonColor1 = false;
                            buttonColor2 = false;
                            buttonColor3 = false;
                            buttonColor4 = true;
                          });
                        },
                        child: Text(
                          '지식',
                          style: TextStyle(
                              color: buttonColor4 == false
                                  ? Colors.grey
                                  : Colors.blue),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1.0),
            )),
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '공개 범위',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                DropdownButton<Row>(
                    value: dropDownValue,
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                    ),
                    items: disclosureList.map((Row value) {
                      return DropdownMenuItem<Row>(
                        value: value,
                        child: value,
                      );
                    }).toList(),
                    onChanged: (Row? newValue) {
                      setState(() {
                        disclosureindex = disclosureList.indexOf(newValue!);
                        dropDownValue = newValue;
                        print(settingRange[disclosureindex]);
                      });
                    }),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1.0),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '댓글 기능 비활성화',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Switch(
                    value: commentvalue,
                    onChanged: (onChanged) {
                      setState(() {
                        commentvalue = onChanged;
                      });
                    },
                    activeTrackColor: Colors.blue,
                    activeColor: backGroundColor,
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '좋아요 수 비공개',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Switch(
                  value: numberoflike,
                  onChanged: (onChanged) {
                    setState(() {
                      numberoflike = onChanged;
                    });
                  },
                  activeTrackColor: Colors.blue,
                  activeColor: backGroundColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Contents {
  final String content;

  Contents(this.content);
}