import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Widget?> detailedTools = [
  null,
  Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey,
        width: 1,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
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
          onPressed: (){},
          icon: FaIcon(FontAwesomeIcons.pencil)
        )
      ],
    ),
  ),
];
