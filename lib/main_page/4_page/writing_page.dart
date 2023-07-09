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

  final List<int> fontSizeList = <int>[11, 13, 15, 16, 19, 24, 28, 30, 34, 38];
  final List<Text> fontfamilyList = [
    Text(
      'NotoSansKR',
      style: TextStyle(fontFamily: 'NotoSansKR'),
    ),
    Text(
      'NanumGothic',
      style: TextStyle(fontFamily: 'NanumGothic'),
    ),
    Text(
      'NanumPenScript',
      style: TextStyle(fontFamily: 'NanumPenScript', fontSize: 22),
    ),
    Text(
      'GasoekOne',
      style: TextStyle(fontFamily: 'GasoekOne'),
    ),
    Text(
      'Dongle',
      style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
    ),
  ];

  void changeColor() async {
    if (_webViewController != null) {
      String? selectedText = await _webViewController.getSelectedText();
      String newText = '''
        var start = window.getSelection().getRangeAt(0).startOffset;
        var end = window.getSelection().getRangeAt(0).endOffset;
        var selectedText = window.getSelection().toString();
        var newText =
          document.body.innerHTML.substring(0, start) +
          '<span style="background-color: yellow;">' +
          selectedText +
          '</span>' +
          document.body.innerHTML.substring(end);
        document.body.innerHTML = newText;
      ''';
      await _webViewController.evaluateJavascript(source: newText);
    }
  }

  void printText(args) {
    print(args);
  }

  TextStyle basicFont = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );
  List<Widget> toolbar = [];
  bool keyboardActivation = false;

  @override
  void initState() {
    super.initState();
    dropDownValue = fontSizeList[3];
    fontFamilyValue = fontfamilyList[0];
  }

  @override
  Widget build(BuildContext context) {
    toolbar = [
      Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
            color: Colors.grey,
            width: 1,
          )),
        ),
        child: Row(
          children: [
            DropdownButton(
                value: fontFamilyValue,
                icon: Icon(Icons.arrow_drop_down_sharp),
                items: fontfamilyList.map<DropdownMenuItem<Text>>((Text value) {
                  return DropdownMenuItem(value: value, child: value);
                }).toList(),
                onChanged: (Text? value) {
                  setState(() {
                    fontFamilyValue = value!;
                  });
                }),
            SizedBox(
              width: 20,
            ),
            DropdownButton(
                value: dropDownValue,
                icon: Icon(Icons.arrow_drop_down_sharp),
                elevation: 0,
                items: fontSizeList.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (int? value) {
                  setState(() {
                    dropDownValue = value!;
                  });
                }),
          ],
        ),
      ),
      Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
          color: Colors.grey,
          width: 1,
        ))),
        child: Row(
          children: [
            TextButton(
              onPressed: () {},
              child: Image.asset(
                'image/bold.png',
                width: 30,
                height: 30,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Image.asset(
                'image/italic.png',
                width: 30,
                height: 30,
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
              onPressed: () {
                changeColor();
              },
              child: Image.asset(
                'image/font.png',
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Image.asset(
          'image/list.png',
          width: 30,
          height: 30,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Image.asset(
          'image/numberlist.png',
          width: 30,
          height: 30,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Image.asset(
          'image/left-align.png',
          width: 30,
          height: 30,
        ),
      ),
    ];

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
          // Container(
          //   width: double.infinity,
          //   height: 50,
          //   decoration: BoxDecoration(
          //       border: Border.all(
          //     color: Colors.grey,
          //     width: 1,
          //   )),
          //   child: SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         children: toolbar,
          //       )),
          // ),
          Expanded(
            child: InAppWebView(
              initialFile: filePath,
              onWebViewCreated: (controller) {
                _webViewController = controller;
                _webViewController!.addJavaScriptHandler(
                    handlerName: 'myHandler',
                    callback: (args) {
                      print(args);
                      return {'bar': 'bar_value', 'baz': 'baz_value'};
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
