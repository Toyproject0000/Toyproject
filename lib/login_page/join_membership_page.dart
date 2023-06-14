import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Joinmembership extends StatefulWidget {
  const Joinmembership({Key? key}) : super(key: key);

  static const routeName = '/join';

  @override
  State<Joinmembership> createState() => _JoinmembershipState();
}

class _JoinmembershipState extends State<Joinmembership> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(top: 70),
                  child: Text(
                    'Smart DongNe',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 140,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintText: '아이디'),
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintText: '비밀번호'),
                        ),
                        TextFormField(
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
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintText: '이름'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.calendar_month),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintText: '생년월일(8자리)'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone_android),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintText: '통신사'),
                        ),
                        // Container(
                        //   padding: EdgeInsets.all(0.8),
                        //   height: 65,
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: Colors.grey, // 테두리 색상 설정
                        //       width: 2.0, // 테두리 두께 설정
                        //     ),
                        //     borderRadius:
                        //         BorderRadius.circular(8.0), // 테두리의 모서리 반경 설정
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        //       ElevatedButton(
                        //         onPressed: () {},
                        //         child: Text('남성'),
                        //         style: ElevatedButton.styleFrom(
                        //           backgroundColor: Colors.blue,
                        //           minimumSize: Size(double.infinity, 48),
                        //         ),
                        //       ),
                        //       ElevatedButton(
                        //         onPressed: () {},
                        //         child: Text('여성'),
                        //         style: ElevatedButton.styleFrom(
                        //           backgroundColor: Colors.blue,
                        //           minimumSize: Size(double.infinity, 48),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
