import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading {
  final BuildContext context;
  Loading({required this.context});

  void showLoadingProgressIndicatior() async {
    return showDialog(
      context: context,
       builder: (context){
        return Center(
          child: CircularProgressIndicator(color: Colors.blue,),
        );
      });
  }
}