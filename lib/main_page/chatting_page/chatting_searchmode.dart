import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatSearchMode extends StatefulWidget {
  const ChatSearchMode({super.key});

  static const routeName = '/chat/search';

  @override
  State<ChatSearchMode> createState() => _ChatSearchModeState();
}

class _ChatSearchModeState extends State<ChatSearchMode> {
  final TextEditingController textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ),
        leadingWidth: 30,
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          padding: EdgeInsets.symmetric(horizontal: 15,),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Icon(Icons.search),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child: TextFormField(
                controller: textController,
                focusNode: _focusNode,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    hintText: '검색',
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none),
              )),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Text('최근 검색', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
            SizedBox(height: 10,),
            Text('여기서 부터는 최근 검색들')
          ],
        ),
      ),
    );
  }
}
