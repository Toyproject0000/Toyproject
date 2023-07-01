import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:keyboard_actions/keyboard_actions.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  ScrollController _scrollController = ScrollController();
  quill.QuillController _controller = quill.QuillController.basic();
  FocusNode _focusNode1 = FocusNode();
  final custom1Notifier = ValueNotifier<String>("0");
  TextEditingController bodyController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  TextStyle basicFont = TextStyle(
    fontSize: 15, color: Colors.black,
  );
  List<Widget> toolbar = [];


  @override
  void initState() {
    super.initState();
    toolbar = [
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
        decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                color: Colors.grey,
                width: 1,
              )),
        ),
        child: TextButton(
          onPressed: () {
          },
          child: Image.asset('image/left-align.png',
            width: 30, height: 30,
          ),
        ),
      ),
    ];
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey,
      actions: [
        KeyboardActionsItem(
          focusNode: _focusNode1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading:  IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.cancel_outlined,
              size: 40,
            ),
          ),
          title: Text('새 게시물'),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                '다음',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.grey),
                  ),
                ),
                child: TextFormField(
                  focusNode: _focusNode1,
                  keyboardType: TextInputType.text,
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
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SampleHeaderDelegate(
                widget:  Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: toolbar,
                    )
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EditableText(
                    controller: bodyController,
                    focusNode: _focusNode,
                    style: basicFont,
                    cursorColor: Colors.black,
                    backgroundCursorColor: Colors.black,
                    maxLines: null,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SampleHeaderDelegate extends SliverPersistentHeaderDelegate {
  SampleHeaderDelegate({required this.widget});

  Widget widget;


  @override
  Widget build(
    BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(child: widget);

  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;



  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
