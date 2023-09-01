import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({required this.text ,super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blue
      ),
      child: Center(
        child: Text(
          text, style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}