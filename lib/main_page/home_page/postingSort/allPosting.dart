import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/postingWidget.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({super.key});

  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  
  Widget PostsWidget = Center(child: CircularProgressIndicator(color: Colors.blue,));

  Future<void> GetMainData() async {
    final data = {'id': globalUserId, 'token' : jwtToken, 'root' : LoginRoot};
    var mainData = await ServerResponseJsonDataTemplate('/main/recommend' ,data);
    List<Widget> FinishedWidgetList = 
        mainData.map<Widget>((factor) => PostingWidget(data:factor)).toList();
    setState(() {
      PostsWidget = ListView(children: FinishedWidgetList,);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GetMainData();
  }

  @override
  Widget build(BuildContext context) {
    return PostsWidget;
  }
}

