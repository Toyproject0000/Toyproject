
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
  late bool genderState;
  
  @override
  void initState() {
    genderState = widget.currentGender == null ? false : widget.currentGender!;
    super.initState();
  }

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
                  genderState = true;
                });
                widget.ChangeGender(genderState);

              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    genderState == true ? Colors.blue : Colors.white,
              ),
              child: Text(
                '남성',
                style: TextStyle(
                  color: genderState == true ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  genderState = false;
                });
                widget.ChangeGender(genderState);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: genderState == false
                      ? Colors.blue
                      : Colors.white),
              child: Text(
                '여성',
                style: TextStyle(
                  color: genderState == false ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}