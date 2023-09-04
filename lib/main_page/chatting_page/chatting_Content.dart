import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/chatting_page/ChatBubbleWidget.dart';
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

  bool searchMode = false;
  ScrollController scrollController = ScrollController();
  List? jsonDataList;

  RichText? finshedFindWidget;
  List<TextSpan>? fintWordTextSpanList;

  late AppBar searchAppBar;
  late AppBar basicAppBar;

  TextEditingController chattingBarController = TextEditingController();

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
  }

  void findWord(String value){
    for(int i = 0; i <= jsonDataList!.length - 1; i++){
      String message = jsonDataList![i]['message'];
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

  void SendMessage() async {
    if(chattingBarController.text.isNotEmpty){
        final data = {
        "sendUser" : sendUser,
        "acceptUser" : acceptUser,
        "message" : chattingBarController.text
      };
      chattingBarController.clear();
      final response = await ServerResponseOKTemplate('/message/send', data);
      if(response != null){
        bringbackDataofMessage();
      }
    }
  }

  Future<Widget> bringbackDataofMessage() async {
    final data = {
      'sendUser' : sendUser,
      'acceptUser' : acceptUser,
      'token' : jwtToken,
    };
    final List response = await ServerResponseJsonDataTemplate('/message/user' ,data);
    // BuildMessage
    final MessageList = response.map<Widget>((data) => ChatBubbleWidget(acceptUser: acceptUser!, jsonData: data,)).toList();

    return Column(children : MessageList);
  }

  // sendMessageBar

  Widget sendMeesageBar(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
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
            onPressed:() => SendMessage(),
            icon: Icon(Icons.send, color: Colors.blue,),
          )
        ],
      ),
    
    );
  }

 // why did i make this??
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

    // searchAppBar 
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

    // basic appBar
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

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchMode == true ? searchAppBar : basicAppBar,
      body: SafeArea(
        // child: jsonDataList == null ? Center(child: CircularProgressIndicator(color: Colors.blue,),) :
        child : Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10,0,10,10),
                  // FutureBuilder
                  child: FutureBuilder(
                    future: bringbackDataofMessage(),
                    builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      // 데이터를 화면에 표시합니다.
                      return snapshot.data!;
                    },
                  ),
                ),
              ),
            ),
            if(searchMode == false)
            sendMeesageBar()
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