import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Joinmembership extends StatefulWidget {
  const Joinmembership({Key? key}) : super(key: key);

  static const routeName = '/join';

  @override
  State<Joinmembership> createState() => _JoinmembershipState();
}

class _JoinmembershipState extends State<Joinmembership> {
  final _formkey = GlobalKey<FormState>();

  String userEmail = '';
  String userPassword = '';
  String userName = '';
  int phoneNumber = 0;
  int dateofBirth = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                        fontSize: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '이메일을 입력하시오';
                      }
                      else if (value!.contains('@')){
                        return '이메일 형식을 입력하시오';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userEmail = value!;
                    },
                    onChanged: (value) {
                      userEmail = value;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: '이메일'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return '8글자 이상을 입력하시오';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userPassword = value!;
                    },
                    onChanged: (value) {
                      userPassword = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: '비밀번호'),
                  ),
                  TextFormField(
                    validator: (value) {
                      // 위에 입력한 비밀번호와 비교
                      return null;
                    },

                    onChanged: (value) {
                      userPassword = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: '비밀번호 확인'),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return '2글자 이상을 입력하시오';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userName = value!;
                    },
                    onChanged: (value) {
                      userName = value;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: '이름'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return '생년월일 8자리를 입력하시오';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      dateofBirth = int.parse(value!);
                    },
                    onChanged: (value) {
                      dateofBirth = int.parse(value);
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: '생년월일(8자리)'),
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
                    child: Center(
                      child: Text('통신사 입력 칸'),
                    ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              '남성',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(),
                          ),
                        ),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              '여성',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value.length < 11) {
                        return '전화번호를 올바르게 입력하시오';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      phoneNumber = int.parse(value!);
                    },
                    onChanged: (value) {
                      phoneNumber = int.parse(value);
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: '전화번호'),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '회원 가입하기',
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
        ),
      ),
    );
  }
}
