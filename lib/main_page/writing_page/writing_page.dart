import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:smart_dongne/main_page/writing_page/writing_page_final.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({required this.postsId ,required this.contents, Key? key}) : super(key: key);

  final String? contents;
  final int? postsId;

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final _keyEditor = GlobalKey<FlutterSummernoteState>();

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

  @override
  void dispose() {
    _keyEditor.currentState!.dispose();
    super.dispose();
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
              saveText().then((value) async {
                if (value != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LastSetting(
                      edit: widget.contents != null ? true : false,
                      summerNoteKey: _keyEditor,
                      contents: value,
                      postId: widget.postsId,
                    );
                  }));
                }
              });
            },
            child: Text(
              '다음',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
        ],
        automaticallyImplyLeading: true,
      ),
      body: SummerNoteWidget(),
    );
  }

  FlutterSummernote SummerNoteWidget() {
    return FlutterSummernote(
      decoration: BoxDecoration(
        border: Border.all(width: 0),
      ),
      key: _keyEditor,
      value: widget.contents,
      hint: widget.contents == null ? "내용을 입력하시오...." : null,
      showBottomToolbar: false,
      customToolbar: """
          [
            ['style', ['bold','italic','underline','clear']],
            ['para', ['paragraph']],
          ]
            """,
    );
  }
}
