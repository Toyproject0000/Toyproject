import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> postLike(data) async {
  print(data);
  final url = Uri.parse('http://192.168.0.199:8080/post-like/add');
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
    print('네트워크 오류: $error');
  }
}

Future<String?> postUnLike(data) async {
  final url = Uri.parse('http://192.168.0.199:8080/post-like/remove');
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
    print('네트워크 오류: $error');
  }
}
