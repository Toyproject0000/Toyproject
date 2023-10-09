import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/component/messageTime.dart';
import 'package:smart_dongne/component/mySendMessageBar.dart';
import 'package:smart_dongne/main_page/chatting_page/ChatBubbleWidget.dart';
import 'package:smart_dongne/provider/chattingProvider.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class ChattingContent extends StatefulWidget {
  const ChattingContent(
      {required this.sendUser, required this.acceptUser, super.key});

  final String sendUser;
  final String acceptUser;

  static const routeName = '/chattingContent';
  @override
  State<ChattingContent> createState() => _ChattingContentState();
}

class _ChattingContentState extends State<ChattingContent> {
  bool searchMode = false;
  ScrollController _scrollController = ScrollController();
  List jsonDataList = [];
  ChattingProvider? _chattingProvider;

  RichText? finshedFindWidget;
  List<TextSpan>? fintWordTextSpanList;

  late AppBar searchAppBar;
  late AppBar basicAppBar;

  TextEditingController chattingBarController = TextEditingController();

  TextEditingController searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  // message date
  String time(index) {
    bool isSameDate = false;
    String? newDate = '';

    if(index == 0){
      newDate =  MessageTime.groupMessageDateAndTime(jsonDataList[index]['date'].toString());
      return newDate;
    }else {
      final DateTime date = MessageTime.returnDateAndTimeFormat(jsonDataList[index]['date'].toString());
      final DateTime prevDate = MessageTime.returnDateAndTimeFormat(jsonDataList[index -1]['date'].toString()); // 0일 때 문제
      isSameDate = date.isAtSameMomentAs(prevDate);
      newDate =  isSameDate ?  '' : MessageTime.groupMessageDateAndTime(jsonDataList[index]['date'].toString()).toString() ;
      return newDate;
    }
  }

  // message time
  String timeOfHourandMinute(index){
    bool isSameDate = false;
    String? newDate = '';

    if (index == jsonDataList.length - 1){
      newDate = MessageTime.groupMessageHoureandMinute(jsonDataList[index]['date']);
      return newDate;
    }else {
      final DateTime date = MessageTime.returnHourAndMinuteFormat(jsonDataList[index]['date'].toString());
      final DateTime prevDate = MessageTime.returnHourAndMinuteFormat(jsonDataList[index + 1]['date'].toString()); // 0일 때 문제
      isSameDate = date.isAtSameMomentAs(prevDate);
      newDate =  isSameDate ?  '' : MessageTime.groupMessageHoureandMinute(jsonDataList[index]['date'].toString());
      return newDate;
    }
  }

  void SendMessage() async {
    if (chattingBarController.text.isNotEmpty) {
      final data = {
        "sendUser": widget.sendUser,
        "acceptUser": widget.acceptUser,
        "message": chattingBarController.text,
        "token": jwtToken,
      };
      chattingBarController.clear();
      final response = await ServerResponseOKTemplate('/message/send', data);
      if (response != null) {
        _chattingProvider!.upDataContent(widget.sendUser, widget.acceptUser);
      }
    }
  }


  // why did i make this??
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void didChangeDependencies() async {
    //provider allocation
    _chattingProvider = Provider.of<ChattingProvider>(context, listen: false);
    _chattingProvider!.upDataContent(widget.sendUser, widget.acceptUser);

    // searchAppBar
    searchAppBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.grey[100],
      leading: Icon(
        Icons.search,
        color: Colors.black,
      ),
      actions: [
        TextButton(
            onPressed: () {
              setState(() {
                searchMode = false;
              });
            },
            child: Text(
              '취소',
              style: TextStyle(color: Colors.black),
            ))
      ],
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextFormField(
          controller: searchController,
          focusNode: _focusNode,
          cursorColor: Colors.blue,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: '내용을 입력하시오.'),
        ),
      ),
    );
    // basic appBar
    basicAppBar = AppBar(
      centerTitle: true,
      title: Text(
        widget.sendUser,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                searchMode = true;
              });
            },
            icon: Icon(Icons.search))
      ],
      elevation: 0,
      backgroundColor: Colors.white,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchMode == true ? searchAppBar : basicAppBar,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Consumer(
                      builder: (context, value, child) {
                        return ListView.builder(
                          controller: _scrollController,
                            itemCount: Provider.of<ChattingProvider>(context)
                                .chattingContents
                                .length,
                            itemBuilder: (context, index) {
                              jsonDataList = Provider.of<ChattingProvider>(context)
                                      .chattingContents;
                              print(jsonDataList);
                              bool isMe = widget.acceptUser == jsonDataList[index]['acceptUser'];
                              if (jsonDataList.isEmpty) {
                                return Center(
                                  child: Text('채팅 내용이 없습니다.'),
                                );
                              }
                              String timedate = time(index);
                              return Column(
                                children: [
                                  // date display
                                  if(timedate != '')
                                  Center(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Text(time(index), style: TextStyle(color: Colors.white),)),
                                  ),
                                  ChatBubbleWidget(
                                    isMe: isMe,
                                    jsonData: jsonDataList[index],
                                    time: timeOfHourandMinute(index),
                                  ),
                                ],
                              );
                            });
                      },
                    )),
              ),
            ),
            if (searchMode == false)
              MySendMessageBar(
                onTap: SendMessage,
                textController: chattingBarController,
              )
          ],
        ),
      ),
    );
  }
}
