import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowaContents extends StatefulWidget {
  const ShowaContents({super.key});
  static const routeName = '/ContentPage';

  @override
  State<ShowaContents> createState() => _ShowaContentsState();
}

class _ShowaContentsState extends State<ShowaContents> {
  late String PostingContents;
  bool activationThumb = false;
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadFlutterAsset('contents_web/contents.html');


  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ContentArguments;
    PostingContents = args.content;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          InkWell(
            onTap: (){
              setState(() {
                activationThumb = !activationThumb;
              });
            },
            child: activationThumb == false ? Icon(Icons.thumb_up_alt_outlined, color: Colors.black,) : 
              Icon(Icons.thumb_up, color: Colors.blue,)
            ) ,
          InkWell(onTap: (){}, child: Icon(Icons.mode_edit_outline_outlined,),)
        ]),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.more_horiz))
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

class ContentArguments {
  final String content;

  ContentArguments(this.content);
}