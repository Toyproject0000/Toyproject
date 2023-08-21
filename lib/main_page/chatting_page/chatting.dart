import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/chatting_page/chatting_Content.dart';
import 'package:smart_dongne/main_page/chatting_page/chatting_searchmode.dart';
import 'package:smart_dongne/server/chatServer.dart';

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

  InkWell MakeAChattingWidget(data){
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ChattingContent.routeName, arguments: SendUserData(data['sendUser'], data['acceptUser']));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 25,

                ),
                SizedBox(width: 10,),
                Container(
                  width: MediaQuery.of(context).size.width - 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['sendUser'], overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontSize: 17),),
                      SizedBox(height: 5),
                      Text(data['message'] == null ? 'null' : data['message'], overflow: TextOverflow.ellipsis, maxLines: null,style: TextStyle(color: Colors.grey, fontSize: 15),)
                    ],
                  ),
                )
              ],
            ),
            Text(data['dateTime'] == null ? '5:18' : data['dateTime'], style: TextStyle(fontSize: 15, color: Colors.grey),)
          ],
        ),
      ),
    );
  }

  void getChatdata() async {
    final data = {'sendUser' : 'minwung'};
    final response = await chattingMainPageData(data);
    jsonData = await jsonDecode(response);
    final List<InkWell> ChattingWidget = jsonData!.map((data) => MakeAChattingWidget(data)).toList();
    ChattingListColumn = Column(children: ChattingWidget,);
    setState(() { });
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
          child: jsonData != null ? Container(
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  Text('메세지', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
                  SizedBox(height: 10,),
                  ChattingListColumn
                ],
              ),
            ),
          ) : Center(child: Text('대화 메시지가 없습니다.'),),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, ChatSearchMode.routeName);
          },
          child: Icon(Icons.search, color: Colors.white,), 
          backgroundColor: Colors.blue,
        ),
      );
  }
}
