import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  List? jsonData;
  late Column ChattingListColumn;

  void _onDismissed(sendUser, acceptUser, index) async {
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


  Slidable makeWidgetChatting(index){
    return Slidable(
      endActionPane: ActionPane(

        motion: const BehindMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (context) => _onDismissed(jsonData![index]['sendUser'], jsonData![index]['acceptUser'], index)
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(jsonData![index]['sendUser'], style: TextStyle(color: Colors.black),),
        subtitle: Text(jsonData![index]['message'], overflow: TextOverflow.ellipsis),
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 25,
        ),
        trailing: Text(jsonData![index]['dateTime'] == null ? '5:18' : jsonData![index]['dateTime'], style: TextStyle(color: Colors.black),),
        onTap: (){
          Navigator.pushNamed(context, ChattingContent.routeName,
            arguments: SendUserData(jsonData![index]['sendUser'], jsonData![index]['acceptUser']));
        },
      ),
    );
  }
  

  
  void getChatdata() async {
    final data = {'sendUser': globalNickName, 'token' : jwtToken};
    final response = await ServerResponseJsonDataTemplate('/message/findAll', data);
    print(response);
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
        child: jsonData != null ?
            Container(
               child: Container(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: jsonData!.length,
                    itemBuilder: (context, index){
                      return makeWidgetChatting(index);
                    } 
                  ),
                )
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
