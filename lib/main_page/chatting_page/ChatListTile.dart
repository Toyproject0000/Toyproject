import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_dongne/component/timeWidget.dart';
import 'package:smart_dongne/main_page/chatting_page/chatting_Content.dart';

class ChatListTile extends StatelessWidget {

  final Map<String, dynamic> data;
  final Function(String sendUser, String acceptUser) onDismissed;
  const ChatListTile({
    required this.data,
    required this.onDismissed,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (context) => onDismissed(data['sendUser'], data['acceptUser'])
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        title: Text(data['sendUser'], style: TextStyle(color: Colors.black),),
        subtitle: Text(data['message'], overflow: TextOverflow.ellipsis),
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 25,
        ),
        trailing: TimeWidget(contentsTime: data['date']),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChattingContent(sendUser: data['sendUser'], acceptUser: data['acceptUser'],)));
        },
      ),
    );
  }
}