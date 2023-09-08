import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/main_page/UserReportandCutoff.dart';
import 'package:smart_dongne/main_page/home_page/comment/Comment_page.dart';
import 'package:smart_dongne/provider/likeProvider.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class ShowaContents extends StatefulWidget {
  const ShowaContents({super.key});
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

  int? postId;

  String webviewHtmlCode = '''
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
  ''';

  void LikeandCancel(data) async {
    if(Provider.of<LikeProvider>(context, listen: false).likeState == true){
      final response = await ServerResponseOKTemplate('/post-like/add' ,data);
      print('$response 좋아요');
    }else {
      final response = await ServerResponseOKTemplate('/post-like/remove' ,data);
      print('$response 좋아요 취소');
    }
  }


  @override
  Widget build(BuildContext context) {

    _likeProvider = Provider.of<LikeProvider>(context, listen: false);
    userReportAndCutoff = UserReportAndCutoff(context);
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
                Consumer(
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: () async {
                        _likeProvider!.changeLike();
                        final data = {
                          'token' : jwtToken,
                          'postId' : postId,
                          'userId' : globalUserId,
                          'userRoot' : LoginRoot
                        };
                        LikeandCancel(data);
                      },
                      child: Provider.of<LikeProvider>(context).likeState == false
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
                    Navigator.push(context,
                     MaterialPageRoute(builder: (context) => CommentPage(PostId: postId!,)),);
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
                          onTap: ()=> userReportAndCutoff!.makeReportReason(args.writerId, args.writerRoot), 
                          child: Text('신고')),
                      PopupMenuItem(
                        onTap:  () => userReportAndCutoff!.userCutOff(args.writerId, args.writerRoot),
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
  final String writerRoot;
  final int postId;

  ContentArguments(this.content, this.writerId, this.postId, this.writerRoot);
}
