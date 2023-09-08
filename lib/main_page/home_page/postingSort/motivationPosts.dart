import 'package:flutter/cupertino.dart';

class MotivationPosts extends StatefulWidget {
  const MotivationPosts({super.key});

  @override
  State<MotivationPosts> createState() => _MotivationPostsState();
}

class _MotivationPostsState extends State<MotivationPosts> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('동기부여'),
    );
  }
}