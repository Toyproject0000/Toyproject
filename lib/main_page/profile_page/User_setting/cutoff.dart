import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/server/Server.dart';
import 'package:smart_dongne/server/userId.dart';

class Cutoff extends StatefulWidget {
  const Cutoff({super.key});
  static const routeName = '/cut-off';

  @override
  State<Cutoff> createState() => _CutoffState();
}

class _CutoffState extends State<Cutoff> {

  void cutoffUserData() async {
    final data = {'token' : jwtToken, 'reportingUserId' : globalUserId, 'reportingUserRoot' : LoginRoot};
    print(data);
    final response = await ServerResponseJsonDataTemplate('/find/post/user', data);
    print(response);
  }

  @override
  void didChangeDependencies() {
    cutoffUserData();
    super.didChangeDependencies();
  }

  bool notExist = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text('차단한 계정'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add))
        ],
      ),
      body: notExist == true ? Center(
        child: Text('차단한 계정이 없습니다.', style: TextStyle(color: Colors.grey),)
      ) : ListView(),
    );
  }
}