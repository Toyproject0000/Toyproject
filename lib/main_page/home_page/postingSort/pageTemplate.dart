import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/component/postingWidget.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class MainPageTemplate extends StatefulWidget {
  const MainPageTemplate({required this.category ,super.key});
  final String category;


  @override
  State<MainPageTemplate> createState() => _MainPageTemplateState();
}

class _MainPageTemplateState extends State<MainPageTemplate> {

  ScrollController _controller = ScrollController();
  Widget PostsWidget = Center(child: CircularProgressIndicator(color: Colors.blue,));
  List<Widget> FinishedWidgetList = [];
  List? mainData;

  Future<void> GetMainData() async {
    final data = {'userId': globalUserId, 'token' : jwtToken, 'root' : LoginRoot, 'category' : widget.category};
    mainData = await ServerResponseJsonDataTemplate('/main/recommend/category' ,data);
    if(mounted){
      setState(() {});
    }
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
      final data = {'userId': globalUserId, 'token': jwtToken, 'root': LoginRoot, 'category' : widget.category};
      // newData category
      var newData = await ServerResponseJsonDataTemplate('/main/recommend/category', data);
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

  Future refresh() async {}

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
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