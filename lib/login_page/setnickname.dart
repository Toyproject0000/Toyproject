import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetNickName extends StatefulWidget {
  const SetNickName({Key? key}) : super(key: key);
  static const routeName = '/nickName';

  @override
  State<SetNickName> createState() => _SetNickNameState();
}

class _SetNickNameState extends State<SetNickName> {
  void _profile(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('닉네임 설정'),
            content: SingleChildScrollView(
              child: Column(
                children: [
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
                      SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(hintText: '닉네임 설정'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      '띄어쓰기 없이 2글자 이상으로 작성해주세요',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ]
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Center(
                      child: TextButton(
                        onPressed: (){},
                        child: Text('설정',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: TextButton(
                        onPressed: (){},
                        child: Text('설정',
                          style: TextStyle(
                            color: Colors.grey,
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              CircleAvatar(
                radius: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      '닉네임 설정',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => _profile(context),
                      child: Icon(Icons.add),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
