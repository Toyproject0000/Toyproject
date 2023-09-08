import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubsribileWidget extends StatefulWidget {
  SubsribileWidget({required this.boolfactor, required this.onTap ,super.key});

  bool boolfactor;
  Function(bool boolfactor) onTap;

  @override
  State<SubsribileWidget> createState() => _SubsribileWidgetState();
}

class _SubsribileWidgetState extends State<SubsribileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          widget.boolfactor = !widget.boolfactor;
        });
        widget.onTap(widget.boolfactor);
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width/2 - 20,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.boolfactor == false ? Colors.blue : Colors.indigoAccent[400],
        ),
        child: Text( widget.boolfactor == false ? '구독' : '구독 중', 
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
    );
  }
}