// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();
  String result = '';

  TextStyle basicFont = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );
  List<Widget> toolbar = [];
  bool keyboardActivation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SelectableText('새 게시물'),
        actions: [
          TextButton(
            onPressed: () async {
              final value = (await _keyEditor.currentState?.getText());
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 5),
                content: Text(value ?? '-'),
              ));
            },
            child: Text(
              '다음',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: FlutterSummernote(
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
    );
  }
}
