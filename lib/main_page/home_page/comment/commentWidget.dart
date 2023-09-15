import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_dongne/provider/comment_provider.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) {
        return Provider.of<CommentProvider>(context).allComment;
      },
    );
  }
}