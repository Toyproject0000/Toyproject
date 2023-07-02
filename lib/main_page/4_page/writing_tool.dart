// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;
//
//
// class CustomToolbar extends quill.QuillToolbar {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: ButtonBar(
//         alignment: MainAxisAlignment.start,
//         children: <Widget>[
//           // Bold 버튼
//           if (showBoldButton)
//             QuillIconButton(
//               icon: Icons.format_bold,
//               highlightElevation: 0.0,
//               onPressed: toggleBold,
//               tooltip: 'Bold',
//             ),
//
//           // Italic 버튼
//           if (showItalicButton)
//             QuillIconButton(
//               icon: Icons.format_italic,
//               highlightElevation: 0.0,
//               onPressed: toggleItalic,
//               tooltip: 'Italic',
//             ),
//
//           // Underline 버튼
//           if (showUnderLineButton)
//             QuillIconButton(
//               icon: Icons.format_underline,
//               highlightElevation: 0.0,
//               onPressed: toggleUnderline,
//               tooltip: 'Underline',
//             ),
//
//           // 커스텀 버튼 등 추가 가능
//           // ...
//
//         ],
//       ),
//     );
//   }
// }