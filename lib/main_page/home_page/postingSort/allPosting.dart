import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/postingWidget.dart';
import 'package:smart_dongne/main.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({super.key});

  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  ScrollController _controller = ScrollController();
  Widget PostsWidget = Center(
      child: CircularProgressIndicator(
    color: Colors.blue,
  ));
  List? mainData;

  Future<void> GetMainData() async {
    print('실행중?');
    final data = {'id': globalUserId, 'token': jwtToken, 'root': LoginRoot};
    mainData = await ServerResponseJsonDataTemplate('/main/recommend', data);
    setState(() {});
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

  void _onScrollEnd() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      final data = {'id': globalUserId, 'token': jwtToken, 'root': LoginRoot};
      var newData = await ServerResponseJsonDataTemplate('/main/recommend', data);
      setState(() {
        mainData!.addAll(newData);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GetMainData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: GetMainData,
      color: Colors.blue,
      child: mainData == null
          ? Center(
              child: CircularProgressIndicator(color: Colors.blue,),
            )
          : ListView.builder(
              itemCount: mainData!.length + 1,
              controller: _controller,
              itemBuilder: (context, index) {
                if (index < mainData!.length) {
                  return PostingWidget(
                    data: mainData![index],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }
              },
            ),
    );
  }
}
