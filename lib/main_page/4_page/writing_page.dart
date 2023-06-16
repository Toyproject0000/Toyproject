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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.cancel_outlined,
                          size: 40,
                        ),
                      ),
                      Text(
                        '새 게시물',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '다음',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: TextFormField(
                    maxLength: 20,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: '제목',
                      focusedBorder: InputBorder.none,
                      counterText: '',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.image,
                          size: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.density_large,
                          size: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.format_bold,
                          size: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.format_size,
                          size: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.emoji_symbols_rounded,
                          size: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.color_lens,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: '본문',
                      focusedBorder: InputBorder.none,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
