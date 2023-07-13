import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:text_editor/text_editor.dart';

class CoverPage extends StatefulWidget {
  const CoverPage({super.key});

  static const routeName = '/cover';

  @override
  State<CoverPage> createState() => _CoverPageState();
}

class _CoverPageState extends State<CoverPage> {
  Widget? addTextCover;
  bool EditAppBar = false;
  Text EditText = Text('');

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    String imagePath = args.imagePath;
    String _text = 'Sample Text';
    TextStyle _textStyle = TextStyle(
        fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue[300]);
    TextAlign _textAlign = TextAlign.center;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: EditAppBar == false
          ? AppBar(
              backgroundColor: Colors.black,
              centerTitle: true,
              title: IconButton(
                  onPressed: () {
                    setState(() {
                      EditAppBar = true;
                    });
                  },
                  icon: Icon(
                    Icons.mode_edit,
                    color: Colors.white,
                    size: 23,
                  )),
              actions: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      '다음',
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            )
          : null,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Image(
                image: FileImage(File(imagePath)),
              ),
            ),
            if (EditAppBar == true)
              TextEditor(
                  text: _text,
                  textStyle: _textStyle,
                  textAlingment: _textAlign,
                  fonts: [
                    'NotoSansKR',
                    'NanumGothic',
                    'NanumPenScript',
                    'GasoekOne',
                    'Dongle',
                  ],
                  onEditCompleted: (style, align, text) {
                    setState(() {
                      _text = text;
                      _textStyle = style;
                      _textAlign = align;

                      EditText = Text(
                        _text,
                        style: _textStyle,
                        textAlign: _textAlign,
                      );

                      EditAppBar = false;
                    });
                  }),
            if (EditAppBar == false) Center(child: EditText)
          ],
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String imagePath;

  ScreenArguments(this.imagePath);
}
