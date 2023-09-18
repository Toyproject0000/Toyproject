import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/postingWidget.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class KnowledgePosts extends StatefulWidget {
  const KnowledgePosts({super.key});

  @override
  State<KnowledgePosts> createState() => _KnowledgePostsState();
}

class _KnowledgePostsState extends State<KnowledgePosts> {

  Widget PostsWidget = Center(child: CircularProgressIndicator(color: Colors.blue,));

  Future<void> GetMainData() async {
    final data = {'userId': globalUserId, 'token' : jwtToken, 'root' : LoginRoot, 'category' : '동기부여'};
    var mainData = await ServerResponseJsonDataTemplate('/main/recommend/category' ,data);

    List<Widget> FinishedWidgetList = 
        mainData.map<Widget>((factor) => PostingWidget(data:factor)).toList();
    setState(() {
      PostsWidget = ListView(children: FinishedWidgetList,);
    });
  }

  @override
  void didChangeDependencies() {
    GetMainData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PostsWidget;
  }
}