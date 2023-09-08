import 'package:flutter/material.dart';
import 'package:smart_dongne/component/mySendMessageBar.dart';
import 'package:smart_dongne/main_page/home_page/comment/commentWidget.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class CommentPage extends StatelessWidget {
  CommentPage({required this.PostId ,super.key});
  final int PostId;

  final TextEditingController _commetTextController = TextEditingController();
  // sendComment
  void sendMyCommentToServer() async {
    if(_commetTextController.text.isNotEmpty){
      final data = {
        'token' : jwtToken,
        'userId' : globalUserId,
        'root' : LoginRoot,
        'contents' : _commetTextController.text,
        'postId' : PostId,
      };
      // 이부분에 sendComment 작성
      final response = await ServerResponseOKTemplate('/reply/add', data);
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children : [
            // comment Widet List
            Expanded(
              child: CommentWidget(postsId: PostId,)
            ),
            // comment send bar
            MySendMessageBar(onTap: sendMyCommentToServer, textController: _commetTextController),
          ]
        ),
      ),
    );
  }
}
