import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/home_page/Content_page.dart';
import 'package:smart_dongne/main_page/home_page/search_bar.dart';

import '../../server/Server.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late dynamic mainData;
  late Map<String, dynamic> firstPosting;
  late List<Container> FinishedWidgetList;
  Column? BuildFinshWidget;
  late dynamic jsonData;

  // 게시물에 쓸 데이터들
  Container PostingWidget = Container();

  Container MakeaPosting(data) {
    final contentsDate = data['date'];
    final PostingContent = data['contents'];

    return Container(
      child: Column(
        children: [
          Divider(
            color: Colors.black,
            height: 0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Text(data['nickname'], style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Text(
                  '제목:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  data['title'],
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ShowaContents.routeName,
                  arguments: ContentArguments(PostingContent));
            },
            child: AspectRatio(
              aspectRatio: 4 / 4,
              child: Image.file(
                File(data['imgLocation']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.all(7),
              child: Row(
                children: [Text(contentsDate.substring(0, 10))],
              )),
        ],
      ),
    );
  }

  void GetMainData() async {
    final data = {'id': 'alsdnd336@naver.com'};
    mainData = await mainPageData(data);
    jsonData = jsonDecode(mainData);
    FinishedWidgetList =
        jsonData.map<Container>((data) => MakeaPosting(data)).toList();
    setState(() {
      BuildFinshWidget = Column(children: FinishedWidgetList);
    });
  }

  @override
  void initState() {
    super.initState();
    GetMainData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Search_Page_bar.routeName);
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          '전체',
                          style: TextStyle(color: Colors.black),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.grey[500]),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          '동기부여',
                          style: TextStyle(color: Colors.black),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.grey[400]),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          '소설',
                          style: TextStyle(color: Colors.black),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.grey[400]),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          '일기',
                          style: TextStyle(color: Colors.black),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.grey[400]),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          '지식',
                          style: TextStyle(color: Colors.black),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.grey[400]),
                      ),
                    ]),
              ),
              // tempWidget
              BuildFinshWidget == null
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                        backgroundColor: Colors.grey,
                      ),
                    )
                  : BuildFinshWidget!
              // tempWidget
            ],
          ),
        ),
      ),
    );
  }
}
