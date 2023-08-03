import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeAndPost extends StatefulWidget {
  const LikeAndPost({super.key});

  static const routeName = '/LikeAndPost';

  @override
  State<LikeAndPost> createState() => _LikeAndPostState();
}

class _LikeAndPostState extends State<LikeAndPost> {
  List SettingRange = ['모든 사람', '글쓴이만', '해제'];
  
  String likecurrentValue = '모든 사람';
  String commentsCurrentVale = '모든사람';
  String likethecomments = '모든사람';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text('알림'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '좋아요',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                RadioListTile(
                  activeColor: Colors.blue,
                  title: Text(SettingRange[0]),
                  value: SettingRange[0],
                  groupValue: likecurrentValue,
                  onChanged: (value) {
                    setState(() {
                      likecurrentValue = value;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: Colors.blue,
                  title: Text(SettingRange[1]),
                  value: SettingRange[1],
                  groupValue: likecurrentValue,
                  onChanged: (value) {
                    setState(() {
                      likecurrentValue = value;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: Colors.blue,

                  title: Text(SettingRange[2]),
                  value: SettingRange[2],
                  groupValue: likecurrentValue,
                  onChanged: (value) {
                    setState(() {
                      likecurrentValue = value;
                    });
                  },
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 30,
                ),
                Text(
                  '댓글',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                RadioListTile(
                  activeColor: Colors.blue,
                  title: Text(SettingRange[0]),
                  value: SettingRange[0],
                  groupValue: commentsCurrentVale,
                  onChanged: (value) {
                    setState(() {
                      commentsCurrentVale = value;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: Colors.blue,
                  title: Text(SettingRange[1]),
                  value: SettingRange[1],
                  groupValue: commentsCurrentVale,
                  onChanged: (value) {
                    setState(() {
                      commentsCurrentVale = value;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: Colors.blue,

                  title: Text(SettingRange[2]),
                  value: SettingRange[2],
                  groupValue: commentsCurrentVale,
                  onChanged: (value) {
                    setState(() {
                      commentsCurrentVale = value;
                    });
                  },
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 30,
                ),
                Text(
                  '댓글 좋아요',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                RadioListTile(
                  activeColor: Colors.blue,
                  title: Text(SettingRange[0]),
                  value: SettingRange[0],
                  groupValue: likethecomments,
                  onChanged: (value) {
                    setState(() {
                      likethecomments = value;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: Colors.blue,
                  title: Text(SettingRange[1]),
                  value: SettingRange[1],
                  groupValue: likethecomments,
                  onChanged: (value) {
                    setState(() {
                      likethecomments = value;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: Colors.blue,
                  title: Text(SettingRange[2]),
                  value: SettingRange[2],
                  groupValue: likethecomments,
                  onChanged: (value) {
                    setState(() {
                      likethecomments = value;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
