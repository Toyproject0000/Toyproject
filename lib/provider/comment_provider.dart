import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_dongne/component/timeWidget.dart';
import 'package:smart_dongne/main_page/home_page/comment/reply_page.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class CommentProvider extends ChangeNotifier {
  bool likeState = false;

  late int commentId;

  Widget allComment = Center(
    child: Text(
      '댓글이 없습니다.',
      style: TextStyle(color: Colors.black),
    ),
  );

  void onDismissedComment() async {
    final data = {
      'token': jwtToken,
      'id': commentId,
    };

    final response = await ServerResponseOKTemplate('/reply/delete', data);
    if(response != null){
      print(response);
    }
  }

  void editComment() {}

  Widget CommentsWidget(Map<String, dynamic> jsonData) {
    commentId = jsonData['id'];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () {},
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    jsonData['userId'],
                    style: TextStyle(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                TimeWidget(contentsTime: jsonData['date'])
              ],
            ),
            Text(
              jsonData['contents'],
              style: TextStyle(color: Colors.grey[700]),
              maxLines: 3,
            ),
            Row(
              children: [
                CommentLikeState(commentId: jsonData['id']),
                SizedBox(
                  width: 30,
                ),
                MoveReplyWidget(
                  content: jsonData['contents'],
                  date: jsonData['date'],
                  likeState: false,
                  nickname: jsonData['userId'],
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          children: [
            PopupMenuWidget(
                label1: '삭제',
                onTap1: onDismissedComment,
                label2: '수정',
                onTap2: editComment),
          ],
        ),
      ),
    );
  }

  Future<void> CommentList(postsId) async {
    final data = {'id': postsId, 'token': jwtToken};
    final List? response =
        await ServerResponseJsonDataTemplate('/reply/post', data);
    print(response);
    if (response!.isEmpty) {
      null;
    } else {
      List<Widget> MessageWidgetList =
          response.map<Widget>((data) => CommentsWidget(data)).toList();
      allComment = ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: MessageWidgetList,
      );
      notifyListeners();
    }
  }
}

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({
    required this.label1,
    required this.label2,
    required this.onTap1,
    required this.onTap2,
    super.key,
  });
  final String label1;
  final String label2;
  final Function() onTap1;
  final Function() onTap2;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (context) => [
              PopupMenuItem(onTap: onTap1, child: Text(label1)),
              PopupMenuItem(onTap: onTap2, child: Text(label2))
            ]);
  }
}

class CommentLikeState extends StatefulWidget {
  const CommentLikeState({required this.commentId, super.key});
  final int commentId;

  @override
  State<CommentLikeState> createState() => _CommentLikeStateState();
}

class _CommentLikeStateState extends State<CommentLikeState> {
  bool likeState = false;

  void changeLikeState() async {
    setState(() {
      likeState = !likeState;
    });
    final data = {
      'replyId': widget.commentId,
      'token': jwtToken,
      'userId': globalUserId,
      'userRoot': LoginRoot,
    };

    if (likeState == true) {
      await ServerResponseOKTemplate('/reply-like/add', data);
    } else {
      await ServerResponseOKTemplate('/reply-like/remove', data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => changeLikeState(),
      icon: likeState == false
          ? Icon(
              Icons.thumb_up_alt_outlined,
              color: Colors.grey,
            )
          : Icon(
              Icons.thumb_up,
              color: Colors.blue,
              size: 20,
            ),
    );
  }
}

class MoveReplyWidget extends StatelessWidget {
  MoveReplyWidget(
      {required this.nickname,
      required this.content,
      required this.date,
      required this.likeState,
      super.key});

  final String nickname;
  final String content;
  final String date;
  bool likeState;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ReplyPage(
                nickname: nickname,
                content: content,
                date: date,
                likeState: likeState);
          }));
        },
        icon: Icon(
          Icons.chat,
          size: 20,
        ));
  }
}
