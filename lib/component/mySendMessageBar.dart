import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySendMessageBar extends StatelessWidget {
  const MySendMessageBar({required this.onTap, required this.textController, this.textfocusNode ,super.key});
  
  final TextEditingController textController;
  final Function() onTap;

  final FocusNode? textfocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              focusNode: textfocusNode,
              controller: textController,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ) 
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ) 
                ),
                hintText: '메세지를 입력해주세요.'
              ),
              cursorColor: Colors.blue,
            )
          ),
          IconButton(
            onPressed:() => onTap(),
            icon: Icon(Icons.send, color: Colors.blue,),
          )
        ],
      ),
    
    );
  }
}