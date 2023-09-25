import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/writing_page/test.dart';
import 'package:smart_dongne/main_page/writing_page/writing_page_final.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class WritingPage extends StatefulWidget {
  const WritingPage({required this.postsId, required this.contents, Key? key})
      : super(key: key);

  final String? contents;
  final int? postsId;

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  TextStyle basicFont = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );

  // void saveText() {
  //   if(basicDocument == _controller.document){
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     duration: Duration(seconds: 2),
  //     content: Text(
  //       '내용을 입력해주세요',
  //       style: TextStyle(fontSize: 14),
  //     ),
  //     backgroundColor: Colors.blue[400],
  //     ));
  //   }else {
  //     Navigator.push(context, MaterialPageRoute(builder: (context) {

  //       return LastSetting(
  //         edit: widget.contents != null ? true : false,
  //         editorController: _controller,
  //         postId: widget.postsId,
  //         function: completeWrite,
  //       );
  //     }));
  //   }
  // }

  quill.QuillController quillController = quill.QuillController.basic();

  Widget quillWidget() {
    return Column(
      children: [
        quill.QuillToolbar.basic(
          controller: quillController,
            // editor button
             showDividers : true,
             showFontFamily : false,
             showFontSize : false,
             showBoldButton : true,
             showItalicButton : true,
             showSmallButton : false,
             showUnderLineButton : true,
             showStrikeThrough : true,
             showInlineCode : false,
             showColorButton : true,
             showBackgroundColorButton : true,
             showClearFormat : true,
             showAlignmentButtons : true,
             showLeftAlignment : true,
             showCenterAlignment : true,
             showRightAlignment : true,
             showJustifyAlignment : true,
             showHeaderStyle : true,
             showListNumbers : false,
             showListBullets : false,
             showListCheck : false,
             showCodeBlock : false,
             showQuote : false,
             showIndent : false,
             showLink : false,
             showUndo : false,
             showRedo : false,
             showDirection : false,
             showSearchButton : false,
             showSubscript : false,
             showSuperscript : false,
          
          ),
        Divider(
          color: Colors.grey,
          thickness: 1,
          height: 1,
        ),
        quill.QuillEditor.basic(
          controller: quillController,
          readOnly: false,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
      ],
    );
  }

  @override
  void dispose() {
    quillController.dispose();
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
                // saveText();
                print(quillController.document.toString());
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyWidget(
                      quillContrller: quillController,
                      document: quillController.document.toDelta().toString());
                }));
              },
              child: Text(
                '다음',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
          ],
          automaticallyImplyLeading: true,
        ),
        body: quillWidget());
  }
}
