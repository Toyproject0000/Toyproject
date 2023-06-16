import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric( horizontal: 10),
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: Colors.grey,
                  width: 1.0
                ),
              ),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: '제목을 입력하시오',
                focusedBorder: InputBorder.none,
              ),
            )
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey,
                    width: 2.0
                ),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(Icons.image, size: 35,),
                    Text('사진')
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.density_large, size: 35,),
                    Text('구분선'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.format_bold, size: 35,),
                    Text('굵기'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.format_size, size: 35,),
                    Text('크기'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.format_list_numbered, size: 35,),
                    Text('번호'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.format_bold, size: 35,),
                    Text('굵기'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
