import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindId extends StatefulWidget {
  const FindId({super.key});
  static const routeName = '/findId';

  @override
  State<FindId> createState() => FindIdState();
}

class FindIdState extends State<FindId> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController authenticationController = TextEditingController();
  final _foromKey = GlobalKey<FormState>();
  final _numberKey = GlobalKey<FormState>();
  String number = '';
  bool numberError = false;

  void _tryValidation() {
    final isValid = _foromKey.currentState!.validate();
  }

  void _tryNumberValidation() {
    final isValid = _numberKey.currentState!.validate();

    if (isValid) {
      _numberKey.currentState!.save();
    }
  }

  // void isEmptyNumber() {
  //   setState(() {
  //     numberError = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text(
          '아이디 찾기',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width - 30,
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 1.0),
        ),
        child: Form(
          key: _foromKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter you name';
                  }
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(
                    hintText: '이름을 입력하시오',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _numberKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 11) {
                            return '전화번호 11자리를 입력해주세요';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          number = value!;
                        },
                        keyboardType: TextInputType.number,
                        controller: numberController,
                        decoration: InputDecoration(
                            hintText: '전화번호를 입력하시오',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.0,
                              ),
                            )),
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      '인증번호 확인',
                      style: TextStyle(color: Colors.blue, fontSize: 17),
                    ),
                    onPressed: () {
                      _tryNumberValidation();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: authenticationController,
                decoration: InputDecoration(
                    hintText: '인증번호 6자리 입력',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '확인',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
