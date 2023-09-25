
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/main_page/UserReportandCutoff.dart';
import 'package:smart_dongne/main_page/home_page/comment/Comment_page.dart';
import 'package:smart_dongne/main_page/writing_page/writing_page.dart';
import 'package:smart_dongne/provider/likeProvider.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class ShowaContents extends StatefulWidget {
  const ShowaContents(
      {required this.id,
      required this.contents,
      required this.userId,
      required this.userRoot,
      super.key});
  final String userId;
  final String userRoot;
  final int id;
  final String contents;

  static const routeName = '/ContentPage';

  @override
  State<ShowaContents> createState() => _ShowaContentsState();
}

class _ShowaContentsState extends State<ShowaContents> {
  UserReportAndCutoff? userReportAndCutoff;
  late String PostingContents;

  bool IconColer = false;
  String writerId = '';
  LikeProvider? _likeProvider;

  String webviewHtmlCode = '''
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
  ''';

  void LikeandCancel(data) async {
    if (Provider.of<LikeProvider>(context, listen: false).likeState == true) {
      final response = await ServerResponseOKTemplate('/post-like/add', data);
      print('$response 좋아요');
    } else {
      final response =
          await ServerResponseOKTemplate('/post-like/remove', data);
      print('$response 좋아요 취소');
    }
  }


  // @override
  // void initState() {

  //   Delta variable = Delta()..insert(widget.contents + '\n');
  //   NotusDocument document = NotusDocument.fromDelta(variable);
  //   print(document);
  //   zefyrController = ZefyrController(document);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    _likeProvider = Provider.of<LikeProvider>(context, listen: false);
    userReportAndCutoff = UserReportAndCutoff(context);
    // PostingContents = webviewHtmlCode + widget.contents;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Row(
              children: [
                Consumer(
                  builder: (context, value, child) {
                    return InkWell(
                        onTap: () async {
                          _likeProvider!.changeLike();
                          final data = {
                            'token': jwtToken,
                            'postId': widget.id,
                            'userId': globalUserId,
                            'userRoot': LoginRoot
                          };
                          LikeandCancel(data);
                        },
                        child: Provider.of<LikeProvider>(context).likeState ==
                                false
                            ? Icon(
                                Icons.thumb_up_alt_outlined,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.thumb_up,
                                color: Colors.blue,
                              ));
                  },
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommentPage(
                                PostId: widget.id,
                              )),
                    );
                  },
                  child: Icon(
                    Icons.mode_edit_outline_outlined,
                  ),
                ),
              ],
            )
          ]),
          actions: [PopmenuWidget()],
        ),
        // body: InAppWebView(
        //   initialData: InAppWebViewInitialData(
        //     data: '''
        //     $PostingContents
        //   ''',
        //     encoding: 'utf-8',
        //   ),
        // ));

        body: Center(child: Text('점검 중')),
        // body: ZefyrEditor(
        //     controller: zefyrController,
        //     showCursor: false,
        //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        //   ),
      );
  }

  void postsDelete() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              '해당 글을 삭제하시겠습니까??',
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    final data = {'token': jwtToken, 'id': widget.id};
                    final response =
                        await ServerResponseOKTemplate('/post/delete', data);
                    if (response != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('해당 내용을 삭제했습니다.')));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    '확인',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          );
        });
  }

  PopupMenuButton<dynamic> PopmenuWidget() {
    if (widget.userId == globalUserId && widget.userRoot == LoginRoot) {
      return PopupMenuButton(
          itemBuilder: (context) => [
                PopupMenuItem(onTap: postsDelete, child: Text('삭제')),
                PopupMenuItem(
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                          return WritingPage(contents: widget.contents, postsId: widget.id,);
                        })),
                    child: Text('수정'))
              ]);
    } else {
      return PopupMenuButton(
          itemBuilder: (context) => [
                PopupMenuItem(
                    onTap: () => userReportAndCutoff!
                        .makeReportReason(widget.userId, widget.userRoot),
                    child: Text('신고')),
                PopupMenuItem(
                    onTap: () => userReportAndCutoff!
                        .userCutOff(widget.userId, widget.userRoot),
                    child: Text('차단'))
              ]);
    }
  }
}
