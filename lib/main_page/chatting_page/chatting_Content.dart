import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:smart_dongne/server/chatServer.dart';
import 'package:smart_dongne/server/userId.dart';

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
  RichText? finshedFindWidget;
  List<TextSpan>? fintWordTextSpanList;

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
      'token' : jwtToken,
    };

    final response = await chattingContentSearch(data);
    final jsonData = jsonDecode(response);
    print(jsonData);
  }

  void findWord(String value){
    print(value);
    for(int i = 0; i <= jsonData!.length - 1; i++){
      String message = jsonData![i]['message'];
      List<String> findWordList = message.split(value);
      fintWordTextSpanList = findWordList.map((word) => findWordRichText(word, value)).toList();
      finshedFindWidget = RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.white),
          children: fintWordTextSpanList
      ),);
      setState(() { });
    }
  }

  TextSpan findWordRichText(word, value){
    if(word == value){
      return TextSpan(text: value, style: TextStyle(color: Colors.red, background: Paint()..color = Colors.red));
    }else{
      return TextSpan(text: word, style: TextStyle(color: Colors.white),);  
    }

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
          // child: Text(
          //   data['message'] == null ? 'null' : data['message'],
          //   style: TextStyle(color: Colors.white),
          // ),
          child: finshedFindWidget == null ? RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white),
              children: fintWordTextSpanList == null ? [
                TextSpan(
                  text :data['message'] == null ? 'null' : data['message'], style: TextStyle(color: Colors.white),)
              ] : fintWordTextSpanList
            ) 
          ) : finshedFindWidget,
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
          )
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
      'acceptUser' : acceptUser,
      'token' : jwtToken,
    };
    final response = await ServerResponseJsonDataTemplate('/message/user' ,data);
    setState(() {
      reverseList = response.reversed.toList();
    });
  }

  @override
  void initState() {
    searchAppBar = AppBar(
    elevation: 0,
    backgroundColor: Colors.grey[100],
    leading: Icon(Icons.search, color: Colors.black,),
    actions: [
      TextButton(
        onPressed: (){
          setState(() {
            searchMode = false;
          });
        }, 
        child: Text('취소', style: TextStyle(color: Colors.black),))
    ],
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextFormField(
          onFieldSubmitted: (value) => findWord(value),
          controller: searchController,
          focusNode: _focusNode,
          cursorColor: Colors.blue,
          style: TextStyle(
            color: Colors.black
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: '내용을 입력하시오.'
          ),
        ),
      ),
    );

    basicAppBar = AppBar(
      centerTitle: true,
      title: Text(sendUser! , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(mounted){
      super.setState(fn);
    }
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
              child: GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
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
                ),
              ),
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
                  }, icon: Icon(Icons.send, color: activationSendButton == false ? null : Colors.blue,),
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