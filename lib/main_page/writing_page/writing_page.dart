// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:smart_dongne/main_page/writing_page/writing_page_final.dart';

class WritingPage extends StatefulWidget {
  const WritingPage(this.changeClass, {Key? key}) : super(key: key);
  final Function(int index) changeClass;

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();
  Widget? summerNote;

  TextStyle basicFont = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );
  // bool keyboardActivation = false;

  Future<String?> saveText() async {
    final value = await _keyEditor.currentState?.getText();
    final value1 = await _keyEditor.currentState?.getText();

    if (value1 != null && value1.isNotEmpty) {
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
      return null;
    }
  }

  Future<Widget> _summerNoteEditor() async {
    final summerNoteEditor = await FlutterSummernote(
      decoration: BoxDecoration(
        border: Border.all(width: 0),
      ),
      key: _keyEditor,
      hint: "내용을 입력하시오....",
      showBottomToolbar: false,
      customToolbar: """
          [
            ['style', ['bold','italic','underline','clear']],
            ['para', ['paragraph']],
          ]
            """,
    );
    return summerNoteEditor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: (){_keyEditor.currentState!.setEmpty();},child: Icon(Icons.delete, color: Colors.red,)),
        backgroundColor: Colors.white,
        title: SelectableText('새 게시물'),
        elevation: 1,
        actions: [
          TextButton(
            onPressed: () {
              saveText().then((value) async {
                if (value != null) {
                  final response = await Navigator.pushNamed(
                    context, 
                    LastSetting.routeName,
                    arguments: Contents(value, widget.changeClass, _keyEditor),
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
      body: FutureBuilder(
        future: _summerNoteEditor(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){
          if(snapshot.hasError){
            Center(
              child: Text('error'),
            );
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          return snapshot.data!;
        }
      )
    );
  }
}
