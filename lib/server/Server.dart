import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<dynamic> loginSendData(address ,data) async {
  final url = Uri.parse('http://192.168.0.199:8080${address}');
  final headers = {'Content-Type': 'application/json'};
  try {    
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      if(jsonData == 'id 오류' || jsonData == '비번 오류'){
        return null;
      }else{
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

Future<String?> nickNameSetUp(data) async {
  final url = Uri.parse('http://192.168.0.199:8080/edit-user/confirm');
  final headers = {'Content-Type': 'application/json'};
  print(data);
  try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        var jsonData = response.body;
        print('요청 성공');
        print(jsonData);
        if(jsonData == 'ok'){
          return 'ok';
        } else {
          return null;
        }

      } else {
      }
    } catch (error) {
      print('네트워크 오류: $error');
    }
  }
 
class numberAuthentiaction {
  String? AuthenticationNumber;

  Future<void> sendPhoneNumber(number) async {
    final url = Uri.parse('http://192.168.0.199:8080/authentication');
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

  Future<String?> sendFindId(data, context) async {
    final url = Uri.parse('http://192.168.0.199:8080/findId');
    final headers = {'Content-Type': 'application/json'};
    print(data);

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        var jsonData = response.body;
        if (jsonData == '가입되어 있지않음') {
          print(jsonData);
          return null;
        } else {
          return jsonData;
        }
      }
    } catch (e) {
      print('네트워크 오류: $e');
    }
  }

  Future<String?> authenticationNumberCheck(data, context) async {
    final url = Uri.parse('http://192.168.0.199:8080/authentication-check');
    final headers = {'Content-Type': 'application/json'};
    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        var jsonData = response.body;
        print('요청 성공');
        if (jsonData == 'true') {
          return null;
        } else {
          print(jsonData);
          return 'no';
        }
      } else {
        print('요청 실패: ${response.statusCode}');
        // 요청이 실패하거나 오류가 발생함
      }
    } catch (error) {
      // 네트워크 오류 발생
      print('네트워크 오류: $error');
    }
  }
}

class FindPasswordServer {
  Future<String?> sendEmail(email, Function changeScreen) async {
    final url = Uri.parse('http://192.168.0.199:8080/findPassword/email');
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
    final url = Uri.parse('http://192.168.0.199:8080/findPassword/check');
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

  Future<String?> setupPassword(password, context) async {
    final url = Uri.parse('http://192.168.0.199:8080/setPassword');
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
          showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text('비밀번호를 성공적으로 변경했습니다.'),
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
  final url = Uri.parse('http://192.168.0.199:8080/authentication-check');
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
      } else {
        return null;
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

Future<String?> checkNickNameServer(data) async {
  final url = Uri.parse('http://192.168.0.199:8080/nickname');
  final headers = {'Content-Type': 'application/json'};

  try {
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      var jsonData = response.body;
      print(jsonData);
      if (jsonData == 'ok') {
        return jsonData;
      } else {
        return null;
      }
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  } catch (error) {
    print('네트워크 오류: $error');
  }
}

Future<String?> AccountRemove(data) async {
  final url = Uri.parse('http://192.168.0.199:8080/remove');
  final headers = {'Content-Type': 'application/json'};

  try {
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      var jsonData = response.body;
      print(jsonData);
      if (jsonData == 'ok') {
        return jsonData;
      } else {
        return null;
      }
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  } catch (error) {
    // 네트워크 오류 발생
    print('네트워크 오류: $error');
  }
}

Future<String?> contentSend(data, imageFile) async {
  final url = Uri.parse('http://192.168.0.199:8080/post/submit');
  var request = http.MultipartRequest('POST', url); 
  var multipartFile = await http.MultipartFile.fromPath('file', imageFile.path);
  try {
    request.fields.addAll(data);
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonData = await response.stream.bytesToString();
      if(jsonData == 'ok'){
        return 'ok';
      }else{
        return null;
      }
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  } catch (error) {
    // 네트워크 오류 발생
    print('네트워크 오류: $error');
  }
}

Future<dynamic> mainPageData(email) async {
  final url = Uri.parse('http://192.168.0.199:8080/main/recommend');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(email));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return jsonData;
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  } catch (error) {
    // 네트워크 오류 발생
    print('네트워크 오류: $error');
  }
}

Future<dynamic> profileData(email) async {
  final url = Uri.parse('http://192.168.0.199:8080/profile');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(email));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return jsonData;
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  } catch (error) {
    // 네트워크 오류 발생
    print('네트워크 오류: $error');
  }
}

Future<dynamic> profileViewData(email) async {
  final url = Uri.parse('http://192.168.0.199:8080/profile/view');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(email));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return jsonData;
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  } catch (error) {
    print('네트워크 오류: $error');
  }
}

Future<String?> profileEdit(data, imagePath) async {
  final url = Uri.parse('http://192.168.0.199:8080/profile/set');
  final headers = {'Content-Type': 'application/json'};
  var request = http.MultipartRequest('POST', url); 

  if(imagePath == ''){
    try{
      data['basicImage'] = 'true';
      request.fields.addAll(data);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var jsonData = await response.stream.bytesToString();
        if(jsonData == 'ok'){
          return 'ok';
        } else {
          return null;
        }
      } else {
        print('요청 실패: ${response.statusCode}');
      }

    } catch(error) {
      print('네트워크 오류: $error');
    }
  } else{
    var multipartFile = await http.MultipartFile.fromPath('file', imagePath);
    try{
      request.fields.addAll(data);
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var jsonData = await response.stream.bytesToString();
        if(jsonData == 'ok'){
          return 'ok';
        } else {
          return null;
        }
      } else {
        print('요청 실패: ${response.statusCode}');
      }

    } catch(error) {
      print('네트워크 오류: $error');
    }
  }
}

