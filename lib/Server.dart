import 'package:http/http.dart' as http;

void fetchData() async {
  var url = Uri.parse('http://10.0.2.2:8080/join');

  // GET 요청을 보냅니다.
  var response = await http.get(url);

  if (response.statusCode == 200) {
    // 성공적으로 응답을 받았습니다.
    print('Response: ${response.body}');
  } else {
    // 요청이 실패했습니다.
    print('Failed to fetch data');
  }
}

void sendData(data) async {
  var url = Uri.parse('http://10.0.2.2:8080/join');


  var response = await http.post(url, body: data);

  if (response.statusCode == 200) {
    // 성공적으로 요청을 보냈습니다.
    print('Data sent successfully');
  } else {
    // 요청이 실패했습니다.
    print('Failed to send data');
  }
}