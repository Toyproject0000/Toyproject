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

class _WritingPageState extends State<WritingPage>{

  ScrollController _scrollController = ScrollController();
  quill.QuillController _controller = quill.QuillController.basic();
  FocusNode _focusNode1 = FocusNode();
  final custom1Notifier = ValueNotifier<String>("0");

  final GlobalKey _widgetKey = GlobalKey();

  List<Widget> everyThing = [];

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
      Container(
        padding: EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1
            )
          )
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: quill.QuillToolbar.basic(
            controller: _controller,
            toolbarIconSize: 23,
            iconTheme: quill.QuillIconTheme(
              iconSelectedFillColor: Colors.lightBlue,
              iconSelectedColor: Colors.white,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: quill.QuillEditor.basic(
          controller: _controller,
          readOnly: false,
        ),
      ),
      SizedBox(
        height: 50,
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
