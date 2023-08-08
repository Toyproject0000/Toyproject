import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/home_page/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Search_Page_bar.routeName);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '전체', style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.grey[500]),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '동기부여', style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.grey[400]),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '소설', style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.grey[400]),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '일기', style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.grey[400]),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '지식', style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.grey[400]),
                  ),
                ]),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
