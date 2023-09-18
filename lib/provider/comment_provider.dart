import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_dongne/component/timeWidget.dart';
import 'package:smart_dongne/main_page/home_page/comment/Comment_page.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class CommentProvider extends ChangeNotifier {
  bool likeState = false;

  late int PostsId;

  Widget allComment = Center(
    child: Text(
      '댓글이 없습니다.',
      style: TextStyle(color: Colors.black),
    ),
  );

  Widget popMenuWidget(Map<String, dynamic> jsonData) {
    if (jsonData['userId'] == globalUserId &&
        jsonData['userRoot'] == LoginRoot) {
      return PopupMenuButton(
          itemBuilder: (context) => [
                PopupMenuItem(
                    onTap: () {
                      showDialogWidget(
                          content: '해당 댓글을 삭제하시겠습니까??',
                          context: context,
                          id: jsonData['id']);
                    },
                    child: Text('삭제')),
                PopupMenuItem(
                    onTap: () => editComment(jsonData['contents']),
                    child: Text('수정'))
              ]);
    } else {
      return PopupMenuButton(
          itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () => commentReport(
                      jsonData['userId'], jsonData['userRoot'], context),
                  child: Text('신고'),
                ),
              ]);
    }
  }

  void commentReport(userId, userRoot, context) async {
    final data = {
      'token': jwtToken,
      'reportingUserId': globalUserId,
      'reportingUserRoot': LoginRoot,
      'reportedUserId': userId,
      'reportedUserRoot': userRoot
    };

    final response = await ServerResponseOKTemplate('/block/user', data);
    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1), content: Text('해당 유저를 신고하였습니다.')));
    }
  }

  void showDialogWidget({context, content, id}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(content),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '취소',
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton(
                      onPressed: () {
                        onDismissedComment(id);
                        Navigator.pop(context);
                      },
                      child: Text(
                        '확인',
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
            ],
          );
        });
  }

  void onDismissedComment(int commentId) async {
    final data = {
      'token': jwtToken,
      'id': commentId,
    };
    print(data);
    final response = await ServerResponseOKTemplate('/reply/delete', data);
    if (response != null) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('삭제했습니다.')));
      CommentList(PostsId);
    }
  }

  void editComment(text) {
    commentController.text = text;
    commentFocusNodde.requestFocus();
  }

  Widget CommentsWidget(Map<String, dynamic> jsonData) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () {},
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: FileImage(File(jsonData['userImage'])),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    jsonData['nickname'],
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
              ],
            ),
          ],
        ),
        trailing: popMenuWidget(jsonData),
      ),
    );
  }

  Future<void> CommentList(postsId) async {
    PostsId = postsId;
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
      final response = await ServerResponseOKTemplate('/reply-like/add', data);
      print(response);
    } else {
      final response = await ServerResponseOKTemplate('/reply-like/remove', data);
      print(response);
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