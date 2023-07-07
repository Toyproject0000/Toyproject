// import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  FocusNode _focusNode1 = FocusNode();
  TextEditingController bodyController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  TextSelectionControls? selectionControls;
  String selectionText = '';
  SelectableText? combinationText;
  SelectableText? newText;
  List<TextSpan> textSpanCollection = [];

  TextStyle basicFont = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );
  List<Widget> toolbar = [];
  bool keyboardActivation = false;

  void changeSeletion(text) {
    selectionText = text;
    final TextSpan newTextSpan =
        TextSpan(text: selectionText, style: basicFont);
    textSpanCollection.add(newTextSpan);

    setState(() {
      combinationText =
          SelectableText.rich(TextSpan(children: textSpanCollection));
    });
  }

  void changeFontSize() {
    final TextSelection selection = bodyController.selection;

    if (selection.baseOffset == selection.extentOffset) {
      print('cursor 시작');
    }
    if (selection.baseOffset < selection.extentOffset) {
      print('범위 지정');
      TextStyle newStyle = TextStyle(
        color: Colors.red,
        fontSize: 25,
      );

      setState(() {
        newText = SelectableText.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: selectionText.substring(0, selection.baseOffset),
                  style: basicFont),
              TextSpan(
                  text: selectionText.substring(
                      selection.baseOffset, selection.extentOffset),
                  style: newStyle),
              TextSpan(
                  text: selectionText.substring(
                      selection.extentOffset, bodyController.text.length),
                  style: basicFont),
            ],
          ),
        );
        combinationText = newText;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    combinationText =
        SelectableText.rich(TextSpan(children: textSpanCollection));

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
        onTap: () {
          changeFontSize();
        },
        child: Text(basicFont.fontSize.toString()),
      ),
      SizedBox(
        width: 10,
      ),
      IconButton(
        tooltip: '굵기',
        onPressed: () {
          int index = 4;
          print('굵기');
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
        child: Image.asset(
          'image/underline.png',
          width: 25,
          height: 25,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Image.asset(
          'image/strikethrough.png',
          width: 30,
          height: 30,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Image.asset(
          'image/font.png',
          width: 30,
          height: 30,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Image.asset(
          'image/text.png',
          width: 30,
          height: 30,
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
          onPressed: () {},
          child: Image.asset(
            'image/left-align.png',
            width: 30,
            height: 30,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).addListener(() {
      if (_focusNode1.hasFocus || _focusNode.hasFocus) {
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
        backgroundColor: Colors.white,
        title: SelectableText('새 게시물'),
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
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
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
                      maxLength: 60,
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
                    widget: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1)),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: toolbar,
                          )),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EditableText(
                        toolbarOptions: ToolbarOptions(
                          copy: false,
                          cut: false,
                          paste: false,
                          selectAll: false,
                        ),
                        onChanged: (text) {
                          changeSeletion(text);
                        },
                        selectionControls: MaterialTextSelectionControls(),
                        selectionColor: Color(0xFFffceab),
                        controller: bodyController,
                        focusNode: _focusNode,
                        style: basicFont,
                        cursorColor: Colors.blue,
                        backgroundCursorColor: Colors.black,
                        maxLines: null,
                        showSelectionHandles: true,
                        showCursor: true,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: combinationText),
                  ),
                ),
              ],
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
                            if (!_focusNode1.hasFocus) {
                              FocusScope.of(context).requestFocus(_focusNode1);
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
                            if (!_focusNode.hasFocus) {
                              FocusScope.of(context).requestFocus(_focusNode);
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
