import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/home_page/postingSort/allPosting.dart';
import 'package:smart_dongne/main_page/home_page/postingSort/diaryPosts.dart';
import 'package:smart_dongne/main_page/home_page/postingSort/knowledge.dart';
import 'package:smart_dongne/main_page/home_page/postingSort/motivationPosts.dart';
import 'package:smart_dongne/main_page/home_page/postingSort/novelPosts.dart';
import 'package:smart_dongne/main_page/home_page/search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Container(),
          title: Text(
            'Writer',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: MySearchDelegate());
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 25,
                ))
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: const TabBar(

            indicatorColor: Colors.blue,
            isScrollable: true,
            tabs: [
              Text('전체'),
              Text('동기부여'),
              Text('소설'),
              Text('일기'),
              Text('지식'),
            ],
          ),
          
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: TabBarView(
              children: [
                AllPosts(),
                MotivationPosts(),
                NovelPosts(),
                DiaryPosts(),
                KnowledgePosts()
              ]),
          ),
        ),
    );
  }
}
