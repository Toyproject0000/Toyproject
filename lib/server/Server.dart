import 'package:http/http.dart' as http;
import 'dart:convert';


Future<dynamic> loginSendData(address ,data) async {
  final url = Uri.parse('http://192.168.0.198:8080${address}');
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

Future<String?> ServerResponseOKTemplate(address, data) async {
  final url = Uri.parse('http://192.168.0.198:8080${address}');
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

Future<dynamic> ServerResponseJsonDataTemplate(address, data) async {
  final url = Uri.parse('http://192.168.0.198:8080${address}');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      if(jsonData != 'cancel'){
        final decodeJsonData = jsonDecode(jsonData);
        return decodeJsonData;
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
  print(data);
  final url = Uri.parse('http://192.168.0.198:8080${address}');
  var request = http.MultipartRequest('POST', url); 
  if(imagePath == ''){
    try{
      data['basicImage'] = 'true';
      request.fields.addAll(data);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var jsonData = await response.stream.bytesToString();
        print(jsonData);
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
