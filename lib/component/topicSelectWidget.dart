import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicSelectWidget extends StatefulWidget {
  TopicSelectWidget({
    required this.SelectTopic,
     required this.ChangeTopic ,
     super.key});
  String? SelectTopic;
  final Function(String topic) ChangeTopic;

  @override
  State<TopicSelectWidget> createState() => _TopicSelectWidgetState();
}

class _TopicSelectWidgetState extends State<TopicSelectWidget> {
  final List<String> topics = ['소설', '일기', '동기부여', '지식'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.grey, width: 1.0),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // select topic 
          Text(
            '주제선택',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.SelectTopic = topics[0];
                    });
                    widget.ChangeTopic(topics[0]);
                  },
                  child: Text(
                    topics[0],
                    style: TextStyle(
                        color: widget.SelectTopic != topics[0]
                            ? Colors.grey
                            : Colors.blue),
                  ),
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.SelectTopic = topics[1];
                    });
                    widget.ChangeTopic(topics[1]);
                  },
                  child: Text(
                    '일기',
                    style: TextStyle(
                        color: topics[1] != widget.SelectTopic 
                            ? Colors.grey
                            : Colors.blue),
                  ),
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                   setState(() {
                      widget.SelectTopic = topics[2];
                    });
                    widget.ChangeTopic(topics[2]);

                  },
                  child: Text(
                    '동기부여',
                    style: TextStyle(
                        color: topics[2] != widget.SelectTopic 
                            ? Colors.grey
                            : Colors.blue),
                  ),
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.SelectTopic = topics[3];
                    });
                    widget.ChangeTopic(topics[3]);
                  },
                  child: Text(
                    '지식',
                    style: TextStyle(
                        color: topics[3] != widget.SelectTopic 
                            ? Colors.grey
                            : Colors.blue),
                  ),
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}