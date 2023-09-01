import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog(
      {required this.content,
      required this.title,
      required this.actionsWidget,
      super.key});
  final Text content;
  final String? title;
  final Widget? actionsWidget;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: title == null ? null : Text(title!),
        content: content,
        actions: actionsWidget == null ? null : [
          actionsWidget!
        ],
      );
  }
}
