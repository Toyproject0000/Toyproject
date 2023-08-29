import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthenticationTextFormField extends StatelessWidget {
  const AuthenticationTextFormField(
    {super.key,
    required this.hintText,
    required this.requestMethod,
    required this.controller,
    required this.sendData
  });
  final String hintText;
  final String requestMethod;
  final TextEditingController controller;
  final Function() sendData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey)
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hintText,
            ),
            cursorColor: Colors.blue,
          )),
          TextButton(
            onPressed: (){
              if(controller.text.length != 0){
                sendData();
              }
            },
            child: Text(requestMethod, style: TextStyle(color: Colors.blue),)
          ),
        ],
      ),
    );
  }
}