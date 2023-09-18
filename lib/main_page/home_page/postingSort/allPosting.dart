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
  ScrollController _controller = ScrollController();
  Widget PostsWidget = Center(child: CircularProgressIndicator(color: Colors.blue,));

  Future<void> GetMainData() async {
    final data = {'id': globalUserId, 'token' : jwtToken, 'root' : LoginRoot};
    var mainData = await ServerResponseJsonDataTemplate('/main/recommend' ,data);
    List<Widget> FinishedWidgetList = 
        mainData.map<Widget>((factor) => PostingWidget(data:factor)).toList();
    setState(() {
      PostsWidget = ListView(controller: _controller ,children: FinishedWidgetList,);
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScrollEnd);
  }

  @override
  void dispose() {
    _controller.removeListener(_onScrollEnd);
    _controller.dispose();
    super.dispose();
  }

  void _onScrollEnd() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      // 스크롤이 끝까지 내려갔을 때 원하는 작업을 수행
      print('스크롤 끝까지 내려감!');
    }
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

