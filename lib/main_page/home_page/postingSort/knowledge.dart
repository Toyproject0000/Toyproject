import 'package:flutter/cupertino.dart';

class KnowledgePosts extends StatefulWidget {
  const KnowledgePosts({super.key});

  @override
  State<KnowledgePosts> createState() => _KnowledgePostsState();
}

class _KnowledgePostsState extends State<KnowledgePosts> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('knowledgePosts'),
    );
  }
}