import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/chatting_page/chatting_searchmode.dart';

class Chatting extends StatefulWidget {
  const Chatting({super.key});

  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  final TextEditingController textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('userName'),
          centerTitle: false,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pushNamed(context, ChatSearchMode.routeName);
                    });
                  },
                  icon: Icon(Icons.search)),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Text('메세지', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
            SizedBox(height: 10,),
            Text('여기서 부터는 최근 메세지들')
            ],
          ),
        ));
  }
}
