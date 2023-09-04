import 'package:flutter/cupertino.dart';

class OtherUserProfile extends StatefulWidget {

  final String nickname;

  const OtherUserProfile({
    required this.nickname,

    super.key});

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}