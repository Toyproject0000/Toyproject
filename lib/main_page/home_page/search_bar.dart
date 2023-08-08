import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search_Page_bar extends StatefulWidget {
  const Search_Page_bar({super.key});

  static const routeName = '/Search_Page_bar';

  @override
  State<Search_Page_bar> createState() => _Search_Page_barState();
}

class _Search_Page_barState extends State<Search_Page_bar> {

  TextEditingController textController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        leadingWidth: 30,
        title: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          padding: EdgeInsets.symmetric(horizontal: 15,),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Icon(Icons.search),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child: TextFormField(
                controller: textController,
                focusNode: _focusNode,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    hintText: '검색',
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none),
              )),
            ],
          ),
        ),
      ),
    );
  }
}