// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
  int? dropDownValue;
  Text? fontFamilyValue;
  late InAppWebViewController _webViewController;
  final String filePath = 'assets/index.html';

  TextStyle basicFont = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );
  List<Widget> toolbar = [];
  bool keyboardActivation = false;

  Future<dynamic> saveText() async {
    dynamic hello =
        await _webViewController.evaluateJavascript(source: 'saveContent();');
    return hello;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SelectableText('새 게시물'),
        actions: [
          TextButton(
            onPressed: () {
              saveText().then((hello) {
                print(hello);
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
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialFile: filePath,
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
            ),
          ),
        ],
      ),
    );
  }
}
