import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewPassWord extends StatefulWidget {
  const NewPassWord({super.key});

  static const routeName = '/newPassword';

  @override
  State<NewPassWord> createState() => _NewPassWordState();
}

class _NewPassWordState extends State<NewPassWord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          '비밀번호 재설정',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '새로운 비밀번호를 입력해 주세요',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: '새로운 비밀번호를 입력하시오',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: '비밀번호 확인',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  '비밀번호 변경',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue, onPrimary: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
