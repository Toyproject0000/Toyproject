// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class Detailed extends StatefulWidget {
//   const Detailed(this.showLineMenu, this.linekey,{Key? key}) : super(key: key);
//
//   final Function(BuildContext context) showLineMenu;
//   final GlobalKey linekey;
//
//   @override
//   State<Detailed> createState() => _DetailedState();
// }
//
// class _DetailedState extends State<Detailed> {
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //     widget.showLineMenu(context);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return GestureDetector(
//       key: widget.linekey,
//       onTap: () {
//         widget.showLineMenu(context);
//       },
//       child: RawKeyboardListener(
//         focusNode: FocusNode(),
//         onKey: (event) {
//           if (event is RawKeyDownEvent &&
//               event.logicalKey == LogicalKeyboardKey.backspace) {}
//         },
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 10),
//           child: Image.asset(
//             'image/line1.png',
//           ),
//         ),
//       ),
//     );
//   }
// }
//
