import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:intl/intl.dart';

class ChatBubbleWidget extends StatelessWidget {

  final String acceptUser;
  final Map<String, dynamic> jsonData;
  final String time;

  const ChatBubbleWidget({
    required this.time,
    required this.acceptUser,
    required this.jsonData,
    super.key});

  @override
  Widget build(BuildContext context) {
    // DateTime dateTime = DateTime.parse(jsonData['date']);
    // String time = DateFormat('HH:mm').format(dateTime).toString(); 


    if(acceptUser == jsonData['acceptUser']){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(time, style: TextStyle(color: Colors.black38),),
          SizedBox(width: 7,),
          ChatBubble(
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
        ],
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
          SizedBox(width: 7,),
          Text(time, style: TextStyle(color: Colors.black38))
          ],
        ),
      );
    }
  }
}