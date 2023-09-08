import 'package:flutter/cupertino.dart';

class NovelPosts extends StatefulWidget {
  const NovelPosts({super.key});

  @override
  State<NovelPosts> createState() => _NovelPostsState();
}

class _NovelPostsState extends State<NovelPosts> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('novel Page'),);
  }
}