import 'dart:ffi';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../server/Server.dart';

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
  String? number;
  String encryptionNumber = '';
  String authenticationNumber = '';
  String name = '';
  final _focusNode = FocusNode();

  void _tryValidation() async {
    final isValid = _foromKey.currentState!.validate();
    if (isValid) {
      _foromKey.currentState!.save();
      final data = {'name': name, 'phoneNumber': number};
      final authenticationData = {
        'rawNum': authenticationNumber,
        'num': encryptionNumber
      };

      ServerFindId server = ServerFindId();
      final String? answer = await server.sendFindId(data, context);
      final String? numberAnswer = await server.authenticationNumberCheck(authenticationData, context);
      if(answer != null && numberAnswer == null){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text('${name}님에 이메일은 ${answer} 입니다.'),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.popUntil(context, ModalRoute.withName('/'));
              }, child: Text('확인', style: TextStyle(
                color: Colors.blue, fontSize: 18
              ),))
            ],
          );
        });
      }else if (numberAnswer == 'no'){
        Flushbar(
          margin: EdgeInsets.symmetric(horizontal: 15),
          flushbarPosition: FlushbarPosition.TOP,
          duration: Duration(seconds: 2),
          message: '인증번호가 맞지 않습니다.' ,
          messageSize: 15,
          borderRadius: BorderRadius.circular(4),
          backgroundColor: Colors.white,
          messageColor: Colors.red,
          boxShadows: [
            BoxShadow(color: Colors.black, blurRadius: 8)
          ],
        ).show(context);
      } else {
        Flushbar(
          margin: EdgeInsets.symmetric(horizontal: 15),
          flushbarPosition: FlushbarPosition.TOP,
          duration: Duration(seconds: 2),
          message: '가입되어 있지 않은 아이디 입니다.' ,
          messageSize: 15,
          borderRadius: BorderRadius.circular(4),
          backgroundColor: Colors.white,
          messageColor: Colors.red,
          boxShadows: [
            BoxShadow(color: Colors.black, blurRadius: 8)
          ],
        ).show(context);
      }
    }
  }

  void _tryNumberValidation() {
    final isValid = _numberKey.currentState!.validate();

    if (isValid) {
      _numberKey.currentState!.save();
      final data = {'phoneNumber': number};
      final authentication = numberAuthentiaction();
      authentication.sendPhoneNumber(data).then((value) {
        setState(() {
          encryptionNumber = authentication.AuthenticationNumber!;
        });
        Flushbar(
          margin: EdgeInsets.symmetric(horizontal: 15),
          flushbarPosition: FlushbarPosition.TOP,
          duration: Duration(seconds: 2),
          message: '인증번호를 전송했습니다.' ,
          messageSize: 15,
          borderRadius: BorderRadius.circular(4),
          backgroundColor: Colors.white,
          messageColor: Colors.black,
          boxShadows: [
            BoxShadow(color: Colors.black, blurRadius: 8)
          ],
        ).show(context);
      });
    }
  }

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
          border: Border.all(color: Colors.grey, width: 1.0),
        ),
        child: Form(
          key: _foromKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return '아이디를 다시 입력해주세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
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
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    )),
                child: Row(
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
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text(
                        '인증번호 요쳥',
                        style: TextStyle(color: Colors.blue, fontSize: 13),
                      ),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(_focusNode);
                        _tryNumberValidation();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                focusNode: _focusNode,
                validator: (value) {
                  if (value!.length < 6) {
                    return '올바른 인증번호를 입력하시오';
                  }
                  return null;
                },
                onSaved: (value) {
                  authenticationNumber = value!;
                },
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
                  onPressed: () {
                    _tryValidation();
                  },
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
