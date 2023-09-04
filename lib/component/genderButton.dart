import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyGenderButton extends StatefulWidget {
  MyGenderButton({required this.man ,super.key});

  bool man;

  @override
  State<MyGenderButton> createState() => _MyGenderButtonState();
}

class _MyGenderButtonState extends State<MyGenderButton> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.man = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    widget.man ? Colors.blue : Colors.white,
              ),
              child: Text(
                '남성',
                style: TextStyle(
                  color: widget.man ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.man = false;
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: widget.man == false
                      ? Colors.blue
                      : Colors.white),
              child: Text(
                '여성',
                style: TextStyle(
                  color: widget.man ? Colors.grey : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}