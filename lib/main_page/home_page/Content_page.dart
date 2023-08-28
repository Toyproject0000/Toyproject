import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart';
import 'package:smart_dongne/main_page/home_page/Comment_page.dart';
import 'package:smart_dongne/server/contentServer.dart';
import 'package:smart_dongne/server/userId.dart';
import 'package:smart_dongne/server/userServer.dart';

class ShowaContents extends StatefulWidget {
  const ShowaContents({super.key});
  static const routeName = '/ContentPage';

  @override
  State<ShowaContents> createState() => _ShowaContentsState();
}

class _ShowaContentsState extends State<ShowaContents> {
  late String PostingContents;
  bool activationThumb = false;
  bool IconColer = false;
  String writerId = '';
  int? postId;

  String webviewHtmlCode = '''
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
  ''';

  void reportUser() async {
    if (writerId == globalUserId) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          '자기 게시물은 신고 수 없습니다.',
          style: TextStyle(fontSize: 14),
        ),
        backgroundColor: Colors.blue[400],
      ));
    } else {
      final data = {
        'token': jwtToken,
        'reportingUserId': globalUserId,
        'reportedUserId': writerId
      };
      final response = await userReport(data);
      if (response != null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('{${writerId}유저를 신고하였습니다.}'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        '확인',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              );
            });
      }
    }
  }

  void userCutoff() async {
    if (writerId == globalUserId) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          '자기 게시물은 차단할 수 없습니다.',
          style: TextStyle(fontSize: 14),
        ),
        backgroundColor: Colors.blue[400],
      ));
    } else {
      final data = {
        'token': jwtToken,
        'reportingUserId': globalUserId,
        'reportedUserId': writerId
      };
      final response = await userBlock(data);
      if (response != null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('{${writerId}유저를 차단하였습니다.}'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        '확인',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ContentArguments;
    PostingContents = webviewHtmlCode + args.content;
    writerId = args.writerId;
    postId = args.postId;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Row(
              children: [
                InkWell(
                    onTap: () async {
                      setState(() {
                        activationThumb = !activationThumb;
                      });
                      final data = {
                        'token' : jwtToken,
                        'postId' : postId,
                        'userId' : globalUserId
                      };
                      if(activationThumb == true){
                        final response = await postLike(data);
                        print('$response 좋아요');
                      }else if(activationThumb == false){
                        final response = await postUnLike(data);
                        print('$response 좋아요 취소');
                      }
                    },
                    child: activationThumb == false
                        ? Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.black,
                          )
                        : Icon(
                            Icons.thumb_up,
                            color: Colors.blue,
                          )),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, CommentPage.routeName);
                  },
                  child: Icon(
                    Icons.mode_edit_outline_outlined,
                  ),
                ),
              ],
            )
          ]),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          onTap: ()=> reportUser(), child: Text('신고')),
                      PopupMenuItem(
                        onTap:  () => userCutoff(),
                        child: Text('차단'))
                    ])
          ],
        ),
        body: InAppWebView(
          initialData: InAppWebViewInitialData(
            data: '''
            $PostingContents
          ''',
            encoding: 'utf-8',
          ),
        ));
  }
}

class ContentArguments {
  final String content;
  final String writerId;
  final int postId;

  ContentArguments(this.content, this.writerId, this.postId);
}
