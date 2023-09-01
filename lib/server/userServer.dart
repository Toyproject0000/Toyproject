import 'dart:convert';
import 'package:http/http.dart' as http;


Future<dynamic> userBlock(data) async {
  final url = Uri.parse('http://192.168.0.201:8080/block/user');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return jsonData;
    } else {
      print('요청 실패: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    // 네트워크 오류 발생
    print('네트워크 오류: $error');
  }
}

Future<dynamic> userReport(data) async {
  final url = Uri.parse('http://192.168.0.201:8080/block/user');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return jsonData;
    } else {
      print('요청 실패: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    // 네트워크 오류 발생
    print('네트워크 오류: $error');
  }
}

Future<dynamic> accountInformation(data) async {
  final url = Uri.parse('http://192.168.0.201:8080/block/user');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.post(url, headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return jsonData;
    } else {
      print('요청 실패: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    // 네트워크 오류 발생
    print('네트워크 오류: $error');
  }
}