import 'package:http/http.dart' as http;
import 'dart:convert';

void sendData() async {
  final url = Uri.parse('http://localhost:8080/join');
  final headers = {'Content-Type': 'application/json'};
  final data = jsonEncode({'id': 'test', 'password': 'test'});

  try {
    final response = await http.post(url, headers: headers, body: data);

    if (response.statusCode == 200) {
      // 요청이 성공적으로 처리됨
      print('요청 성공');
    } else {
      // 요청이 실패하거나 오류가 발생함
      print('요청 실패: ${response.statusCode}');
    }
  } catch (error) {
    // 네트워크 오류 발생
    print('네트워크 오류: $error');
  }
}