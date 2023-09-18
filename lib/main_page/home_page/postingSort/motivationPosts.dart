import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/postingWidget.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class MotivationPosts extends StatefulWidget {
  const MotivationPosts({super.key});

  @override
  State<MotivationPosts> createState() => _MotivationPostsState();
}

class _MotivationPostsState extends State<MotivationPosts> {


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