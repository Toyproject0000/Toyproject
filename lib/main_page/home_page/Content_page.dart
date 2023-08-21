import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:smart_dongne/main_page/home_page/Comment_page.dart';

class ShowaContents extends StatefulWidget {
  const ShowaContents({super.key});
  static const routeName = '/ContentPage';

  @override
  State<ShowaContents> createState() => _ShowaContentsState();
}

class _ShowaContentsState extends State<ShowaContents> {
  late String PostingContents;
  bool activationThumb = false;
  bool IconColer = false;

  String webviewHtmlCode = '''
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
  ''';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ContentArguments;
    PostingContents = webviewHtmlCode + args.content;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        activationThumb = !activationThumb;
                      });
                    },
                    child: activationThumb == false
                        ? Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.black,
                          )
                        : Icon(
                            Icons.thumb_up,
                            color: Colors.blue,
                          )),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, CommentPage.routeName);
                  },
                  child: Icon(
                    Icons.mode_edit_outline_outlined,
                  ),
                ),
              ],
            )
          ]),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          child: InkWell(onTap: () {}, child: Text('신고'))),
                      PopupMenuItem(
                          child: InkWell(onTap: () {}, child: Text('차단')))
                    ])
          ],
        ),
        body: InAppWebView(
          initialData: InAppWebViewInitialData(
            data: '''
            $PostingContents
          ''',
            encoding: 'utf-8',
          ),
        ));
  }
}

class ContentArguments {
  final String content;

  ContentArguments(this.content);
}
