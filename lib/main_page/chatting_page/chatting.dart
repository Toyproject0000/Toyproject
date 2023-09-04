import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/chatting_page/ChatListTile.dart';
import 'package:smart_dongne/main_page/chatting_page/chatting_Content.dart';
import 'package:smart_dongne/main_page/chatting_page/chatting_searchmode.dart';
import 'package:smart_dongne/server/chatServer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_dongne/server/userId.dart';

class Chatting extends StatefulWidget {
  const Chatting({super.key});

  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  final TextEditingController textController = TextEditingController();
  String userNikcName = 'test';
  late Column ChattingListColumn;
  List response = [];
  List<Widget> allChatting = [];

  void _onDismissed(sendUser, acceptUser) async {
    final data = {
      'sendUser' : sendUser,
      'acceptUser' : acceptUser,
      'token' : jwtToken
    };
    final response = await deleteChatting(data);
    if(response != null){
      setState(() {});
    }
  }
  
  void getChatdata() async {
    final data = {'sendUser': globalNickName, 'token' : jwtToken};
    response = await ServerResponseJsonDataTemplate('/message/findAll', data);
    allChatting = response.map((data) => ChatListTile(data: data, onDismissed: _onDismissed)).toList();
    setState(() {});
  }

  @override
  void initState() {
    getChatdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: response != [] ?
            Column(
              children: allChatting,
            )
            : Center(
                child: Text('대화 메시지가 없습니다.'),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ChatSearchMode.routeName);
        },
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
