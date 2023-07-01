import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/main_page/setpage.dart';
import 'package:http/http.dart' as http;

class NickName extends StatefulWidget {
  const NickName({Key? key}) : super(key: key);
  static const routeName = '/nickname';

  @override
  State<NickName> createState() => _NickNameState();
}

class _NickNameState extends State<NickName> {
  String nickName = '';
  final _formKey = GlobalKey<FormState>();
  bool setable = false;
  bool AdjustNickName = false;
  bool nicknameError = false;


  Future<void> sendData(data, context) async {
    final url = Uri.parse('http://172.30.1.12:8080/join');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        // 요청이 성공적으로 처리됨
        print('요청 성공');
        Navigator.pushNamed(context, SetPage.routeName);
      } else {
        // 요청이 실패하거나 오류가 발생함
        print('요청 실패: ${response.statusCode}');
      }
    } catch (error) {
      // 네트워크 오류 발생
      print('네트워크 오류: $error');
    }
  }

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        setable = true;
        AdjustNickName = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('닉네임 설정'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25,),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    _tryValidation();
                  },
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
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: '닉네임 설정',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                            color: Colors.grey, // 하단 테두리 색상을 grey로 설정
                              width: 2.0,
                            ),
                          ),
                        ),
                      validator: (value){
                        // 중복확인하는 코드
                        if(value!.length < 2 ){
                          setState(() {
                            nicknameError = true;
                          });

                        }
                        else if (value.contains(' ')) {
                          setState(() {
                            nicknameError = true;
                          });
                        }
                        else{
                          nicknameError = false;
                          return null;
                        }
                      },
                      onSaved: (value) {
                        nickName = value!;
                      },
                      onChanged: (value){
                        if(nickName != value){
                          // _tryValidation();
                          setable = false;
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            if(AdjustNickName == false)
            Center(
              child: Text(
                '닉네임은 중복될 수 없으며 2글자 이상 작성해주세요.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            if(AdjustNickName == true)
              Center(
                child: Text(
                  nicknameError == false ? '사용가능한 닉네임 입니다.' : '사용할 수 없는 닉네임 입니다.',
                  style: TextStyle(color: nicknameError == false ? Colors.green : Colors.red),
                ),
              ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if(setable == true) {
                      try {
                        var data = {
                          'nickname': nickName,
                        };
                        sendData(data, context);
                        Navigator.pushNamed(context, SetPage.routeName);
                      } catch (e) {
                        print(e);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Unable to set NickName'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        }
                      }
                    }
                    else{
                      if(mounted){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '중복확인을 하시오'),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                      '설정',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3), // 테두리를 둥글게 하려면 원하는 값으로 변경
                    ),
                    primary: Colors.blue, // 배경색을 파란색으로 변경
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
    // return AlertDialog(
    //   title: Text('닉네임 설정'),
    //   content: SingleChildScrollView(
    //     child: Column(children: [
    //       Row(
    //         children: [
    //           TextButton(
    //             onPressed: () {
    //               _tryValidation();
    //             },
    //             child: Text(
    //               '중복확인',
    //               style: TextStyle(
    //                 color: Colors.blue,
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Expanded(
    //             child: Form(
    //               key: _formKey,
    //               child: TextFormField(
    //                 decoration: InputDecoration(
    //                     hintText: '닉네임 설정',
    //                 ),
    //                 validator: (value){
    //                   // 중복확인하는 코드
    //                   if(value!.length < 2 ){
    //                     return '띄어쓰기 없이 2글자 이상으로 작성해주세요';
    //                   }
    //                   else if (value.contains(' ')) {
    //                     return '띄어쓰기를 포함할 수 없습니다.';
    //                   }
    //                   return null;
    //                 },
    //                 onSaved: (value) {
    //                   nickName = value!;
    //                 },
    //                 onChanged: (value){
    //                   if(nickName != value){
    //                     // _tryValidation();
    //                     setable = false;
    //                   }
    //                 },
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       SizedBox(
    //         height: 10,
    //       ),
    //       Center(
    //         child: Text(
    //           '띄어쓰기 없이 2글자 이상으로 작성해주세요',
    //           style: TextStyle(
    //             fontSize: 12,
    //             color: Colors.grey,
    //           ),
    //         ),
    //       )
    //     ]),
    //   ),
    //   actions: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         Expanded(
    //           child: Center(
    //             child: TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: Text(
    //                 '취소',
    //                 style: TextStyle(
    //                   color: Colors.black87,
    //                   fontSize: 20,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Expanded(
    //           child: Center(
    //             child: TextButton(
    //               onPressed: () {
    //                 if(setable == true) {
    //                   try {
    //                     var data = {
    //                       'nickname': nickName,
    //                     };
    //                     sendData(data, context);
    //                   } catch (e) {
    //                     print(e);
    //                     if (mounted) {
    //                       ScaffoldMessenger.of(context).showSnackBar(
    //                         SnackBar(
    //                           content: Text(
    //                               'Unable to set NickName'),
    //                           backgroundColor: Colors.blue,
    //                         ),
    //                       );
    //                     }
    //                   }
    //                 }
    //                 else{
    //                   if(mounted){
    //                     ScaffoldMessenger.of(context).showSnackBar(
    //                       SnackBar(
    //                         content: Text(
    //                             '중복확인을 하시오'),
    //                         backgroundColor: Colors.blue,
    //                       ),
    //                     );
    //                   }
    //                 }
    //               },
    //               child: Text(
    //                 '설정',
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 20,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     )
    //   ],
    // );
  }
}
