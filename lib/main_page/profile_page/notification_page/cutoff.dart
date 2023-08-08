import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cutoff extends StatefulWidget {
  const Cutoff({super.key});
  static const routeName = '/cut-off';

  @override
  State<Cutoff> createState() => _CutoffState();
}

class _CutoffState extends State<Cutoff> {

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