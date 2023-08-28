import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  static const routeName = '/CommentPage';

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController _commetTextController = TextEditingController();
  bool ActivateButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '댓글',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  children: [],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 1))),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        if (value == '') {
                          setState(() {
                            ActivateButton = false;
                          });
                        } else {
                          setState(() {
                            ActivateButton = true;
                          });
                        }
                      },
                      cursorColor: Colors.blue,
                      controller: _commetTextController,
                      decoration: InputDecoration(
                          hintText: '댓글을 입력하시오.',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          )),
                    ),
                  ),
                  IconButton(
                      onPressed: ActivateButton == false ? null : () {},
                      icon: Icon(
                        Icons.send,
                        color: ActivateButton == false ? Colors.grey : Colors.blue,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
