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
  bool barActivation = true;
  FocusNode? newFocusNode;
  int? widgetListIndex;
  bool toolbarbool = true;
  ScrollController scrollController = ScrollController();
  BuildContext? showContext;


  final GlobalKey _widgetKey = GlobalKey();
  TextStyle basicFont = TextStyle(fontSize: 15, color: Colors.black);

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
    // 줄바꿈에서 활용하기
    setState(() {
      if (widgetList.length > 1) {
        widgetList.removeAt(index);
      }
    });
  }

  void showSortingMenu(BuildContext context) {
    final RenderBox overlay =
    Overlay.of(context).context.findRenderObject() as RenderBox; // 더 공부하기
    final RenderBox widgetBox =
    _widgetKey.currentContext!.findRenderObject() as RenderBox;
    final Offset widgetPosition =
    widgetBox.localToGlobal(Offset.zero); // 상대 위치를 절대 위치로 변경

    final List<PopupMenuEntry> menuItems = [
      PopupMenuItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(onTap: (){
              Navigator.pop(context);
            },
                child: Image.asset('image/left-align.png', width: 25, height: 25,)),
            SizedBox(width:10),
            GestureDetector(onTap: (){
              Navigator.pop(context);
            }, child: Image.asset('image/format.png', width: 25, height: 25,)),
            SizedBox(width:10),
            GestureDetector(onTap: (){
              Navigator.pop(context);
            }, child: Image.asset('image/align-right.png', width: 25, height: 25,))
          ],
        ),
      )
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

  List<Widget> widgetList = [];
  List<TextEditingController> widgetControllers = [];
  List<FocusNode> widgetFocustNodes = [];
  List<ScrollController> widgetScrollController = [];
  List<Widget> everyThing = [];
  List<Widget> toolbar = [];


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
        maxLines: 1,
      ),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    toolbar = [
      Container(
        decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                color: Colors.grey,
                width: 1,
              )),
        ),
        child: IconButton(
          tooltip: '구분선',
          onPressed: () {
            // addLine(); 구분선 넣기
          },
          icon: Icon(
            Icons.density_large,
            size: 35,
          ),
        ),
      ),
      SizedBox(
        width: 20,
      ),
      GestureDetector(
        onTap: () {},
        child: Text('글꼴'),
      ),
      SizedBox(
        width: 20,
      ),
      GestureDetector(
        onTap: () {},
        child: Text(basicFont.fontSize.toString()),
      ),
      SizedBox(
        width: 10,
      ),
      IconButton(
        tooltip: '굵기',
        onPressed: () {
          int index = 4;
        },
        icon: Icon(
          Icons.format_bold,
          size: 35,
        ),
      ),
      IconButton(
        tooltip: '기울임',
        onPressed: () {
          int index = 4;
        },
        icon: Icon(
          Icons.format_italic,
          size: 35,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Image.asset('image/underline.png',
          width: 25, height: 25,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Image.asset('image/strikethrough.png',
          width: 30, height: 30,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Image.asset('image/font.png',
          width: 30, height: 30,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Image.asset('image/text.png',
          width: 30, height: 30,
        ),
      ),
      Container(
        key: _widgetKey,
        decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                color: Colors.grey,
                width: 1,
              )),
        ),
        child: TextButton(
          onPressed: () {
            showSortingMenu(context);
          },
          child: Image.asset('image/left-align.png',
            width: 30, height: 30,
          ),
        ),
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {

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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: toolbar,
          ),
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
