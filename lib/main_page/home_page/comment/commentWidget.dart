import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({required this.postsId ,super.key});
  final int postsId;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {

  Widget loadingWidget = Center(child: CircularProgressIndicator(color: Colors.blue),);

  Widget CommentsWidget(Map<String, dynamic> jsonData){
    return Container(
      child: Column(
        children: [
          Text(jsonData['nickname'], style: TextStyle(color: Colors.black),),
          SizedBox(height: 10,),
          Text(jsonData['contents'], style: TextStyle(color: Colors.grey[700]),),
          SizedBox(height: 10,),
          Text('좋아요', style: TextStyle(color: Colors.blue),)
        ],
      ),
    );
  }

  Future<void> CommentList() async {
    final data = {'id' : widget.postsId, 'token' : jwtToken};
    final List? response = await ServerResponseJsonDataTemplate('/reply/post', data);
    print(response);
    if(response!.isEmpty){
      setState(() {
        loadingWidget =  Center(child: Text('댓글이 없습니다.', style: TextStyle(color: Colors.black),),);      
      });
    } else {
      List<Widget> MessageWidgetList = response.map<Widget>((data) => CommentsWidget(data)).toList();
      setState(() {
        loadingWidget =  ListView(children: MessageWidgetList,);      
      });
    }
  }

  @override
  void didChangeDependencies() {
    CommentList();
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return loadingWidget;
  }
}