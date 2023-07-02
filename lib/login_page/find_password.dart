import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindPassword extends StatefulWidget {
  const FindPassword({Key? key}) : super(key: key);
  static const routeName = '/findpassword';

  @override
  State<FindPassword> createState() => _FindPasswordState();
}

class _FindPasswordState extends State<FindPassword> {

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          '비밀번호 찾기',
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Smart DongNe',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Center(
                  child: Text(
                    '비밀번호를 찾고자하는 아이디를 입력해주세요',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: '아이디'),
                ),
                SizedBox(height: 7,),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '다음',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 48),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
