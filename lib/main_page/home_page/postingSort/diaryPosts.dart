import 'package:flutter/cupertino.dart';

class DiaryPosts extends StatefulWidget {
  const DiaryPosts({super.key});

  @override
  State<DiaryPosts> createState() => _DiaryPostsState();
}

class _DiaryPostsState extends State<DiaryPosts> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const Text('diray'),
    );
  }
}