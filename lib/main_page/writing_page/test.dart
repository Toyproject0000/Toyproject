

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;



class MyWidget extends StatelessWidget {
  MyWidget({required this.quillContrller ,required this.document, super.key});
  final quill.QuillController quillContrller;
  // final quill.Delta document;
  final String document;

  late quill.QuillController _controller;

  @override
  Widget build(BuildContext context) {
    quill.Delta deltaData = quill.Delta()..insert(document);

    quill.Document documentData = quill.Document.fromDelta(deltaData);
    _controller = quill.QuillController(document: documentData, selection: TextSelection.collapsed(offset: 0));

    return Scaffold(
      appBar: AppBar(
        title: Text('테스트 입니다.'),
      ),
      body: quill.QuillEditor.basic(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        controller: _controller,
        readOnly: true,
      ),
    );
  }
}