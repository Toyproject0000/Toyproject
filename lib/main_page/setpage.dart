import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_page/home_page.dart';
import 'profile_page/profile.dart';
import 'search_page/search_page.dart';
import 'writing_page/writing_page.dart';

class SetPage extends StatefulWidget {
  const SetPage({Key? key}) : super(key: key);
  static const routeName = '/setPage';

  @override
  State<SetPage> createState() => SetPageState();
}

class SetPageState extends State<SetPage> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    SearchPage(),
    WritingPage(),
    ProfilePage(),
  ];

  void changeClass() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: Colors.grey, width: 1.0)), // 라인효과
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(size: 30),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) => setState(() => currentIndex = index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.numbers,
                ),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.pencil), label: 'write'),
            // BottomNavigationBarItem(icon: Icon(Icons.))
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          ],
        ),
      ),
    );
  }
}
