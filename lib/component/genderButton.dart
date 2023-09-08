import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyGenderButton extends StatefulWidget {
  MyGenderButton({required this.currentGender ,required this.ChangeGender ,super.key});

  bool? currentGender;
  final Function(bool man) ChangeGender;

  @override
  State<MyGenderButton> createState() => _MyGenderButtonState();
}

class _MyGenderButtonState extends State<MyGenderButton> {
  // bool man = false;
  @override
  Widget build(BuildContext context) {
    bool man = widget.currentGender == null ? false : widget.currentGender!;
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
                  man = true;
                });
                widget.ChangeGender(man);

              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    man ? Colors.blue : Colors.white,
              ),
              child: Text(
                '남성',
                style: TextStyle(
                  color: man ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  man = false;
                });
                widget.ChangeGender(man);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: man == false
                      ? Colors.blue
                      : Colors.white),
              child: Text(
                '여성',
                style: TextStyle(
                  color: man ? Colors.grey : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}