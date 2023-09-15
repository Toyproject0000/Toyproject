import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/component/mySendMessageBar.dart';
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
  ScrollController scrollController = ScrollController();
  List? jsonDataList;
  ChattingProvider? _chattingProvider;

  RichText? finshedFindWidget;
  List<TextSpan>? fintWordTextSpanList;

  late AppBar searchAppBar;
  late AppBar basicAppBar;

  TextEditingController chattingBarController = TextEditingController();

  TextEditingController searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();

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
                      return Provider.of<ChattingProvider>(context).chattingContent;
                    },
                  ),
                ),
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
