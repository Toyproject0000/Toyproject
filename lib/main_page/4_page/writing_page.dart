import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_dongne/main_page/4_page/writing_tool.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  TextEditingController bodyController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  bool usertouch = false;
  Widget? completionTool;
  double? containerHeight;
  File? imagePath;
  bool barActivation = false;
  FocusNode? newFocusNode;

  final GlobalKey _widgetKey = GlobalKey();

  void showImageMenu(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox; // 더 공부하기
    final RenderBox widgetBox =
        _widgetKey.currentContext!.findRenderObject() as RenderBox;
    final Offset widgetPosition =
        widgetBox.localToGlobal(Offset.zero); // 상대 위치를 절대 위치로 변경

    final List<PopupMenuEntry> menuItems = [
      PopupMenuItem(child: Text('사진 찍기')),
      PopupMenuItem(child: Text('갤러리에서 가져오기')),
      PopupMenuItem(child: Text('파일 선택')),
    ];

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        widgetPosition.dx, // 왼쪽
        widgetPosition.dy + widgetBox.size.height, // 위쪽
        overlay.size.width - widgetPosition.dx - widgetBox.size.width, // 오른쪽
        overlay.size.height - widgetPosition.dy, // 아래쪽
      ),
      items: menuItems,
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = File(pickedFile.path);
      });
    }
  }

  void removeLastWidget() {
    setState(() {
      if (widgetList.isNotEmpty) {
        widgetList.removeLast();
      }
    });
  }

  void maketool(int index, bool barActivation) {
    if (barActivation == true) {
      setState(() {
        completionTool = detailedTools[index];
        containerHeight = 50;
      });
    } else {
      setState(() {
        completionTool = null;
      });
    }
  }

  void addWidgetToColumn() {
    final TextEditingController newController = TextEditingController();
    final FocusNode newFocusNode = FocusNode();
    setState(() {
      widgetList.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: EditableText(
            keyboardType: TextInputType.text,
            backgroundCursorColor: Colors.black,
            cursorColor: Colors.black,
              onEditingComplete: () {
                print('함수가 실행됬다.');
                addWidgetToColumn();
                // FocusScope.of(context).requestFocus(newFocusNode);
              },
            controller: newController,
            focusNode: newFocusNode,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            onChanged: (text) {
              if (text.isEmpty) {
                removeLastWidget();
              }
            },
          ),
        ),
      );
    });
    Future.delayed(Duration(milliseconds: 100), () {
      // 새로운 EditableText에 focus 설정을 위해 잠시 지연시간을 줍니다.
      FocusScope.of(context).requestFocus(newFocusNode);
    });
  }

  List<Widget> widgetList = [];

  @override
  void initState() {
    super.initState();
    widgetList = [
      Container(
        padding: EdgeInsets.only(bottom: 3),
        child: EditableText(
          controller: bodyController,
          focusNode: _focusNode,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          onEditingComplete: (){
            print('함수가 실행됬다.');
            addWidgetToColumn();
            // FocusScope.of(context).requestFocus(newFocusNode);
          },
          cursorColor: Colors.black,
          backgroundCursorColor: Colors.black,
          onChanged: (text) {
            if (text.isEmpty) {
              removeLastWidget(); // 모든 텍스트가 삭제되었을 때 함수 호출
            }
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> toolbar = [
      IconButton(
        tooltip: '배경이미지',
        key: _widgetKey,
        onPressed: () {
          int index = 0;
          showImageMenu(context);
        },
        icon: Icon(
          Icons.image,
          size: 35,
        ),
      ),
      IconButton(
        tooltip: '구분선',
        onPressed: () {
          if (barActivation == false) {
            int index = 1;
            barActivation = true;
            maketool(index, barActivation);
          } else {
            barActivation = false;
            int index = 1;
            maketool(index, barActivation);
          }
        },
        icon: Icon(
          Icons.density_large,
          size: 35,
        ),
      ),
      IconButton(
        tooltip: '택스트 스타일',
        onPressed: () {
          int index = 2;
        },
        icon: Icon(
          Icons.format_size,
          size: 35,
        ),
      ),
      IconButton(
        tooltip: '배경색',
        onPressed: () {
          int index = 3;
        },
        icon: Icon(
          Icons.color_lens,
          size: 35,
        ),
      ),
    ];

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 40,
                      ),
                    ),
                    Text(
                      '새 게시물',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '다음',
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.grey),
                  ),
                ),
                child: TextFormField(
                  maxLength: 20,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: '제목',
                    focusedBorder: InputBorder.none,
                    counterText: '',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: toolbar,
                ),
              ),
              if (completionTool != null)
                Container(
                  height: 50,
                  child: completionTool,
                ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    FocusScope.of(context).requestFocus(_focusNode);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widgetList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return widgetList[index];
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
