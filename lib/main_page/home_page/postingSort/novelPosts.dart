import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/postingWidget.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class NovelPosts extends StatefulWidget {
  const NovelPosts({super.key});

  @override
  State<NovelPosts> createState() => _NovelPostsState();
}

class _NovelPostsState extends State<NovelPosts> {

  Widget PostsWidget = Center(child: CircularProgressIndicator(color: Colors.blue,));

  Future<void> GetMainData() async {
    final data = {'userId': globalUserId, 'token' : jwtToken, 'root' : LoginRoot, 'category' : '소설'};
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