import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';
import 'package:screenshot/screenshot.dart';

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
  String _text = '';
  TextStyle _textStyle = TextStyle(
      fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue[300]);
  TextAlign _textAlign = TextAlign.center;

  String imagePath = '';
  bool argumentSend = false;
  ScreenshotController screenshotController = ScreenshotController();

  void CoverFinsh(){
    screenshotController.capture().then((value){
      print('켑처 실행됌');
      Navigator.pop(context, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      setState(() {
        argumentSend = true;
      });

      final args =
          ModalRoute.of(context)!.settings.arguments as ScreenArguments;

      imagePath = args.imagePath;
    }

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
                    onPressed: () {
                      CoverFinsh();
                    },
                    child: Text(
                      '다음',
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            )
          : null,
      body: SafeArea(
        child: Screenshot(
          controller: screenshotController,
          child: Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: 4 / 5,
                  child: Container(
                    width: double.infinity,
                    child: argumentSend == true
                        ? Image.file(File(imagePath), fit: BoxFit.cover)
                        : Image(
                            image: AssetImage('image/basiccover.jpg'),
                            fit: BoxFit.cover,
                          ),
                  ),
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
      ),
    );
  }
}

class ScreenArguments {
  final String imagePath;

  ScreenArguments(this.imagePath);
}

class BasicCover {
  final Image basicCover;

  BasicCover(this.basicCover);
}
