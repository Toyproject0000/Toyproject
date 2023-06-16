import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/setpage.dart';

class NickName extends StatefulWidget {
  const NickName({Key? key}) : super(key: key);

  @override
  State<NickName> createState() => _NickNameState();
}

class _NickNameState extends State<NickName> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('닉네임 설정'),
      content: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  '중복확인',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(hintText: '닉네임 설정'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '띄어쓰기 없이 2글자 이상으로 작성해주세요',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          )
        ]),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '취소',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SetPage.routeName);
                  },
                  child: Text(
                    '설정',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
