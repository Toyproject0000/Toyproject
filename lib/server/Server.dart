import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../login_page/setnickname.dart';
import '../main_page/setpage.dart';

class JoinMemdership {
  Future<void> sendData(data, BuildContext context) async {
    final url = Uri.parse('http://172.30.1.20:8080/join');
    final headers = {'Content-Type': 'application/json'};
    print(data);

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

  Future<void> authenticationNumberCheck(data, context) async {
    final url = Uri.parse('http://172.30.1.20:8080/authentication-check');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        var jsonData = response.body;
        print('요청 성공');
        print(jsonData);
        if (jsonData == 'true') {
          print('최초 회원가입한 사람');
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
  final url = Uri.parse('http://172.30.1.20:8080/login');
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
    final url = Uri.parse('http://172.30.1.20:8080/authentication');
    final headers = {'Content-Type': 'application/json'};
    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(number));

      if (response.statusCode == 200) {
        var jsonData = response.body;
        print('요청 성공');

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

class ServerFindId {
  Future<void> sendFindId(data, context) async {
    final url = Uri.parse('http://172.30.1.20:8080/findId');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        var jsonData = response.body;
        if (jsonData == 'ok') {
          print('당근을 찾았어요');
        } else {
          print(jsonData);
        }
      }
    } catch (e) {
      print('네트워크 오류: $e');
    }
  }

  Future<void> authenticationNumberCheck(data, context) async {
    final url = Uri.parse('http://172.30.1.20:8080/authentication-check');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        var jsonData = response.body;
        print('요청 성공');
        print(jsonData);
        if (jsonData == 'true') {
          print('최초 id를 찾은 사람');
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

class FindPasswordServer {
  Future<String?> sendEmail(email, Function changeScreen) async {
    final url = Uri.parse('http://172.30.1.20:8080/findPassword/email');
    final headers = {'Content-Type': 'application/json'};
    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(email));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        print('요청 성공');
        print(jsonData);
        if (jsonData == 'true') {
          changeScreen();
          return jsonData;
        }
      } else {
        // 요청이 실패하거나 오류가 발생함
        print('요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('네트워크 에러: $e');
    }
  }

  Future<String?> checkdata(data) async {
    final url = Uri.parse('http://172.30.1.20:8080/findPassword/check');
    final headers = {'Content-Type': 'application/json'};
    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        print('요청 성공');
        if (jsonData == 'ok') {
          return jsonData;
        }
      } else {
        // 요청이 실패하거나 오류가 발생함
        print('요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('네트워크 에러: $e');
    }
  }

  Future<String?> setupPassword(password) async {
    final url = Uri.parse('http://172.30.1.20:8080/setPassword');
    final headers = {'Content-Type': 'application/json'};
    print(password);
    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(password));
      if (response.statusCode == 200) {
        var jsonData = response.body;
        print('요청 성공');
        print(jsonData);
        if (jsonData == 'ok') {
          
          print(jsonData);
        }
      } else {
        // 요청이 실패하거나 오류가 발생함
        print('요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('네트워크 에러: $e');
    }
  }
}

Future<String?> authenticationNumberCheck(data) async {
  final url = Uri.parse('http://172.30.1.20:8080/authentication-check');
  final headers = {'Content-Type': 'application/json'};

  try {
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      var jsonData = response.body;
      print('요청 성공');
      print(jsonData);
      if (jsonData == 'true') {
        return jsonData;
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
