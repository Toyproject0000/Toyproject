import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Detailed extends StatefulWidget {
  const Detailed(this.index,this.addLine,  {Key? key}) : super(key: key);

  final int index;
  final Function(int numberindex) addLine;

  @override
  State<Detailed> createState() => _DetailedState();
}

class _DetailedState extends State<Detailed> {

  @override
  Widget build(BuildContext context) {

    List<Widget?> detailedTools = [
      null,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              int numberindex = 0;
              widget.addLine(numberindex);
            },
            icon: Icon(Icons.density_large),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.raw_on_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.youtube_searched_for_outlined),
          ),
          IconButton(
              onPressed: () {},
              icon: FaIcon(FontAwesomeIcons.pencil)
          )
        ],
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: detailedTools[widget.index],
    );
  }
}

