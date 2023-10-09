import 'dart:convert';

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/provider/chattingProvider.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';


class ChatBubbleWidget extends StatelessWidget {

  final Map<String, dynamic> jsonData;
  final String time;
  final bool isMe;
  late ChattingProvider _chattingProvider;

  void messageDelete() async {
    final data = {
      'token' : jwtToken,
      'sendUser' : jsonData['sendUser'],
      'acceptUser' : jsonData['acceptUser'],
      'message' : jsonData['message'],
      'date' : jsonData['date']
    };

    final respose = await ServerResponseOKTemplate('/message/delete', data);
    if(respose != null){
      _chattingProvider.upDataContent(jsonData['sendUser'], jsonData['acceptUser']);
    }
  }

  Widget _buildLongPressMenu(context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(isMe)
            Column(
              children: [
                ListTile(
                  onTap: messageDelete,
                  title: Text('삭제', textAlign: TextAlign.center, style: TextStyle(color: Colors.red),),
                ),
                Divider(color: Colors.grey, thickness: 1,),
              ],
            ),
            ListTile(
              onTap: (){},
              title: Text('복사', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),
            )
          ],
        ),
    );
  }

  ChatBubbleWidget({
    required this.time,
    required this.jsonData,
    required this.isMe,
    super.key});

  @override
  Widget build(BuildContext context) {
    _chattingProvider = Provider.of<ChattingProvider>(context, listen: false);
    if(isMe){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          Text(time, style: TextStyle(color: Colors.black38),),
          SizedBox(width: 7,),
          CustomPopupMenu(
            pressType: PressType.longPress,
            menuBuilder: () => _buildLongPressMenu(context),
            child: ChatBubble(
              clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 20),
              backGroundColor: Colors.blue,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Text(
                  jsonData['message'], style: TextStyle(color: Colors.white), 
                ),
              ),
            ),
          ),
        ],
      );
    }else{
      return GestureDetector(
        onLongPress: (){
          print('삭제할 부분');
        },
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
              ),
              SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(jsonData['message'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                  CustomPopupMenu(
                    pressType: PressType.longPress,
                    menuBuilder: () => _buildLongPressMenu(context),
                    child: ChatBubble(
                      clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                      backGroundColor: Color(0xffE7E7ED),
                      margin: EdgeInsets.only(top: 5),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Text(
                          jsonData['message'],
                          style: TextStyle(color: Colors.black),
                          
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(width: 7,),
            Text(time, style: TextStyle(color: Colors.black38))
            ],
          ),
        ),
      );
    }
  }
}

