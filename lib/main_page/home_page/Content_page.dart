import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class ShowaContents extends StatefulWidget {
  const ShowaContents({super.key});
  static const routeName = '/ContentPage';

  @override
  State<ShowaContents> createState() => _ShowaContentsState();
}

class _ShowaContentsState extends State<ShowaContents> {
  late String PostingContents;
  bool activationThumb = false;
  
  void buttonshitofComment(){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0), // 둥글게 만드는 모서리 반지름 설정
    ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 4/5,
          child: ListView(),
        );
      }
    );
  }
  

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ContentArguments;
    PostingContents = args.content.replaceAll('<p>', '<p style="font-size : 50px;">');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Row(
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    activationThumb = !activationThumb;
                  });
                },
                child: activationThumb == false ? Icon(Icons.thumb_up_alt_outlined, color: Colors.black,) : 
                  Icon(Icons.thumb_up, color: Colors.blue,)
                ),
            ],
          ) ,
          Row(
            children: [
              InkWell(onTap: (){buttonshitofComment();}, child: Icon(Icons.mode_edit_outline_outlined,),),
            ],
          )
        ]),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.more_horiz))
        ],
      ),
      body: InAppWebView(
        initialData: InAppWebViewInitialData(
          data: '''
            $PostingContents
          ''', encoding: 'utf-8',
        ),
      )
    );
  }
}

class ContentArguments {
  final String content;

  ContentArguments(this.content);
}