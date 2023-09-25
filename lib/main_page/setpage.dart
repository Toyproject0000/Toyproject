import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/provider/setPageData.dart';


class SetPage extends StatefulWidget {
  const SetPage({Key? key}) : super(key: key);
  static const routeName = '/setPage';

  @override
  State<SetPage> createState() => SetPageState();
}

class SetPageState extends State<SetPage> {
  SetPageProvider _changeNotifier = SetPageProvider();

  late int currentIndex;
  
  late List<Widget> screens;
  
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    // allocation data
    currentIndex = Provider.of<SetPageProvider>(context).currentIndex;
    screens = Provider.of<SetPageProvider>(context).screens;
    _changeNotifier = Provider.of<SetPageProvider>(context, listen: false);

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
          onTap: (index) => _changeNotifier.ChangeScreen(index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.pencil), label: 'write'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          ],
        ),
      ),
    );
  }
}
