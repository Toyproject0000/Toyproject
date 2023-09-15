import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/chatting_page/ChatListTile.dart';
import 'package:smart_dongne/main_page/chatting_page/chatting_searchmode.dart';
import 'package:smart_dongne/main_page/home_page/search_bar.dart';
import 'package:smart_dongne/server/Server.dart';
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
  List<Widget> allChatting = [];

  void _onDismissed(sendUser, acceptUser) async {
    final data = {
      'sendUser' : sendUser,
      'acceptUser' : acceptUser,
      'token' : jwtToken
    };
    final response = await ServerResponseOKTemplate('/message/deleteAll' ,data);
    if(response != null){
      setState(() {});
    }
  }
  
  Future<Widget> getChatdata() async {
    final data = {'sendUser': globalNickName, 'token' : jwtToken};

    final response = await ServerResponseJsonDataTemplate('/message/findAll', data);
    if(response.isEmpty){
      return Center(
        child: Text('메세지가 없습니다.')
      );
    }
    allChatting = response.map<Widget>((data) => ChatListTile(data: data, onDismissed: _onDismissed)).toList();
    return Column(
      children: allChatting,
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getChatdata(),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){
            if(snapshot.hasError){
              Center(
                child: Text('error'),
              );
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            return snapshot.data!;
          }

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         showSearch(context: context, delegate: MySearchDelegate());
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
