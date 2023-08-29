import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool? type;


  const MyTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.type
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters : type == null ? null : [FilteringTextInputFormatter.digitsOnly],
      cursorColor: Colors.blue,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        focusColor: Colors.grey,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1
          )
        )
      ),
    );
  }
}