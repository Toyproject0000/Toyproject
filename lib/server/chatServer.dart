import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> chattingMainPageData(nickname) async {
  final url = Uri.parse('http://192.168.0.201:8080/message/findAll');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(nickname));
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

Future<dynamic> chattingSearchPageData(nickname) async {
  final url = Uri.parse('http://192.168.0.201:8080/message/search');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(nickname));
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

Future<dynamic> aConversationWithaParticularPerson(sendUser) async {
  final url = Uri.parse('http://192.168.0.201:8080/message/user');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(sendUser));
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

Future<dynamic> chattingContentSearch(data) async {
  final url = Uri.parse('http://192.168.0.201:8080/message/search');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(data));
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

Future<dynamic> sendChattingContent(data) async {
  final url = Uri.parse('http://192.168.0.201:8080/message/send');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      var jsonData = response.body;
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

Future<String?> deleteChatting(data) async {

  final url = Uri.parse('http://192.168.0.201:8080/message/deleteAll');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      print(jsonData);
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

Future<String?> ServerResponseOKTemplate(address, data) async {
  final url = Uri.parse('http://192.168.0.201:8080${address}');

  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      print(jsonData);
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

Future<dynamic> ServerResponseJsonDataTemplate(address, data) async {
  
  final url = Uri.parse('http://192.168.0.201:8080${address}');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      if(jsonData != 'cancel'){
        return jsonDecode(jsonData);
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

Future<String?> ServerSendImageDataTemplate(address, data, imagePath) async {
  final url = Uri.parse('http://192.168.0.201:8080${address}');
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
