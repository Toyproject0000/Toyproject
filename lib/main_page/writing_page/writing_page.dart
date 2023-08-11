// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_dongne/main_page/writing_page/writing_page_final.dart';
import 'package:smart_dongne/server/userId.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();

  TextStyle basicFont = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );
  bool keyboardActivation = false;

  Future<String?> saveText() async {
    final value = await _keyEditor.currentState?.getText();
    final value1 = await _keyEditor.currentState?.getText();

    if (value1 != null && value1.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text(value1),
      ));
      return value1;

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text(
          '내용을 입력해주세요',
          style: TextStyle(fontSize: 14),
        ),
        backgroundColor: Colors.blue[400],
      ));
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SelectableText('새 게시물'),
        elevation: 1,
        actions: [
          TextButton(
            onPressed: () {
              saveText().then((value) {
                if (value != null) {
                  Navigator.pushNamed(
                    context, 
                    LastSetting.routeName,
                    arguments: Contents(value)
                  );
                }
              });
            },
            child: Text(
              '다음',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: FlutterSummernote(
          key: _keyEditor,
          hint: "내용을 입력하시오....",
          showBottomToolbar: false,
          customToolbar: """
              [
                ['style', ['bold','italic','underline','clear']],
                ['font', ['fontsize']],
                ['para', ['paragraph']],
              ]
              """,
        ),
      ),
    );
  }
}
