import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/component/mySendMessageBar.dart';
import 'package:smart_dongne/main_page/home_page/comment/commentWidget.dart';
import 'package:smart_dongne/provider/comment_provider.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

final TextEditingController commentController = TextEditingController();
final FocusNode commentFocusNodde = FocusNode();
int? ReplyId;

class CommentPage extends StatelessWidget {
  CommentPage({required this.PostId, super.key});
  final int PostId;
  late CommentProvider _commentProvider;

  // sendComment
  void sendMyCommentToServer() async {
    if (commentController.text.isNotEmpty) {
      if(ReplyId == null ){
        final data = {
          'token': jwtToken,
          'userId': globalUserId,
          'userRoot': LoginRoot,
          'contents': commentController.text,
          'postId': PostId,
        };
        // 이부분에 sendComment 작성
        final response = await ServerResponseOKTemplate('/reply/add', data);
        if (response != null) {
          commentController.clear();
          CommentReBuild();
          commentFocusNodde.unfocus();
        }
      }else{
        final data = {
          'token' : jwtToken,
          'id' : ReplyId,
          'Contents' : commentController.text 
        };
        final response = await ServerResponseOKTemplate('/reply/edit', data);
        if (response != null) {
          commentController.clear();
          CommentReBuild();
          commentFocusNodde.unfocus();
        }

      }
    }
  }
  
  void CommentReBuild() {
    _commentProvider.CommentList(PostId);
  }

  @override
  Widget build(BuildContext context) {
    _commentProvider = Provider.of<CommentProvider>(context, listen: false);
    _commentProvider.CommentList(PostId);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '댓글',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SafeArea(
        child: Column(children: [
          // comment Widet List
          Expanded(child: CommentWidget()),
          // comment send bar
          MySendMessageBar(
            onTap: sendMyCommentToServer,
            textController: commentController,
            textfocusNode: commentFocusNodde,
          ),
        ]),
      ),
    );
  }

  Widget CommentSendMessage() {
    return Container(
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            focusNode: commentFocusNodde,
            controller: commentController,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1)),
                hintText: 'send your message'),
            onTap: sendMyCommentToServer
          )),
        ],
      ),
    );
  }
}
