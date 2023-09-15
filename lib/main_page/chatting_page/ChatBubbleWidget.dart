import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatBubbleWidget extends StatelessWidget {

  final String acceptUser;
  final Map<String, dynamic> jsonData;

  const ChatBubbleWidget({
    required this.acceptUser,
    required this.jsonData,
    super.key});

  @override
  Widget build(BuildContext context) {
    if(acceptUser == jsonData['acceptUser']){
      return ChatBubble(
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
      );
    }else{
      return Container(
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
                Text(jsonData['acceptUser'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                ChatBubble(
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
              ],
            ),
          ],
        ),
      );
    }
  }
}