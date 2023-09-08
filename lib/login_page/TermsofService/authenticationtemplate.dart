import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_dongne/server/Server.dart';

class authenticationWidget {
  // 생성자들
  final int number;
  final String email;
  final BuildContext context;

  final List<String> RequestString = ['인증번호 요청', '인증번호 확인'];
  final List<String> hintTextContent = ['이메일 입력', '인증번호 입력'];

  authenticationWidget(this.number, this.context,{this.email = 'empty'});
  TextEditingController controller = TextEditingController();

  void ServerRequest() async {
    if(number == 0){
      final data = {'id' : controller.text};
      final response = await ServerResponseOKTemplate('/authentication', data);
      if(response != null){}
    }
  }

  Container InputEmailWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintTextContent[number],
                border: InputBorder.none,
                focusedBorder: InputBorder.none
              ),
            ),

          ),
          TextButton(
            onPressed: (){
              ServerRequest();
            },
            child: Text(RequestString[number], style: TextStyle(color: Colors.blue),)
          )
        ],
      ),
    );
  }

}