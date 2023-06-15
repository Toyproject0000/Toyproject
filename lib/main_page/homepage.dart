import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('hello'),
      ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 1.0)), // 라인효과
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            selectedIconTheme : IconThemeData(size: 30),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) => setState(() => currentIndex = index),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book,),
                label: 'Search'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.abc),
                label: 'write'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label : 'profile'
              ),
            ],
          ),
        ),
      );
    }
  }
