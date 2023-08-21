import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:smart_dongne/server/chatServer.dart';

class ChattingContent extends StatefulWidget {
  const ChattingContent({super.key});

  static const routeName = '/chattingContent';
  @override
  State<ChattingContent> createState() => _ChattingContentState();
}

class _ChattingContentState extends State<ChattingContent> {
  String? sendUser;
  String? acceptUser;
  Column? ChattingContentColumn;
  bool searchMode = false;
  bool activationSendButton = false;
  ScrollController scrollController = ScrollController();
  List? jsonData;
  List? reverseList;



  late AppBar searchAppBar;
  late AppBar basicAppBar;

  TextEditingController chattingBarController = TextEditingController();
  FocusNode chattingBarFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  void sendSearchDataServer(content) async {
    final data = {
      "sendUser" : sendUser,
      "acceptUser" : acceptUser,
      "message" : content,
    };

    final response = await chattingContentSearch(data);
    final jsonData = jsonDecode(response);
  }

  void SendMessage(content) async {

    final data = {
      "sendUser" : sendUser,
      "acceptUser" : acceptUser,
      "message" : content
    };
    chattingBarController.clear();
    final response = await sendChattingContent(data);
    if(response != null){
       scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      bringbackDataofMessage();
    }
  }

  Widget MakeaChattingContentWidget(data){
    if(data['sendUser'] == sendUser){
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
            data['message'] == null ? 'null' : data['message'],
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }else {
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
                Text(data['acceptUser'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                ChatBubble(
                  clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                  backGroundColor: Color(0xffE7E7ED),
                  margin: EdgeInsets.only(top: 5),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Text(
                      data['message'],
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

  Widget chatBubbleWidget(index) {
    if(jsonData![index]['sendUser'] == sendUser){
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
            jsonData![index]['message'] == null ? 'null' : jsonData![index]['message'],
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
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
                Text(jsonData![index]['acceptUser'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                ChatBubble(
                  clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                  backGroundColor: Color(0xffE7E7ED),
                  margin: EdgeInsets.only(top: 5),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Text(
                      jsonData![index]['message'],
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

  void bringbackDataofMessage() async {
    final data = {
      'sendUser' : sendUser,
      'acceptUser' : acceptUser
    };
    final response = await aConversationWithaParticularPerson(data);
    jsonData = jsonDecode(response);
    reverseList = jsonData!.reversed.toList();
    setState(() {});
  }

  @override
  void initState() {
    searchAppBar = AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
      onPressed: (){
        setState(() {
          searchMode = false;
          });
        },
      ),
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(5),
        ),
        child: EditableText(
          controller: searchController,
          focusNode: _focusNode,
          cursorColor: Colors.blue, 
          style: TextStyle(
            color: Colors.black
          ), 
          backgroundCursorColor: Colors.blue,
          onSubmitted: (value){
            sendSearchDataServer(value);
          },
        ),
      ),
    );

    basicAppBar = AppBar(
      centerTitle: true,
      title: Text('usernickname', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      actions: [
        IconButton(onPressed: (){
          setState(() {
            searchMode = true;
          });
        }, icon: Icon(Icons.search))
      ],
      elevation: 0,
      backgroundColor: Colors.white,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    final args = ModalRoute.of(context)!.settings.arguments as SendUserData;  
    sendUser = args.sendUser;
    acceptUser = args.acceptUser;
    bringbackDataofMessage();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchMode == true ? searchAppBar : basicAppBar,
      body: SafeArea(
        child: jsonData == null ? Center(child: CircularProgressIndicator(color: Colors.blue,),) :
        Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10,0,10,10),
                child: ListView.builder(
                  controller: scrollController,
                  reverse: true,
                  itemCount: jsonData!.length ,
                  itemBuilder:(context, index){
                    return chatBubbleWidget(index);
                  }
                ),
              )
            ),
            if(searchMode == false)
            Container(
              decoration: BoxDecoration(
                color: Colors.white
              ),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value){
                          if(value == ''){
                            setState(() {
                              activationSendButton = false;
                            });
                          }else {
                            setState(() {
                              activationSendButton = true;
                            });
                          }
                        },
                      focusNode: chattingBarFocusNode,
                      controller: chattingBarController,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ) 
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ) 
                        ),
                        hintText: '메세지를 입력해주세요.'
                      ),
                      cursorColor: Colors.blue,
                    )
                  ),
                  IconButton(
                    onPressed: activationSendButton == false ? null : (){
                    SendMessage(chattingBarController.text);
                  }, icon: Icon(Icons.send, color: Colors.blue,),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SendUserData {
  final String? sendUser;
  final String? acceptUser;

  SendUserData(this.sendUser, this.acceptUser);
}