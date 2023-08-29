import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySelfWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  final TextEditingController birthdayController;

  const MySelfWidget({
    required this.nameController,
    required this.phoneNumberController,
    required this.birthdayController,
    super.key});

  @override
  Widget build(BuildContext context) {
    
    List<TextEditingController> controllerList = [nameController, phoneNumberController, birthdayController];
    List<String> hintText = ['이름', '잔화번호', '생년월일 8자리'];
    return Column(
      children: [
        for(int i = 0; i < 3; i++)
        Column(
          children: [
            TextFormField(
              cursorColor: Colors.blue,
              controller: controllerList[i],
              decoration: InputDecoration(
                hintText: hintText[i],
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.grey
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.grey
                  )
                )
              ),
            ),
            SizedBox(height: 3,),
          ],
        ),
      ],
    );
  }
}