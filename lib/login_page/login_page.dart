import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/login_page/join_membership_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassworld = '';

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width - 50,
                    height: 330,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Form(
                      key : _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '아이디를 입력하시오';
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
                                  hintText: '아이디'),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '비밀번호를 입력하시오';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userPassworld = value!;
                              },
                              onChanged: (value) {
                                userPassworld = value;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  hintText: '비밀번호'),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.check_circle, size: 20),
                                  ),
                                  Text(
                                    '로그인 상태를 유지',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            // 로그인 버튼
                            ElevatedButton(
                              onPressed: () {
                                _tryValidation();
                              },
                              child: Text(
                                '로그인',
                                style: TextStyle(
                                  fontSize: 30,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '아이디 찾기',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '비밀번호 찾기',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Joinmembership.routeName);
                      },
                      child: Text(
                        '회원가입',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
