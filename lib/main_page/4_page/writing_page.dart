import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  TextEditingController bodyController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool usertouch = false;
  double? containerHeight;
  File? imagePath;
  bool barActivation = false;
  FocusNode? newFocusNode;
  int? widgetListIndex;


  final GlobalKey _widgetKey = GlobalKey();
  TextStyle basicFont = TextStyle(fontSize: 15, color: Colors.black);

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
        items: menuItems);
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

  void removeWidget(int index) {
    setState(() {
      if (widgetList.length > 1) {
        widgetList.removeAt(index);
      }
    });
    // Future.delayed(Duration(milliseconds: 100), () {
    //   _scrollController.animateTo(
    //     _scrollController.position.maxScrollExtent,
    //     duration: Duration(milliseconds: 300),
    //     curve: Curves.easeInOut,
    //   );
    //   // 새로운 EditableText에 focus 설정을 위해 잠시 지연시간을 줍니다.
    //   FocusScope.of(context).requestFocus();
    // });
  }

  void addLine(context) {
    final TextEditingController newController = TextEditingController();
    final FocusNode newFocusNode = FocusNode();
    final GlobalKey lineKey = GlobalKey();

    showLineMenu(
        BuildContext context,
        ) {
      final RenderBox overlay = Overlay.of(context)!.context.findRenderObject()
      as RenderBox; // 더 공부하기
      final RenderBox widgetBox =
      lineKey.currentContext!.findRenderObject() as RenderBox;
      final Offset widgetPosition =
      widgetBox.localToGlobal(Offset.zero); // 로컬에서 젼역으로 변경하는 코드

      final List<PopupMenuEntry> menuItems = [
        PopupMenuItem(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.linear_scale_outlined),
                onPressed: () {
                  setState(() {
                    barActivation = false;
                    Navigator.pop(context);
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.line_axis_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.line_weight_sharp),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )
      ];
      // setState(() {
      //   barActivation = true;
      //   showMenu(
      //       context: context,
      //       position: RelativeRect.fromLTRB(
      //         widgetPosition.dx, // 왼쪽
      //         widgetPosition.dy + widgetBox.size.height, // 위쪽
      //         overlay.size.width -
      //             widgetPosition.dx -
      //             widgetBox.size.width, // 오른쪽
      //         overlay.size.height - widgetPosition.dy, // 아래쪽
      //       ),
      //       items: menuItems);
      // });
    }

    setState(() {
      widgetList.add(GestureDetector(
        key: lineKey,
        onTap: () {
          showLineMenu(context);
        },
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (event) {
            if (event is RawKeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.backspace) {}
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Image.asset(
              'image/line1.png',
            ),
          ),
        ),
      ));
    });
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // 새로운 EditableText에 focus 설정을 위해 잠시 지연시간을 줍니다.
      FocusScope.of(context).requestFocus(newFocusNode);
    });
  }


  void addWidgetToColumn() {
    final TextEditingController newController = TextEditingController();
    final FocusNode newFocusNode = FocusNode();

    setState(() {
      widgetControllers.add(newController);
      widgetFocustNodes.add(newFocusNode);
      String previousText = '';
      RawKeyboardListener? newWidget;

      newWidget = RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) {
          String currentText = newController.text;
          int index = widgetList.indexOf(newWidget!);
          if (currentText.isEmpty && event is RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            removeWidget(index);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: EditableText(
            keyboardType: TextInputType.text,
            backgroundCursorColor: Colors.black,
            cursorColor: Colors.black,
            onEditingComplete: () {
              print('함수가 실행됬다.');
              addWidgetToColumn();
            },
            onChanged: (text){
              if(text.contains('\n')){
                newController.text = lineChange();
                addWidgetToColumn();
              }
            },
            controller: newController,
            focusNode: newFocusNode,
            style: basicFont,
            maxLines: null,
          ),
        ),
      );

      widgetList.add(newWidget!);
    });
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // 새로운 EditableText에 focus 설정을 위해 잠시 지연시간을 줍니다.
      FocusScope.of(context).requestFocus(newFocusNode);
    });
  }

  List<Widget> widgetList = [];
  List<TextEditingController> widgetControllers = [];
  List<FocusNode> widgetFocustNodes = [];
  List<Widget> everyThing = [];

  lineChange() {
    String currentText = bodyController.text.replaceAll('\n', '');
    print('줄바껴써용~');
    return currentText;
  }

  Widget BuildWidget(int index){
    return RawKeyboardListener(
        onKey: (event) {
          String currentText = widgetControllers[index].text;
          if (currentText.isEmpty &&
              event is RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            removeWidget(index);
          }
        },
        focusNode: widgetFocustNodes[index],
        child: widgetList[index]);
  }

  @override
  void initState() {
    super.initState();
    widgetFocustNodes.add(_focusNode);
    widgetControllers.add(bodyController);
    widgetList = [
      EditableText(
        controller: bodyController,
        focusNode: _focusNode,
        style: basicFont,
        cursorColor: Colors.black,
        backgroundCursorColor: Colors.black,
        maxLines: null,
        onEditingComplete: () {
          print('함수가 실행됬다.');
          addWidgetToColumn();
        },
        onChanged: (text) {
          if (text.contains('\n')) {
            bodyController.text = lineChange();
            addWidgetToColumn();
          }
        },
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
          addLine(context);
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

    everyThing = [
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
      Column(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(_focusNode);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widgetList.length,
                itemBuilder: (BuildContext context, int index) {
                  return widgetList[index];
                },
              ),
            ),
          ),
          SizedBox(
            height: 75,
          )
        ],
      ),
    ];

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: ListView.builder(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: everyThing.length,
              itemBuilder: (BuildContext context, int index) {
                return everyThing[index];
              }),
        ),
      ),
    );
  }
}
