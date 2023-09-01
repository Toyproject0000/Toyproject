import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({required this.text, required this.onPresse ,super.key});
  final String text;
  final Function onPresse;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPresse(),
      child: Container(
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
      ),
    );
  }
}