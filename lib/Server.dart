import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login_page/setnickname.dart';
import 'main_page/setpage.dart';

class ServerConnection {
  final BuildContext context;

  ServerConnection(this.context);

  void fetchDataFromServer() async {
    var url = 'http://your-server-url.com/api/data';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // 데이터 전달 성공
      var data = response.body;
      // 수신한 데이터 처리
      // ...
    } else {
      // 데이터 전달 실패
      print('Failed to fetch data. Error: ${response.statusCode}');
    }
  }

  Future<void> sendData(data) async {
    final url = Uri.parse('http://172.30.1.68:8080/join');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        var jsonData = response.body;

        print('요청 성공');
        print(jsonData);
        if (jsonData == 'ok') {
          Navigator.pushNamed(context, NickName.routeName);
        } else if (jsonData == 'cancel') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('이미가입된 회원입니다.'),
              backgroundColor: Colors.blue,
            ),
          );
        }
      } else {
        // 요청이 실패하거나 오류가 발생함
        print('요청 실패: ${response.statusCode}');
      }
    } catch (error) {
      // 네트워크 오류 발생
      print('네트워크 오류: $error');
    }
  }
}

Future<void> loginSendData(data, BuildContext context, loginCheck) async {
  final url = Uri.parse('http://172.30.1.68:8080/login');
  final headers = {'Content-Type': 'application/json'};

  try {
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      var jsonData = response.body;
      print('요청 성공');
      print(jsonData);
      if (jsonData == 'ok') {
        Navigator.pushNamed(context, SetPage.routeName);
      } else if (jsonData == 'id 오류' || jsonData == '비번 오류') {
        loginCheck();
      }
    } else {
      // 요청이 실패하거나 오류가 발생함
      print('요청 실패: ${response.statusCode}');
    }
  } catch (error) {
    // 네트워크 오류 발생
    print('네트워크 오류: $error');
  }
}

class numberAuthentiaction {
  String? AuthenticationNumber;

  Future<void> sendPhoneNumber(number) async {
    final url = Uri.parse('http://172.30.1.68:8080/authentication');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(number));

      if (response.statusCode == 200) {
        var jsonData = response.body;
        print('요청 성공');

        AuthenticationNumber = jsonData;
        print(AuthenticationNumber);
      } else {
        // 요청이 실패하거나 오류가 발생함
        print('요청 실패: ${response.statusCode}');
      }
    } catch (error) {
      // 네트워크 오류 발생
      print('네트워크 오류: $error');
    }
  }

  Future<void> authenticationNumberCheck(authenticationNumber) async {
    print(AuthenticationNumber);
    if (AuthenticationNumber != null) {
      final url = Uri.parse('http://172.30.1.68:8080/authentication-check');
      final headers = {'Content-Type': 'application/json'};

      final data = {
        'rawNum': authenticationNumber,
        'num': AuthenticationNumber
      };

      try {
        final response =
            await http.post(url, headers: headers, body: jsonEncode(data));

        if (response.statusCode == 200) {
          var jsonData = response.body;
          print('요청 성공');
          if (jsonData == 'ok') {
            print('최초 회원가입한 사람');
          }
          AuthenticationNumber = jsonData;
        } else {
          // 요청이 실패하거나 오류가 발생함
          print('요청 실패: ${response.statusCode}');
        }
      } catch (error) {
        // 네트워크 오류 발생
        print('네트워크 오류: $error');
      }
    }
  }
}
