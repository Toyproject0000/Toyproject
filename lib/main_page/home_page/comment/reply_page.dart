import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/mySendMessageBar.dart';
import 'package:smart_dongne/component/timeWidget.dart';
import 'package:smart_dongne/provider/comment_provider.dart';

class ReplyPage extends StatelessWidget {
  ReplyPage({
    super.key,
    required this.nickname,
    required this.content,
    required this.date,
    required this.likeState,
  });

  final String nickname;
  final String content;
  bool likeState;
  final String date;

  final TextEditingController _replyController = TextEditingController();

  void onTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '답글',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nickname,
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            content,
                            style: TextStyle(color: Colors.grey[700]),
                            maxLines: 3,
                          ),
                          // CommentLikeState(),

                          // 답글 부분
                        ],
                      ),
                      trailing: TimeWidget(contentsTime: date),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          color: Colors.grey.shade200,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Center(child: Text('hello')))),
                ],
              ),
            ),
            MySendMessageBar(onTap: onTap, textController: _replyController),
          ],
        ),
      ),
    );
  }
}
